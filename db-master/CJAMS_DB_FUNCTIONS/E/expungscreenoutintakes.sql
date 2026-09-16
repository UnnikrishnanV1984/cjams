DROP FUNCTION IF EXISTS cjams.expungscreenoutintakes(date);

CREATE OR REPLACE FUNCTION cjams.expungscreenoutintakes(fordate date)
 RETURNS TABLE(cpsid character varying, intakeserviceid uuid, cpsdate date, status character varying)
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- Revision(s)
-- 10/01/2020 Vineet Tirodkar - Modification to verify Person's involvement is APS and to remove MD CHESSIE data check
-- 01/28/2021 Vineet Tirodkar - Modification to verify Person's participation in CW Adoption Cases prior to expungement
-- 06/03/2022  Vineet Tirodkar - To add new Do Not Expunge functionality for CPS-AR cases (CDM-22896)  
-- 09/23/2022 Vineet Tirodkar - Type casting fixes and boolean addition error for Aurora DB migration 
-- 02/16/2024 Vineet Tirodkar - Modifications for Expungement Job Performance Fixes (CIDM-8423)
-- 10/30/2025 Manasa Kasula - Modifications for Expungement Job for Sexual Abuse Cases (CIDM-10890)
------------------------------------------------------------------------ 
DECLARE
al_sqlcode integer;
as_error character varying;
BEGIN

	DROP TABLE IF EXISTS tmp_expungscreenout;
	-- ## HOLD ESTIMATED RECORDS
	CREATE TEMP TABLE tmp_expungscreenout
	 ( cpsid character varying
	 , intakeserviceid uuid
	 , cpsdate   date
	 , status character varying
	 , issexualabuse boolean
	 );

	create index Xie1_tmp_expungscreenout on tmp_expungscreenout(intakeserviceid,status); 
	WITH  APROV AS (SELECT DISTINCT t.teamid, c.countyname, r.objectid,
	r.insertedon::date APPROVAL_REQUEST_DATE, r.updatedon::date SUPERVISOR_APPROVAL_DT
	FROM routing r
	LEFT JOIN team t ON t.teamid = r.teamid
	LEFT JOIN county c ON c.countyid = t.countyid::uuid
	WHERE r.eventcode ='INTR')
	, SCROUT AS (SELECT ir.intakeserviceid
	, ir.servicerequestnumber
	, COALESCE(ir.intakedaterecieved, ir.reporteddate) reporteddate
	, (CASE WHEN isdm.screeninoverrideflag = 1 THEN 'SCREEN-IN'
	WHEN coalesce(ir.actiontype, '') in ('IR','AR','C') THEN 'SCREEN-IN'--isdm.isir OR isdm.isar 
	WHEN lower(coalesce(isn.jsondata->'DAType'->'DATypeDetail'->0->>'supDisposition',isn.jsondata->'disposition'->0->>'supDisposition')::varchar) = 'screenout' THEN 'SCREEN-OUT' 
	WHEN ir.actiontype IS NULL -- Sarma: 04/22/2020: Changed to exclude AR and IR
	AND (isdm.noscreeninoverridesflag = 1
	OR isdm.isfinalscreenin = false
	OR isdm.newnoncpsrefflag = 1)
	THEN 'SCREEN-OUT' END) AS finaldecision,
	(CASE WHEN (coalesce(isdm.ismalsa_sexualmolestation, false) = true or coalesce(isdm.ismalsa_sexualact, false) = true 
		or coalesce(isdm.ismalsa_sexualexploitation, false) = true or coalesce(isdm.ismalsa_physicalindicators, false) = true 
		or coalesce(isdm.ismalsa_sex_trafficking, false) = true) then true else false end) as issexualabuse
	FROM intakeservicerequest ir
	LEFT JOIN intakeservicerequestsdm isdm ON ir.intakeserviceid = isdm.intakeserviceid  AND isdm.activeflag = 1
	LEFT JOIN intakesnapshot isn ON isn.intakenumber = ir.intakenumber AND isn.activeflag = 1
	LEFT JOIN APROV apvr ON apvr.objectid = ir.intakenumber
	LEFT JOIN investigation inv ON  inv.intakeserviceid = ir.intakeserviceid
	WHERE ir.reporteddate is not null AND ir.activeflag = 1
		  /* Sarma Bandi 03-25-2020
		 Defect: D-28098 Risk of Harm Intake should not be expunged(Referral ID : 9997894)
	  */
	AND coalesce(isdm.finalrecommrohonlyncpsflag,0) <> 1 -- excluding "ROH cnps only" Intakes
	AND COALESCE(ir.intakedaterecieved, ir.reporteddate)::date = (fordate - (2 * INTERVAL '1 years')))

	-- Intake Screenout Scenario
	INSERT INTO tmp_expungscreenout (cpsid, intakeserviceid, cpsdate, status, issexualabuse)
	SELECT s.servicerequestnumber, s.intakeserviceid, s.reporteddate, s.finaldecision, s.issexualabuse FROM SCROUT s
	WHERE finaldecision = 'SCREEN-OUT' ORDER BY 2;

	/*AR CASE EXPUNG OVER 3 YEARS*/
	INSERT INTO tmp_expungscreenout (cpsid, intakeserviceid, cpsdate, status, issexualabuse)
	SELECT ir.servicerequestnumber,
	ir.intakeserviceid,
	COALESCE(ir.intakedaterecieved, ir.reporteddate),
	'AR EXPUNG', false
	FROM intakeservicerequest ir
	INNER JOIN investigation iv ON iv.intakeserviceid = ir.intakeserviceid
	WHERE ir.reporteddate is not null
	AND LOWER(ir.actiontype) = 'ar'
	AND ir.activeflag = 1
	AND iv.insertedon::date = (fordate - (3 * INTERVAL '1 years'))::date
	-- CDM-22896
	and ( select count(*)
	from cjams.donotexpunge dne
	where dne.intakeserviceid = ir.intakeserviceid
	and dne.donotexpunge = true
	and dne.activeflag = 1
	) = 0
	ORDER BY 2;	
	/* Old queary
	SELECT   ir.servicerequestnumber, ir.intakeserviceid, COALESCE(ir.intakedaterecieved, ir.reporteddate), 'AR EXPUNG'
	FROM intakeservicerequest ir
	INNER JOIN investigation iv ON iv.intakeserviceid = ir.intakeserviceid
	WHERE ir.reporteddate is not null
	AND LOWER(ir.actiontype) ='ar' AND ir.activeflag = 1
	AND iv.insertedon::date = (fordate - (3 * INTERVAL '1 years'))::date ORDER BY 2;
	--AND COALESCE(ir.intakedaterecieved, ir.reporteddate)::date = (fordate - (3 * INTERVAL '1 years'))::date ORDER BY 2;
	*/

	/*I&R INTAKE EXPUNG OVER 2 YEARS*/
	INSERT INTO tmp_expungscreenout (cpsid, intakeserviceid, cpsdate, status, issexualabuse)
	SELECT  ir.servicerequestnumber, ir.intakeserviceid, COALESCE(ir.intakedaterecieved, ir.reporteddate), 'I&R EXPUNG', false
	FROM intakeservicerequest ir
	INNER JOIN intakeservicerequesttype rt ON rt.intakeservreqtypeid = ir.intakeservreqtypeid
	WHERE ir.reporteddate IS NOT NULL AND ir.activeflag = 1
	AND intakeservreqtypekey = 'Information and Referral'
	AND COALESCE(ir.intakedaterecieved, ir.reporteddate)::date = (fordate - (2 * INTERVAL '1 years'))::date ORDER BY 2;

	/*CPS HISTORY EXPUNG OVER 25 YEARS*/
	INSERT INTO tmp_expungscreenout (cpsid, intakeserviceid, cpsdate, status, issexualabuse)
	SELECT  ir.servicerequestnumber, ir.intakeserviceid, COALESCE(ir.intakedaterecieved, ir.reporteddate), 'CPS HISTORY EXPUNG', false
	FROM intakeservicerequest ir
	INNER JOIN intakeservicerequestservice irs ON ir.intakeserviceid = irs.intakeserviceid
	INNER JOIN  intakeserv ints ON ints.intakeservtypekey = irs.intakeservreqservicekey
	WHERE ir.reporteddate IS NOT NULL AND ir.activeflag = 1
	AND ints.intakeservtypekey = 'CPSHC'
	AND COALESCE(ir.intakedaterecieved, ir.reporteddate)::date = (fordate - (25 * INTERVAL '1 years'))::date ORDER BY 2;

	-- ## DELETE RISK OF HARM INTAKES -- Need clarification on deleting risk of harm 
	DELETE FROM tmp_expungscreenout tmp WHERE tmp.intakeserviceid IN
	(SELECT sdm.intakeserviceid
	FROM intakeservicerequestsdm sdm, tmp_expungscreenout tmp
	WHERE sdm.intakeserviceid = tmp.intakeserviceid
	and (sdm.isnegrh_priordeath =true or
	sdm.isnegrh_sexualperpetrator =true or
	sdm.isnegrh_basicneedsunmet =true or  
	sdm.isnegrh_sex_offender =true or
	sdm.isnegrh_risk_dv =true or
	sdm.isnegrh_fatality_can =true or
	sdm.isnegrh_indicated_unsub =true or
	sdm.isnegrh_survivor =true or
	sdm.isnegrh_birth_match =true or
	sdm.isnegrh_sex_trafficking =true ))
	/* GROUP BY sdm.intakeserviceid
	HAVING SUM(sdm.isnegrh_priordeath +
	sdm.isnegrh_sexualperpetrator +
	sdm.isnegrh_basicneedsunmet +
	sdm.isnegrh_sex_offender +
	sdm.isnegrh_risk_dv +
	sdm.isnegrh_fatality_can +
	sdm.isnegrh_indicated_unsub +
	sdm.isnegrh_survivor +
	sdm.isnegrh_birth_match +
	sdm.isnegrh_sex_trafficking )>=1)*/;

	-- ## DELETE CPS AR, IF IT HAS OTHER ACTIVER CPS -- Need to work on this to exclude sexual abuse active flag cases.
	DELETE FROM tmp_expungscreenout tmp WHERE tmp.status = 'AR EXPUNG' AND tmp.intakeserviceid IN
	(SELECT DISTINCT s.intakeserviceid
	FROM intakeservicerequestactor s
	WHERE s.personid IN
	(SELECT v.personid
	FROM   (SELECT sa.personid, sa.intakeserviceid
	FROM intakeservicerequestactor sa
	INNER JOIN intakeservicerequest ir ON ir.intakeserviceid = sa.intakeserviceid
	WHERE sa.personid IN (SELECT DISTINCT isra.personid
	FROM intakeservicerequestactor isra
	INNER JOIN intakeservicerequest ir ON ir.intakeserviceid = isra.intakeserviceid
	INNER JOIN tmp_expungscreenout tmp ON tmp.intakeserviceid = isra.intakeserviceid
	WHERE ir.actiontype in ('C','IR','AR')
	AND isra.intakeservicerequestpersontypekey IN ('LG', 'AM')
	AND isra.activeflag = 1)
	AND sa.intakeserviceid IS NOT NULL AND sa.activeflag = 1
	AND ir.actiontype in ('C', 'IR','AR')
	AND ir.reporteddate > NOW() - (3 * INTERVAL '1 years')
	GROUP BY sa.personid, sa.intakeserviceid) v
	GROUP BY v.personid HAVING count(1)>=1));

	--## PRESERVE CASEHEAD NAME IN INVESTIGATION TABLE
	UPDATE intakeservicerequest iv SET formattedreferralname = v.casehead
	FROM (SELECT isa.intakeserviceid, MAX(p.firstname||COALESCE(' '||p.middlename,'')||' '||p.lastname) casehead
	FROM tmp_expungscreenout tmp
	INNER JOIN intakeservicerequestactor isa ON isa.intakeserviceid = tmp.intakeserviceid
	INNER JOIN person p ON p.personid = isa.personid
	WHERE isa.intakeservicerequestpersontypekey = 'LG'
	GROUP BY isa.intakeserviceid) v
	WHERE v.intakeserviceid = iv.intakeserviceid;

	-- Implementation for Sexual Abuse Expungement 
	DROP TABLE IF EXISTS tmp_expungsexualabusescreenout;
	-- ## HOLD ESTIMATED RECORDS
	CREATE TEMP TABLE tmp_expungsexualabusescreenout
	 ( cpsid character varying
	 , intakeserviceid uuid
	 , cpsdate   date
	 , status character varying
	 , issexualabuse boolean
	 );

	create index Xie1_tmp_expungsexualabusescreenout on tmp_expungsexualabusescreenout(intakeserviceid,status); 

	INSERT INTO tmp_expungsexualabusescreenout (cpsid, intakeserviceid, cpsdate, status, issexualabuse)
	SELECT tes.cpsid, tes.intakeserviceid, tes.cpsdate, tes.status, tes.issexualabuse FROM tmp_expungscreenout tes
	WHERE tes.issexualabuse = true ORDER BY 2;

	SELECT a.al_sqlcode,a.as_error from cjams.expungemaltreatortables('expungscreenoutintakes') a into al_sqlcode, as_error;
	IF al_sqlcode <> 0 THEN
		as_error := as_error  ;
	IF as_error is NULL OR as_error = '' THEN
		as_error := 'Encrypt Expung tables failed for Intake case'  ;
	END IF;
	--SIGNAL p_sp_error ;
	END IF ;

	-- Delete the sexual Abuse cases from the regular expungment flow
	DELETE FROM tmp_expungscreenout tmp WHERE tmp.issexualabuse = true;

	--## EXPUNG ALL  SCREEN-OUT RECORDS for Non Sexual Abuse Cases
	DROP TABLE IF EXISTS tmp_expungperson;
	CREATE TEMP TABLE tmp_expungperson
	 ( personid uuid
	 , intakeserviceid uuid
	 , cpsid   character varying
	 , isinvolvedothercase int
	 , personname character varying
	 , actorid uuid
	 );

	create index Xie1_tmp_expungperson on tmp_expungperson(personid);
	INSERT INTO tmp_expungperson( personid ,intakeserviceid,cpsid, isinvolvedothercase, personname, actorid)
	SELECT  a.personid, a.intakeserviceid, so.cpsid, 0, p.firstname||COALESCE(' '||p.middlename,'')||' '||p.lastname, a.actorid
	FROM actor a
	INNER JOIN person p ON p.personid = a.personid AND p.activeflag = 1
	INNER JOIN tmp_expungscreenout so ON so.intakeserviceid = a.intakeserviceid  and a.activeflag = 1;

	--## UPDATE TEMP TABLE IF THE PERSON INVOLVED IN OTHER CASES
	UPDATE tmp_expungperson t
	SET isinvolvedothercase = 1
	FROM actor a
	WHERE a.personid = t.personid
	AND ( a.intakeserviceid <> t.intakeserviceid
	or
	 a.intakeserviceid is NULL
	)  
	AND a.activeflag = 1;

	UPDATE tmp_expungperson t
	SET isinvolvedothercase = 1
	FROM actor a
	WHERE a.personid = t.personid
	AND a.servicecaseid IS NOT NULL
	AND a.activeflag = 1;

	-- Verify Person's participation in CW Adoption Cases prior to expungement
	update tmp_expungperson t
	set isinvolvedothercase = 1
	from adoptioncaseactor ada
	where ada.personid = t.personid
	and ada.activeflag = 1;

	DELETE FROM tmp_expungperson WHERE isinvolvedothercase = 1;

	-- Commented as CJAMS is now Statewide Live (10/02/2020)
	/*
	--## REMOVE PERSONS INVOVLED IN CHESSIE
	DELETE FROM tmp_expungperson WHERE personid IN (
	SELECT p.personid
	FROM tmp_expungperson tmp
	INNER JOIN person p ON p.personid = tmp.personid
	INNER JOIN tb_chessie_client_participation tb ON (tb.chessie_client_id = p.cjamspid OR tb.cjams_person_id = p.cjamspid)
	AND tb.action_flag <> 'D');
	*/

	--## REMOVE ALL PERSONS HAVING PAYMENT INFORMATION
	DELETE FROM tmp_expungperson t WHERE t.personid IN
	(SELECT  DISTINCT p.personid
	FROM tmp_expungperson tmp
	INNER JOIN person p ON p.personid = tmp.personid
	INNER JOIN tb_payment_detail tb ON tb.client_id = p.cjamspid);

	--## INSERT EXPUNG DATA FOR AUDIT PURPOSE issue inserting data
	INSERT INTO cjams.expungementstaging
	(cjamspid
	, mdm_id
	, cisclientid
	, DateOfExpungement
	, case_number
	, status_flag
	, insertedon
	, ncrypt_firstname
	, ncrypt_middlename
	, ncrypt_lastname
	, ncrypt_dob
	, ncrypt_ssn
	)
	SELECT  p.cjamspid
	, (select personidentifiervalue mdm_id from personidentifier where personid=p.personid and personidentifiertypekey='MDM_ID' LIMIT 1)
	, cisclientid
	, NOW()
	, t.cpsid
	, 0
	, NOW()
	, PGP_SYM_ENCRYPT(p.firstname, 'AES_KEY')
	, PGP_SYM_ENCRYPT(p.middlename, 'AES_KEY')
	, PGP_SYM_ENCRYPT(p.lastname, 'AES_KEY')
	, PGP_SYM_ENCRYPT(p.dob::text, 'AES_KEY')
	, PGP_SYM_ENCRYPT(p.ssnno, 'AES_KEY')
	FROM tmp_expungperson t
	INNER JOIN person p ON p.personid = t.personid AND p.activeflag =  1;

	--## INSERT DATA FOR OUTBOUND MESSAGING
	INSERT INTO cjams.expungementoutbound
	(mdm_id
	, cjamspid
	, cisclientid
	, DateOfExpungement
	, case_number
	, status_flag
	, insertedon
	, updatedon)
	SELECT (select personidentifiervalue mdm_id from personidentifier where personid=p.personid and personidentifiertypekey='MDM_ID' LIMIT 1)
	, p.cjamspid
	, p.cisclientid
	, NOW()
	, t.cpsid
	, 0
	, NOW()
	, NOW()
	FROM tmp_expungperson t
	INNER JOIN person p ON p.personid = t.personid  AND p.activeflag =  1;

	--## EXPUNG ALL INTAKE RELATED RECORDS
	UPDATE intakeservicerequest ir  SET
	 expungementflag=1
	, lastexpungementdate=NOW()
	, activeflag=0
	, updatedby = 'EXPUNG'
	, updatedon = now()
	FROM tmp_expungscreenout s
	WHERE s.intakeserviceid = ir.intakeserviceid AND ir.activeflag = 1;

	UPDATE intakedastatus SET activeflag = 0 WHERE intakenumber IN
	(SELECT  ir.intakenumber
	FROM tmp_expungscreenout so
	INNER JOIN intakeservicerequest ir ON so.intakeserviceid = ir.intakeserviceid);

	UPDATE intakedastaging SET activeflag = 0 WHERE intakenumber IN
	(SELECT  ir.intakenumber
	FROM tmp_expungscreenout so
	INNER JOIN intakeservicerequest ir ON so.intakeserviceid = ir.intakeserviceid);

	--## EXPUNG ACTOR INFO
	UPDATE  intakeservicerequestactor isra SET
	 activeflag = 0
	, spexpungementflag = 1
	, updatedby = 'EXPUNG'
	, updatedon = now()
	,intakeserviceid = NULL
	FROM tmp_expungscreenout T
	WHERE isra.intakeserviceid =  t.intakeserviceid AND isra.activeflag = 1 AND isra.servicecaseid IS NULL;

	/* UPDATE  intakeservicerequestactor isra SET
	 intakeserviceid = NULL
	, updatedon = now()
	FROM tmp_expungscreenout T
	WHERE isra.intakeserviceid =  t.intakeserviceid AND isra.activeflag = 1 AND isra.servicecaseid IS NOT NULL;*/

	UPDATE  actor a SET
	 activeflag = 0
	, spexpungementflag = 1
	, updatedby = 'EXPUNG'
	, updatedon = now()
	,intakeserviceid = NULL
	FROM tmp_expungscreenout T
	WHERE a.intakeserviceid =  t.intakeserviceid AND a.activeflag = 1 AND a.servicecaseid IS NULL;

	/*UPDATE  actor a SET
	 intakeserviceid = NULL
	, updatedon = now()
	FROM tmp_expungscreenout T
	WHERE a.intakeserviceid =  t.intakeserviceid AND a.activeflag = 1 AND a.servicecaseid IS NOT NULL;*/

	--## EXPUNG SDM INFO
	UPDATE intakeservrequestsdmmaltreatment  sm SET
	 activeflag = 0
	, updatedby = 'EXPUNG'
	, updatedon = now()
	FROM intakeservicerequestsdm sdm
	INNER JOIN tmp_expungscreenout s ON s.intakeserviceid = sdm.intakeserviceid
	WHERE sdm.intakeservicerequestsdmid = sm.intakeservicerequestsdmid  AND sm.activeflag = 1;

	UPDATE intakeservicerequestsdm  sm SET
	 activeflag = 0
	, updatedby = 'EXPUNG'
	, updatedon = now()
	FROM tmp_expungscreenout s
	WHERE s.intakeserviceid = sm.intakeserviceid AND sm.activeflag = 1;

	-- ## EXPUNG CONTACT NOTE
	UPDATE Progressnotedetail  pnd SET
	 activeflag = 0
	, updatedby = 'EXPUNG'
	, updatedon = now()
	FROM progressnote pn
	INNER JOIN tmp_expungscreenout s ON s.intakeserviceid = pn.intakeserviceid
	WHERE pn.progressnoteid = pnd.progressnoteid  AND pn.activeflag = 1;

	UPDATE Contacttrialvisit  cv SET
	 activeflag = 0
	, updatedby = 'EXPUNG'
	, updatedon = now()
	FROM progressnote pn
	INNER JOIN tmp_expungscreenout s ON s.intakeserviceid = pn.intakeserviceid
	WHERE pn.progressnoteid = cv.progressnoteid  AND cv.activeflag = 1;

	UPDATE contactparticipant cp SET
	 activeflag = 0
	, updatedby = 'EXPUNG'
	, updatedon = now()
	FROM progressnote pn
	INNER JOIN tmp_expungscreenout s ON s.intakeserviceid = pn.intakeserviceid
	WHERE pn.progressnoteid = cp.progressnoteid  AND cp.activeflag = 1;

	UPDATE progressnote pn SET
	 activeflag = 0
	, updatedby = 'EXPUNG'
	, updatedon = now()
	FROM tmp_expungscreenout s  
	WHERE s.intakeserviceid = pn.intakeserviceid AND pn.activeflag = 1;

	--## EXPUNG PERSON RECORD IF NOT LINKED TO ANY SERVICE CASE
	UPDATE person pe SET
	 firstname = concat(left(pe.firstname,1), 'xxxxxx')
	, middlename  = concat(left(pe.middlename,1), 'xxxxxx')
	, lastname = concat(left(pe.lastname,1), 'xxxxxx')
	, dob = '1900-01-01'
	, ssnno = NULL
	, activeflag  = 0
	, updatedby = 'EXPUNG'
	, updatedon = now()
	FROM tmp_expungperson t
	WHERE t.personid = pe.personid;

	INSERT INTO tmp_expungscreenout (cpsid, intakeserviceid, cpsdate, status, issexualabuse)
	SELECT tes.cpsid, tes.intakeserviceid, tes.cpsdate, tes.status, tes.issexualabuse FROM tmp_expungsexualabusescreenout tes
	WHERE tes.issexualabuse = true ORDER BY 2;

	--#### PUBLISH PERSONS FOR EXPUNG REPORT -- What should be done for this reports
	PERFORM publishexpungreport('SCRNOUT',( SELECT JSON_AGG(T) FROM (SELECT t.cpsid, t.intakeserviceid FROM  tmp_expungscreenout t ) t));

	PERFORM publishexpungreport('REFCL',( SELECT JSON_AGG(T) FROM (
	SELECT t.personid, t.intakeserviceid, t.personname FROM  tmp_expungperson t ) t));

	--## RETURN SCREENOUT EXPUNGED PERSONS
	RETURN QUERY
	SELECT tes.cpsid, tes.intakeserviceid, tes.cpsdate, tes.status FROM tmp_expungscreenout tes;

	EXCEPTION
    WHEN OTHERS THEN
        RAISE WARNING 'Error occurred: %', SQLERRM;
        RETURN;

END;

$function$
;