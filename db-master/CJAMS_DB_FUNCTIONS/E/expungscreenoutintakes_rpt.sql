DROP FUNCTION IF EXISTS cjams.expungscreenoutintakes_rpt(date);

CREATE OR REPLACE FUNCTION cjams.expungscreenoutintakes_rpt(
	fordate date)
RETURNS TABLE(cpsid character varying, intakeserviceid uuid, cpsdate date, status character varying) 
    LANGUAGE 'plpgsql'
    VOLATILE 
    COST 100
    ROWS 1000
AS $BODY$

BEGIN

	DROP TABLE IF EXISTS tmp_expungscreenout;
	-- ## HOLD ESTIMATED RECORDS
	CREATE TEMP TABLE tmp_expungscreenout
				  ( cpsid 					character varying
				  , intakeserviceid 		uuid
				  , cpsdate  				date
				  , status					character varying
				  );
				  
	WITH  APROV AS (SELECT	DISTINCT t.teamid, c.countyname, r.objectid, 
						r.insertedon::date APPROVAL_REQUEST_DATE, r.updatedon::date SUPERVISOR_APPROVAL_DT
				FROM	routing r 
						LEFT JOIN team t ON t.teamid = r.teamid
						LEFT JOIN county c ON c.countyid = t.countyid::uuid
				WHERE	r.eventcode ='INTR')
	, SCROUT AS (SELECT   ir.intakeserviceid
						, ir.servicerequestnumber 
						, COALESCE(ir.intakedaterecieved, ir.reporteddate) reporteddate
						, (CASE	WHEN isdm.screeninoverrideflag = 1 THEN 'SCREEN-IN'
								WHEN isdm.isir OR isdm.isar THEN 'SCREEN-IN'
								WHEN ir.actiontype in ('C','IR','AR') OR ir.actiontype IS NULL
										AND (isdm.noscreeninoverridesflag = 1 
										OR isdm.isfinalscreenin = false 
										OR isdm.newnoncpsrefflag = 1)
								THEN 'SCREEN-OUT' END) AS finaldecision
				FROM 	intakeservicerequest ir
						LEFT JOIN intakeservicerequestsdm isdm ON ir.intakeserviceid = isdm.intakeserviceid  AND isdm.activeflag = 1
						LEFT JOIN APROV apvr ON apvr.objectid = ir.intakenumber
						LEFT JOIN investigation inv ON  inv.intakeserviceid = ir.intakeserviceid
				WHERE 	ir.reporteddate is not null AND ir.activeflag = 1
						AND COALESCE(ir.intakedaterecieved, ir.reporteddate)::date = (fordate - (2 * INTERVAL '1 years')))
	INSERT INTO tmp_expungscreenout (cpsid, intakeserviceid, cpsdate, status)
	SELECT s.servicerequestnumber, s.intakeserviceid, s.reporteddate, s.finaldecision FROM SCROUT s 
	WHERE finaldecision = 'SCREEN-OUT'  ORDER BY 2;
	
	/*AR CASE EXPUNG OVER 3 YEARS*/
	INSERT INTO tmp_expungscreenout (cpsid, intakeserviceid, cpsdate, status)
	SELECT   ir.servicerequestnumber, ir.intakeserviceid, COALESCE(ir.intakedaterecieved, ir.reporteddate), 'AR EXPUNG' 
	FROM 	intakeservicerequest ir
	WHERE 	ir.reporteddate is not null
			AND LOWER(ir.actiontype) ='ar' AND ir.activeflag = 1
			AND COALESCE(ir.intakedaterecieved, ir.reporteddate)::date = (fordate - (3 * INTERVAL '1 years'))::date ORDER BY 2;
	 
	/*I&R INTAKE EXPUNG OVER 2 YEARS*/
	INSERT INTO tmp_expungscreenout (cpsid, intakeserviceid, cpsdate, status)
	SELECT  ir.servicerequestnumber, ir.intakeserviceid, COALESCE(ir.intakedaterecieved, ir.reporteddate), 'I&R EXPUNG' 
	FROM 	intakeservicerequest ir
			INNER JOIN intakeservicerequesttype rt ON rt.intakeservreqtypeid = ir.intakeservreqtypeid
	WHERE 	ir.reporteddate IS NOT NULL AND ir.activeflag = 1
			AND intakeservreqtypekey = 'Information and Referral'
			AND COALESCE(ir.intakedaterecieved, ir.reporteddate)::date = (fordate - (2 * INTERVAL '1 years'))::date ORDER BY 2;
	
	/*CPS HISTORY EXPUNG OVER 25 YEARS*/
	INSERT INTO tmp_expungscreenout (cpsid, intakeserviceid, cpsdate, status)
	SELECT  ir.servicerequestnumber, ir.intakeserviceid, COALESCE(ir.intakedaterecieved, ir.reporteddate), 'CPS HISTORY EXPUNG' 
	FROM 	intakeservicerequest ir
			INNER JOIN intakeservicerequestservice irs ON ir.intakeserviceid = irs.intakeserviceid
			INNER JOIN  intakeserv ints ON ints.intakeservtypekey = irs.intakeservreqservicekey
	WHERE 	ir.reporteddate IS NOT NULL AND ir.activeflag = 1
			AND ints.intakeservtypekey = 'CPSHC'
			--AND ir.intakenumber = 'I201900556203'
			AND COALESCE(ir.intakedaterecieved, ir.reporteddate)::date = (fordate - (25 * INTERVAL '1 years'))::date ORDER BY 2;
	
-- ## DELETE CPS AR, IF IT HAS OTHER ACTIVER CPS	
	DELETE FROM tmp_expungscreenout tmp WHERE tmp.status = 'AR EXPUNG' AND tmp.intakeserviceid IN
	(SELECT 	DISTINCT s.intakeserviceid 
	FROM	intakeservicerequestactor s 
	WHERE	s.personid IN 
			(SELECT v.personid
			FROM   (SELECT 	sa.personid, sa.intakeserviceid 
					FROM	intakeservicerequestactor sa 
					WHERE	sa.personid IN (SELECT 	DISTINCT isra.personid 
											FROM 	intakeservicerequestactor isra
													INNER JOIN intakeservicerequest ir ON ir.intakeserviceid = isra.intakeserviceid
													INNER JOIN tmp_expungscreenout tmp ON tmp.intakeserviceid = isra.intakeserviceid
											WHERE 	ir.actiontype in ('C','IR','AR') 
													AND isra.intakeservicerequestpersontypekey IN ('LG', 'AM') 
													AND isra.activeflag = 1) 
							AND sa.intakeserviceid IS NOT NULL AND sa.activeflag = 1
					GROUP BY sa.personid, sa.intakeserviceid) v
			GROUP BY v.personid HAVING count(1)>1));
	
	--## RETURN SCREENOUT EXPUNGED PERSONS 
	RETURN QUERY 
	SELECT * FROM tmp_expungscreenout;

END

$BODY$;

