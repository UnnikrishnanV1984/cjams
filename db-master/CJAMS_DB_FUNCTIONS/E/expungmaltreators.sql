DROP FUNCTION IF EXISTS cjams.expungmaltreators(date);

CREATE OR REPLACE FUNCTION cjams.expungmaltreators(fordate date)
 RETURNS TABLE(cpsid character varying, intakeserviceid uuid, intakeservicerequestactorid uuid, personid uuid, investigationallegationid uuid, investigationfindingtypekey character varying, reporteddate date, completiondate date, rowindex bigint)
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- Revision(s)
-- 10/01/2020 Vineet Tirodkar - Modification to verify Person's involvement is APS and to remove MD CHESSIE data check 
-- 01/28/2021 Vineet Tirodkar - Modification to verify Person's participation in CW Adoption Cases prior to expungement
-- 09/23/2022 Vineet Tirodkar - Type casting fixes for Aurora DB migration 
-- 02/16/2024 Vineet Tirodkar - Modifications for Expungement Job Performance Fixes (CIDM-8423)
-- 11/03/2025 Manasa Kasula - Modifications for Expungement Job for Sexual Abuse Cases (CIDM-10890)
------------------------------------------------------------------------ 
DECLARE 
al_sqlcode integer;
as_error character varying;
BEGIN
	DROP TABLE IF EXISTS tmp_expungmaltreators;
	DROP TABLE IF EXISTS BASE;
	DROP TABLE IF EXISTS MAX_PER;
	-- ## HOLD ESTIMATED RECORDS
	CREATE TEMP TABLE tmp_expungmaltreators
	 ( cpsid character varying
	 , intakeserviceid uuid
	 , intakeservicerequestactorid uuid
	 , personid uuid
	 , investigationallegationid uuid
	 , investigationfindingtypekey character varying
	 , reporteddate date
	 , completiondate date
	 , rowindex bigint
	 , allegationname character varying
	 );
	CREATE INDEX tmp_expungmaltreators_idx ON tmp_expungmaltreators(cpsid,personid,investigationallegationid,reporteddate,completiondate);
	CREATE INDEX tmp_expungmaltreators_investigationallegationid_idx ON tmp_expungmaltreators(investigationallegationid,intakeservicerequestactorid);
	CREATE INDEX tmp_expungmaltreators_intakeserviceid_idx ON tmp_expungmaltreators(intakeserviceid);

	CREATE TEMP TABLE BASE
	  (servicerequestnumber character varying
	, intakeserviceid uuid
	, personid uuid
	, investigationallegationid uuid
	, intakeservicerequestactorid uuid
	, investigationfindingtypekey character varying
	, reporteddate date
	, completiondate date
	, rowindex bigint
	, fnd_rnk int
	, allegationname character varying
	);
	CREATE INDEX base_idx ON base(servicerequestnumber,personid,investigationallegationid,reporteddate,completiondate);
	CREATE TEMP TABLE MAX_PER(personid                  uuid
							 ,servicerequestnumber      character varying
							 ,completiondate            date
							 ,fnd_rnk                   int
							 );
						   
	CREATE INDEX MAX_PER_idx ON MAX_PER(completiondate,personid,servicerequestnumber,fnd_rnk);

	 
	--## EXPUNG ALL RULED-OUT/UN-SUB CPS-IR FINDINGS AND SUBSEQUENT EARLIER FINDINGS
	--## WHEN THE MOST RECENT FINDINGS REACHED COMPLETION
	INSERT INTO BASE (servicerequestnumber,intakeserviceid,personid,investigationallegationid,intakeservicerequestactorid,investigationfindingtypekey
	 ,reporteddate,completiondate,rowindex,fnd_rnk,allegationname
	)
	SELECT T.servicerequestnumber,T.intakeserviceid,T.personid,T.investigationallegationid,T.intakeservicerequestactorid,T.investigationfindingtypekey
	 ,T.reporteddate,T.completiondate
	 ,ROW_NUMBER() OVER(PARTITION BY T.personid ORDER BY T.completiondate DESC) rowindex
	 ,fnd_rnk, T.allegationname
	  FROM
	(
	SELECT DISTINCT isr.servicerequestnumber
	, isr.intakeserviceid
	, isra.personid
	, ia.investigationallegationid -- Sarma Bandi
	, isra.intakeservicerequestactorid
	, COALESCE(im.overridefindingtypekey,inf.investigationfindingtypekey) investigationfindingtypekey
	, iv.insertedon::DATE reporteddate
	, CASE COALESCE(im.overridefindingtypekey,inf.investigationfindingtypekey)
	WHEN 'RO' THEN (iv.insertedon + (2 * INTERVAL '1 years'))::DATE
	WHEN 'UD' THEN (iv.insertedon + (5 * INTERVAL '1 years'))::DATE
	WHEN 'ID' THEN (iv.insertedon + (25 * INTERVAL '1 years'))::DATE
	  END AS completiondate
	, CASE COALESCE(im.overridefindingtypekey,inf.investigationfindingtypekey)
	WHEN 'ID' THEN 1
	WHEN 'UD' THEN 2
	WHEN 'RO' THEN 3
	  END AS fnd_rnk
	, alle.name as allegationname
	FROM investigationallegationmaltreators im
	INNER JOIN investigationallegation ia ON ia.investigationallegationid = im.investigationallegationid AND ia.activeflag =1
	INNER JOIN  allegation alle on alle.allegationid = ia.allegationid AND alle.activeflag = 1
	INNER JOIN investigationmaltreatmentactor ima ON ima.maltreatmentid = ia.maltreatmentid AND ima.activeflag =1
	INNER JOIN intakeservicerequestactor isra ON isra.intakeservicerequestactorid = im.intakeservicerequestactorid AND isra.activeflag =1
	INNER JOIN intakeservicerequest isr ON isr.intakeserviceid = isra.intakeserviceid
	INNER join investigationfinding inf on ia.investigationallegationid = inf.investigationallegationid and inf.activeflag = 1  
	INNER JOIN investigation iv ON iv.intakeserviceid = isr.intakeserviceid
	WHERE COALESCE(im.overridefindingtypekey,inf.investigationfindingtypekey) IN ('RO','UD','ID')
	AND im.finalizeddate IS NOT NULL
	AND isra.spexpungementflag IS NULL
	) T
	;
	-- Identify the biggest finding (ID followed by UD followed by RO) for each person
	INSERT INTO MAX_PER
	SELECT tmp2.PERSONID,tmp2.SERVICErequestNUMBER,tmp2.COMPLETIONDATE,tmp2.FND_RNK
	FROM
	(
	SELECT AA.PERSONID,AA.SERVICErequestNUMBER,AA.COMPLETIONDATE,AA.FND_RNK
		  ,ROW_NUMBER() OVER(PARTITION BY AA.PERSONID ORDER BY AA.FND_RNK,AA.completiondate DESC) AS RN -- to order the records in the priority of the biggest finding for the person
	  FROM BASE AA
	) TMP2
	WHERE tmp2.RN = 1 -- Limit the result to the biggest finding
	;
	-- Insert all the records related to the person identified in the above table(MAX_PER), whose completiondate is the "fordate"
	-- Will retrieve all the person records along with their subsequents
	INSERT INTO tmp_expungmaltreators(cpsid, intakeserviceid, intakeservicerequestactorid, personid, investigationallegationid, investigationfindingtypekey, reporteddate, completiondate, rowindex, allegationname)
	SELECT  DISTINCT A.servicerequestnumber
	, A.intakeserviceid
	, A.intakeservicerequestactorid
	, A.personid
	, A.investigationallegationid
	, A.investigationfindingtypekey
	, A.reporteddate
	, A.completiondate
	, A.rowindex
	, A.allegationname
	FROM BASE A
	   WHERE EXISTS (SELECT 1
					   FROM MAX_PER B
					  WHERE A.personid = B.personid
	   AND B.completiondate = fordate
	   AND A.completiondate <= B.completiondate
					)
	 ;

	-- Commented as CJAMS is now Statewide Live (10/02/2020)
	/*
	DELETE FROM tmp_expungmaltreators tx USING
	(SELECT distinct p.cisclientid,  p.personid, tb.investigation_id,
	tb.finding_cd, tb.expungement_dt, tb.screening_approval_dt
	 FROM tb_chessie_investigation_client tb
	INNER JOIN person p  ON (trim(p.cisclientid) = trim(tb.cis_client_id) OR p.cjamspid = tb.chessie_client_id)
	INNER JOIN tmp_expungmaltreators t ON t.personid = p.personid
	WHERE tb.expungement_dt IS NOT NULL AND tb.action_flag NOT IN ('D')
	--AND tb.finding_cd NOT IN ('1394') -- Sarma Bandi: 04/09/2020: Commented out this condition
	) v WHERE v.personid = tx.personid AND v.expungement_dt >= tx.completiondate
	-- Vineet 01/14/2020
	AND (case when tx.investigationfindingtypekey = 'RO' then
	v.screening_approval_dt between tx.reporteddate::date  -- + 1 * INTERVAL '1 day'
	AND tx.reporteddate::date + 2 * INTERVAL '1 years'
	when tx.investigationfindingtypekey = 'UD' then
	v.screening_approval_dt between tx.reporteddate::date  -- + 1 * INTERVAL '1 day'
	AND tx.reporteddate::date + 5 * INTERVAL '1 years'
	end );
	*/

	DELETE FROM tmp_expungmaltreators tme
	WHERE tme.investigationallegationid IN (select distinct ifs.investigationallegationid from investigationfinding ifs
	INNER JOIN expungement e on e.investigationfindingid = ifs.investigationfindingid
	WHERE e.activeflag =1 and e.donotexpunge = true );

	-- ## VALIDATE AND REMOVE MANUALLY EXPUNGED DATA
	INSERT INTO tmp_expungmaltreators(cpsid, intakeserviceid, intakeservicerequestactorid, personid, investigationallegationid, investigationfindingtypekey, reporteddate, completiondate, rowindex, allegationname)
	SELECT  DISTINCT isr.servicerequestnumber
	, isr.intakeserviceid
	, isra.intakeservicerequestactorid
	, isra.personid
	, ia.investigationallegationid
	, COALESCE(im.overridefindingtypekey,inf.investigationfindingtypekey) investigationfindingtypekey
	, iv.insertedon
	, NOW()::DATE completiondate
	, 2
	, alle.name 
	FROM investigationallegationmaltreators im
	INNER JOIN investigationallegation ia ON ia.investigationallegationid = im.investigationallegationid 
	INNER JOIN  allegation alle on alle.allegationid = ia.allegationid AND alle.activeflag = 1 and alle.name != 'Sexual Abuse'
	INNER JOIN investigationmaltreatmentactor ima ON ima.maltreatmentid = ia.maltreatmentid
	INNER JOIN intakeservicerequestactor isra ON isra.intakeservicerequestactorid = im.intakeservicerequestactorid
	INNER JOIN intakeservicerequest isr ON isr.intakeserviceid = isra.intakeserviceid
	INNER join investigationfinding inf on ia.investigationallegationid = inf.investigationallegationid
	INNER JOIN investigation iv ON iv.intakeserviceid = isr.intakeserviceid
	INNER JOIN expungement ex ON ex.investigationfindingid = inf.investigationfindingid
	AND date(ex.insertedon) = now()::DATE
	AND (isremoverofindings = true OR isremovemaltreator = true);

	-- Expunge Sexual Abuse Maltreators Changes
	DROP TABLE IF EXISTS tmp_expungsexualabusemaltreators;
	-- ## HOLD ESTIMATED RECORDS
	CREATE TEMP TABLE tmp_expungsexualabusemaltreators
	 ( cpsid character varying
	 , intakeserviceid uuid
	 , intakeservicerequestactorid uuid
	 , personid uuid
	 , investigationallegationid uuid
	 , investigationfindingtypekey character varying
	 , reporteddate date
	 , completiondate date
	 , rowindex bigint
	 , allegationname character varying
	 );
	CREATE INDEX tmp_expungsexualabusemaltreators_idx ON tmp_expungsexualabusemaltreators(cpsid,personid,investigationallegationid,reporteddate,completiondate);
	CREATE INDEX tmp_expungsexualabusemaltreators_investigationallegationid_idx ON tmp_expungsexualabusemaltreators(investigationallegationid,intakeservicerequestactorid);
	CREATE INDEX tmp_expungsexualabusemaltreators_intakeserviceid_idx ON tmp_expungsexualabusemaltreators(intakeserviceid);

	INSERT INTO tmp_expungsexualabusemaltreators(cpsid, intakeserviceid, intakeservicerequestactorid, personid, investigationallegationid, investigationfindingtypekey, reporteddate, completiondate, rowindex, allegationname)
	SELECT tem.cpsid, tem.intakeserviceid, tem.intakeservicerequestactorid, tem.personid, tem.investigationallegationid, tem.investigationfindingtypekey, tem.reporteddate, tem.completiondate, tem.rowindex, tem.allegationname
	From tmp_expungmaltreators tem where allegationname = 'Sexual Abuse';

	--### PUBLISH ALLEGATION TO EXPUNG REPORT
	PERFORM publishexpungreport('ALLEG',(SELECT JSON_AGG(T) FROM (SELECT * FROM  tmp_expungmaltreators) T));

	Delete from tmp_expungmaltreators where allegationname = 'Sexual Abuse';
	--------------------------------------- Sexual Abuse Allegation implementation ------------------------------------------------------------------
	--## UPDATE THE OUTBOUND TABLE FOR CROSS-OVER Need to check if this change is needed
	UPDATE tb_cjams_investigation_client td SET
	action_flag = 'D'
	, update_ts = NOW()
	FROM tmp_expungsexualabusemaltreators tmp
	WHERE tmp.investigationallegationid = td.allegation_id::UUID;

	SELECT a.al_sqlcode,a.as_error from cjams.expungemaltreatortables('expungmaltreatorsallegation') a into al_sqlcode, as_error;
	IF al_sqlcode <> 0 THEN
		as_error := as_error  ;
	IF as_error is NULL OR as_error = '' THEN
		as_error := 'Encrypt Expung tables failed'  ;
	END IF;
	--SIGNAL p_sp_error ;
	END IF ;

	--------------------------------------- End for Sexual Abuse Allegation implementation ------------------------------------------------------------------
	--------------------------------------- Non Sexual Abuse Allegation implementation ----------------------------------------------------------------------
	--## EXPUNG ALL CPS RELATED RECORDS
	UPDATE investigationallegation ia SET
	 activeflag = 0
	, updatedby = 'EXPUNG'
	, updatedon = now()
	FROM tmp_expungmaltreators v
	WHERE v.investigationallegationid = ia.investigationallegationid;

	UPDATE investigationallegationmaltreators im SET
	 activeflag = 0
	, updatedby = 'EXPUNG'
	, updatedon = now()
	FROM tmp_expungmaltreators t
	WHERE im.intakeservicerequestactorid = t.intakeservicerequestactorid
	 AND im.investigationallegationid = t.investigationallegationid;

	-- UPDATE intakeservrequestsdmmaltreatment sm SET
	--  sm.activeflag = 0
	-- , sm.updatedby = 'EXPUNG'
	-- , sm.updatedon = now()
	-- FROM (SELECT sdm.*
	-- FROM tmp_expungmaltreators t, intakeservicerequestsdm sdm
	-- WHERE sdm.intakeserviceid = t.intakeserviceid) v
	-- WHERE v.intakeservicerequestsdmid = sm.intakeservicerequestsdmid;

	--## UPDATE THE OUTBOUND TABLE FOR CROSS-OVER
	UPDATE tb_cjams_investigation_client td SET
	 action_flag = 'D'
	, update_ts = NOW()
	FROM tmp_expungmaltreators tmp
	WHERE tmp.investigationallegationid = td.allegation_id::UUID;

	UPDATE  intakeservicerequestactor isra SET
	 activeflag = 0
	, spexpungementflag = 1
	, updatedby = 'EXPUNG'
	, updatedon = now()
	FROM tmp_expungmaltreators t
	WHERE isra.intakeservicerequestactorid = t.intakeservicerequestactorid
	AND intakeservicerequestpersontypekey = 'AM'
	-- AND 0 =  (SELECT COUNT(1)
	--    FROM tmp_expungmaltreators t2
	-- 	INNER JOIN investigationallegationmaltreators im
	-- 	ON im.intakeservicerequestactorid = t2.intakeservicerequestactorid AND im.activeflag = 1);
	AND 0 = (SELECT COUNT(1)
	from investigationallegationmaltreators im 
	inner join investigationallegation i2 on im.investigationallegationid = i2.investigationallegationid and i2.activeflag = 1 and i2.investigationallegationid != t.investigationallegationid                               
	inner join expungement i on i2.maltreatmentid = i.maltreatmentid and i.activeflag = 1
	where i.donotexpunge = true and im.intakeservicerequestactorid =t.intakeservicerequestactorid AND im.activeflag = 1);   

	UPDATE intakeservicerequestactor isra SET isprimary = true
	WHERE isra.intakeservicerequestactorid
	IN (SELECT MAX(isa.intakeservicerequestactorid::character varying)::UUID
	FROM intakeservicerequestactor isa
	INNER JOIN tmp_expungmaltreators tmp ON tmp.intakeserviceid = isa.intakeserviceid
	WHERE isa.activeflag = 1
	GROUP BY isa.intakeserviceid, isa.personid HAVING SUM(CASE WHEN isa.isprimary = true THEN 1 ELSE 0 END)  = 0);

	-- ## EXPUNG CONTACT NOTE PARTICIPATION
	-- UPDATE contactparticipant cp SET
	--  activeflag = 0
	-- , updatedby = 'EXPUNG'
	-- , updatedon = now()
	-- FROM (SELECT * FROM intakeservicerequestactor isa,
	-- (SELECT  isra.actorid
	-- FROM intakeservicerequestactor isra, tmp_expungmaltreators t
	-- WHERE isra.intakeservicerequestactorid = t.intakeservicerequestactorid
	-- AND intakeservicerequestpersontypekey = 'AM') v
	-- WHERE v.actorid = isa.actorid) r
	-- WHERE r.intakeservicerequestactorid = cp.intakeservicerequestactorid;

	--## EXPUNG ASSESSMENT DATA
	-- UPDATE assessmentsubmission sb SET
	-- datavalue = 'UNKOWN UNKOWN'
	-- FROM assessment a,
	-- (SELECT v.intakeserviceid, v.intakeservicerequestactorid, p.firstname||COALESCE(' '||p.middlename,'')||' '||p.lastname caregivername
	-- FROM person p,
	-- (SELECT isra.*
	-- FROM intakeservicerequestactor isra, tmp_expungmaltreators t
	-- WHERE isra.intakeservicerequestactorid = t.intakeservicerequestactorid
	-- AND intakeservicerequestpersontypekey = 'AM') v
	-- WHERE p.personid = v.personid) r
	-- WHERE a.submissionid = sb.submissionid
	-- AND a.objectid = r.intakeserviceid
	-- AND sb.datakey IN ('safeccaregivers', 'caseheadsname')
	-- AND sb.datavalue ilike '%'||r.caregivername||'%';
	--------------------------------------- End for Non Sexual Abuse Allegation implementation ------------------------------------------------------------------
	--------------------------------------- Start for Sexual Abuse Case Expungement -----------------------------------------------------------------------------
	DROP TABLE IF EXISTS tmp_expungsexualabuseinvestigation;
	-- ## HOLDS INVESTIGATION RECORDS TO BE EXPUNGED
	CREATE TEMP TABLE tmp_expungsexualabuseinvestigation
	( intakeserviceid uuid
	 , investigationid uuid
	 , maltreatments bigint
	 , cisclientid character varying
	 , cjamspid bigint
	);
	create index Xie1_tmp_expungsexualabuseinvestigation on tmp_expungsexualabuseinvestigation(intakeserviceid);
	create index Xie2_tmp_expungsexualabuseinvestigation on tmp_expungsexualabuseinvestigation(investigationid);
	create index Xie3_tmp_expungsexualabuseinvestigation on tmp_expungsexualabuseinvestigation(cisclientid);
	create index Xie4_tmp_expungsexualabuseinvestigation on tmp_expungsexualabuseinvestigation(cjamspid);

	-- ## ESTIMATE INVESTIGATION RECORDS TO BE EXPUNGED
	INSERT INTO tmp_expungsexualabuseinvestigation (intakeserviceid, investigationid, maltreatments)
	SELECT  t.intakeserviceid, iv.investigationid, COUNT(ia.investigationallegationid)
	FROM tmp_expungsexualabusemaltreators t
	INNER JOIN investigation iv ON iv.intakeserviceid = t.intakeserviceid
	INNER JOIN intakeservicerequest ir ON ir.intakeserviceid = iv.intakeserviceid
	-- LEFT JOIN investigationallegation ia ON ia.investigationid = iv.investigationid AND ia.activeflag = 1
	Left JOIN investigationallegation ia ON ia.investigationid = iv.investigationid AND ia.activeflag = 1 and ia.maltreatmentid in 
    (select im.maltreatmentid from investigationmaltreatment im where im.investigationid = iv.investigationid and im.activeflag = 1 and coalesce(im.isnotapplicable, 0) <> 1)
	WHERE -- t.rowindex = 1 AND  -- Sarma: Commented out
	ir.actiontype = 'IR'
	GROUP BY t.intakeserviceid, iv.investigationid
	HAVING COUNT(ia.investigationallegationid)=0;

	------- ## Sexual Abuse Allegation expunged before Scenario Implementation.
	INSERT INTO tmp_expungsexualabuseinvestigation (intakeserviceid, investigationid, maltreatments)
	SELECT  t.intakeserviceid, iv.investigationid, COUNT(ia.investigationallegationid)
	FROM tmp_expungmaltreators t
	LEFT JOIN tmp_expungsexualabusemaltreators ts ON t.intakeserviceid = ts.intakeserviceid
	INNER JOIN investigation iv ON iv.intakeserviceid = t.intakeserviceid
	INNER JOIN intakeservicerequest ir ON ir.intakeserviceid = iv.intakeserviceid
	-- LEFT JOIN investigationallegation ia ON ia.investigationid = iv.investigationid AND ia.activeflag = 1
	Left JOIN investigationallegation ia ON ia.investigationid = iv.investigationid AND ia.activeflag = 1 and ia.maltreatmentid in 
    (select im.maltreatmentid from investigationmaltreatment im where im.investigationid = iv.investigationid and im.activeflag = 1 and coalesce(im.isnotapplicable, 0) <> 1)
	LEFT JOIN expunge.investigationallegation_expunge iae ON iae.investigationid = iv.investigationid AND iae.activeflag = 1
	WHERE -- t.rowindex = 1 AND  -- Sarma: Commented out
	ir.actiontype = 'IR'
	GROUP BY t.intakeserviceid, iv.investigationid
	HAVING COUNT(ia.investigationallegationid)=0 and COUNT(ts.intakeserviceid)=0 and COUNT(iae.investigationallegationid)>0;

	-- ## EXCLUDE INVESTIGATION MARKED AS DO NOT EXPUNGE
	DELETE FROM tmp_expungsexualabuseinvestigation WHERE investigationid
	IN (SELECT DISTINCT ia.investigationid
	FROM investigationallegation ia
	INNER JOIN investigationfinding inf ON inf.investigationallegationid = ia.investigationallegationid
	INNER JOIN expungement ex ON ex.investigationfindingid = inf.investigationfindingid
	INNER JOIN tmp_expungsexualabuseinvestigation tmp ON tmp.investigationid = ia.investigationid
	WHERE COALESCE(ex.donotexpunge, false) = true AND ex.activeflag = 1);
	 
	--## UPDATE DATA FOR REPORTING
	UPDATE tmp_expungsexualabuseinvestigation tmp SET cisclientid = p.cisclientid, cjamspid = p.cjamspid
	FROM   intakeservicerequestactor isa, person p
	WHERE p.personid = isa.personid AND tmp.intakeserviceid = isa.intakeserviceid
	AND isa.intakeservicerequestpersontypekey = 'LG' AND isa.activeflag = 1;

	--## PRESERVE CASEHEAD NAME IN INVESTIGATION TABLE
	UPDATE investigation iv SET referralname = v.casehead, updatedon = now(), updatedby = 'EXPUNG'
	FROM (SELECT isa.intakeserviceid, MAX(p.firstname||COALESCE(' '||p.middlename,'')||' '||p.lastname) casehead
	FROM tmp_expungsexualabuseinvestigation tmp
	INNER JOIN intakeservicerequestactor isa ON isa.intakeserviceid = tmp.intakeserviceid
	INNER JOIN person p ON p.personid = isa.personid
	WHERE isa.intakeservicerequestpersontypekey = 'LG'
	GROUP BY isa.intakeserviceid LIMIT 1) v
	WHERE v.intakeserviceid = iv.intakeserviceid;

	--## NOTIFY OUTBOUND TABLE FOR COMMUNICATION
	UPDATE tb_cjams_investigation_client tb SET
	action_flag = 'D'
	, update_ts = NOW()
	FROM tmp_expungsexualabuseinvestigation tmp, intakeservicerequest ir
	WHERE tmp.intakeserviceid = ir.intakeserviceid
	AND ir.servicerequestnumber = tb.investigation_id;

	--## SET DATATRANSFER FLAG FOR CDBP COMMUNICATION
	UPDATE personprogramarea pa SET
	 datatransferflag = 'D'
	, activeflag = 0
	, updatedon = NOW()
	, enddate = NOW()
	, isexpunged = 1
	FROM tmp_expungsexualabuseinvestigation tmp
	WHERE pa.objectid = tmp.intakeserviceid:: character varying;

	--### PUBLISH INVESTIGATION TO EXPUNG REPORT
	PERFORM publishexpungreport('INVT',(SELECT JSON_AGG(T) FROM (SELECT t.* FROM  tmp_expungsexualabuseinvestigation t) T));	
	SELECT a.al_sqlcode,a.as_error from cjams.expungemaltreatortables('expungmaltreatorsinvestigation') a into al_sqlcode, as_error;
	IF al_sqlcode <> 0 THEN
		as_error := as_error  ;
	IF as_error is NULL OR as_error = '' THEN
		as_error := 'Encrypt Expung tables failed for CPS case'  ;
	END IF;
	--SIGNAL p_sp_error ;
	END IF ;
	-------------------------------- End for Sexual Abuse Case Expungement ---------------------------------------------
	-------------------------------- Start for Non Sexual Abuse Case Expungement ---------------------------------------
	DROP TABLE IF EXISTS tmp_expunginvestigation;
	-- ## HOLDS INVESTIGATION RECORDS TO BE EXPUNGED
	CREATE TEMP TABLE tmp_expunginvestigation
	( intakeserviceid uuid
	 , investigationid uuid
	 , maltreatments bigint
	 , cisclientid character varying
	 , cjamspid bigint
	);
	create index Xie1_tmp_expunginvestigation on tmp_expunginvestigation(intakeserviceid);
	create index Xie2_tmp_expunginvestigation on tmp_expunginvestigation(investigationid);
	create index Xie3_tmp_expunginvestigation on tmp_expunginvestigation(cisclientid);
	create index Xie4_tmp_expunginvestigation on tmp_expunginvestigation(cjamspid);

	-- ## ESTIMATE INVESTIGATION RECORDS TO BE EXPUNGED
	INSERT INTO tmp_expunginvestigation (intakeserviceid, investigationid, maltreatments)
	SELECT  t.intakeserviceid, iv.investigationid, COUNT(ia.investigationallegationid)
	FROM tmp_expungmaltreators t
	INNER JOIN investigation iv ON iv.intakeserviceid = t.intakeserviceid
	INNER JOIN intakeservicerequest ir ON ir.intakeserviceid = iv.intakeserviceid
	-- LEFT JOIN investigationallegation ia ON ia.investigationid = iv.investigationid AND ia.activeflag = 1
	Left JOIN investigationallegation ia ON ia.investigationid = iv.investigationid AND ia.activeflag = 1 and ia.maltreatmentid in 
    (select im.maltreatmentid from investigationmaltreatment im where im.investigationid = iv.investigationid and im.activeflag = 1 and coalesce(im.isnotapplicable, 0) <> 1)
	LEFT JOIN expunge.investigationallegation_expunge iae ON iae.investigationid = iv.investigationid AND iae.activeflag = 1
	WHERE -- t.rowindex = 1 AND  -- Sarma: Commented out
	ir.actiontype = 'IR'
	GROUP BY t.intakeserviceid, iv.investigationid
	HAVING COUNT(ia.investigationallegationid)=0 and COUNT(iae.investigationallegationid)=0;

	/* -- Sarma: Commented out
	-- ## INSERT MANUAL INVESTIGATION RECORDS TO BE EXPUNGED
	INSERT INTO tmp_expunginvestigation (intakeserviceid, investigationid, maltreatments)
	SELECT  t.intakeserviceid, iv.investigationid, COUNT(ia.investigationallegationid)
	FROM tmp_expungmaltreators t
	INNER JOIN investigation iv ON iv.intakeserviceid = t.intakeserviceid
	INNER JOIN intakeservicerequest ir ON ir.intakeserviceid = iv.intakeserviceid
	LEFT JOIN investigationallegation ia ON ia.investigationid = iv.investigationid AND ia.activeflag = 1
	WHERE t.rowindex = 2 AND
	ir.actiontype = 'IR'
	GROUP BY t.intakeserviceid, iv.investigationid
	HAVING COUNT(ia.investigationallegationid)=0;
	*/

	-- ## EXCLUDE SEXUAL ABUSE INVESTIGATION 
	DELETE FROM tmp_expunginvestigation tmp WHERE tmp.intakeserviceid
	IN (SELECT DISTINCT tmps.intakeserviceid
	FROM tmp_expungsexualabuseinvestigation tmps);

	-- ## EXCLUDE INVESTIGATION MARKED AS DO NOT EXPUNGE
	DELETE FROM tmp_expunginvestigation WHERE investigationid
	IN (SELECT DISTINCT ia.investigationid
	FROM investigationallegation ia
	INNER JOIN investigationfinding inf ON inf.investigationallegationid = ia.investigationallegationid
	INNER JOIN expungement ex ON ex.investigationfindingid = inf.investigationfindingid
	INNER JOIN tmp_expunginvestigation tmp ON tmp.investigationid = ia.investigationid
	WHERE COALESCE(ex.donotexpunge, false) = true AND ex.activeflag = 1);
	 
	--## UPDATE DATA FOR REPORTING
	UPDATE tmp_expunginvestigation tmp SET cisclientid = p.cisclientid, cjamspid = p.cjamspid
	FROM   intakeservicerequestactor isa, person p
	WHERE p.personid = isa.personid AND tmp.intakeserviceid = isa.intakeserviceid
	AND isa.intakeservicerequestpersontypekey = 'LG' AND isa.activeflag = 1;

	--## EXPUNG ALL INTAKE RELATED RECORDS
	UPDATE intakeservicerequest ir  SET
	 expungementflag=1
	, lastexpungementdate=NOW()
	, activeflag=0
	, updatedby = 'EXPUNG'
	, updatedon = now()
	FROM tmp_expunginvestigation s
	WHERE s.intakeserviceid = ir.intakeserviceid AND ir.activeflag = 1;

	UPDATE intakedastatus SET activeflag = 0 WHERE intakenumber IN
	(SELECT  ir.intakenumber
	FROM tmp_expunginvestigation so
	INNER JOIN intakeservicerequest ir ON so.intakeserviceid = ir.intakeserviceid);

	UPDATE intakedastaging SET activeflag = 0 WHERE intakenumber IN
	(SELECT  ir.intakenumber
	FROM tmp_expunginvestigation so
	INNER JOIN intakeservicerequest ir ON so.intakeserviceid = ir.intakeserviceid);

	--## PRESERVE CASEHEAD NAME IN INVESTIGATION TABLE
	UPDATE investigation iv SET referralname = v.casehead, updatedon = now(), updatedby = 'EXPUNG'
	FROM (SELECT isa.intakeserviceid, MAX(p.firstname||COALESCE(' '||p.middlename,'')||' '||p.lastname) casehead
	FROM tmp_expunginvestigation tmp
	INNER JOIN intakeservicerequestactor isa ON isa.intakeserviceid = tmp.intakeserviceid
	INNER JOIN person p ON p.personid = isa.personid
	WHERE isa.intakeservicerequestpersontypekey = 'LG'
	GROUP BY isa.intakeserviceid LIMIT 1) v
	WHERE v.intakeserviceid = iv.intakeserviceid;

	UPDATE intakeservicerequestactor isa SET
	 activeflag = 0
	, updatedby = 'EXPUNG'
	, updatedon = now()
	, isheadofhousehold = false
	, intakeserviceid = '00000000-0000-0000-0000-000000000000'
	FROM tmp_expunginvestigation t
	WHERE (isa.intakeserviceid = t.intakeserviceid or isa.intakenumber = (SELECT ir.intakenumber
		from intakeservicerequest ir where t.intakeserviceid = ir.intakeserviceid)) AND isa.servicecaseid IS NULL;

	UPDATE intakeservicerequestactor isa SET
	 intakeserviceid = NULL
	, updatedon = now()
	FROM tmp_expunginvestigation t
	WHERE isa.intakeserviceid = t.intakeserviceid AND isa.servicecaseid IS NOT NULL;

	UPDATE intakeservicerequestactor isa SET
	 intakeserviceid = NULL
	, updatedon = now()
	FROM tmp_expunginvestigation t
	WHERE isa.intakenumber = (SELECT ir.intakenumber
		from intakeservicerequest ir where t.intakeserviceid = ir.intakeserviceid) AND isa.servicecaseid IS NOT NULL;

	UPDATE actor a SET
	 activeflag = 0
	, updatedby = 'EXPUNG'
	, updatedon = now()
	FROM tmp_expunginvestigation t
	WHERE (a.intakeserviceid = t.intakeserviceid or a.intakenumber = (SELECT ir.intakenumber
		from intakeservicerequest ir where t.intakeserviceid = ir.intakeserviceid)) AND a.servicecaseid IS NULL;

	UPDATE actor a SET
	 intakeserviceid = NULL
	, updatedon = now()
	FROM tmp_expunginvestigation t
	WHERE a.intakeserviceid = t.intakeserviceid AND a.servicecaseid IS NOT NULL;

	UPDATE actor a SET
	 intakeserviceid = NULL
	, updatedon = now()
	FROM tmp_expunginvestigation t
	WHERE a.intakenumber = (SELECT ir.intakenumber
		from intakeservicerequest ir where t.intakeserviceid = ir.intakeserviceid)  AND a.servicecaseid IS NOT NULL;

	--## NOTIFY OUTBOUND TABLE FOR COMMUNICATION
	UPDATE tb_cjams_investigation_client tb SET
	 action_flag = 'D'
	, update_ts = NOW()
	FROM tmp_expunginvestigation tmp, intakeservicerequest ir
	WHERE tmp.intakeserviceid = ir.intakeserviceid
	AND ir.servicerequestnumber = tb.investigation_id;

	--## SET DATATRANSFER FLAG FOR CDBP COMMUNICATION
	UPDATE personprogramarea pa SET
	 datatransferflag = 'D'
	, activeflag = 0
	, updatedon = NOW()
	, enddate = NOW()
	FROM tmp_expunginvestigation tmp
	WHERE pa.objectid = tmp.intakeserviceid:: character varying;

	--## EXPUNG SDM INFO
	-- UPDATE intakeservrequestsdmmaltreatment  sm SET
	-- activeflag = 0, isexpunged = 1
	-- , updatedby = 'EXPUNG'
	-- , updatedon = now()
	-- FROM intakeservicerequestsdm sdm
	-- INNER JOIN tmp_expungsexualabuseinvestigation s ON s.intakeserviceid = sdm.intakeserviceid
	-- WHERE sdm.intakeservicerequestsdmid = sm.intakeservicerequestsdmid  AND sm.activeflag = 1;

	UPDATE intakeservicerequestsdm  sm SET
	activeflag = 0
	, updatedby = 'EXPUNG'
	, updatedon = now()
	FROM tmp_expunginvestigation s
	WHERE s.intakeserviceid = sm.intakeserviceid AND sm.activeflag = 1;

	-- ## EXPUNG CONTACT NOTE
	UPDATE Progressnotedetail  pnd SET
	activeflag = 0
	, updatedby = 'EXPUNG'
	, updatedon = now()
	FROM progressnote pn
	INNER JOIN tmp_expunginvestigation s ON s.intakeserviceid = pn.intakeserviceid
	WHERE pn.progressnoteid = pnd.progressnoteid  AND pn.activeflag = 1;

	UPDATE Contacttrialvisit  cv SET
	activeflag = 0
	, updatedby = 'EXPUNG'
	, updatedon = now()
	FROM progressnote pn
	INNER JOIN tmp_expunginvestigation s ON s.intakeserviceid = pn.intakeserviceid
	WHERE pn.progressnoteid = cv.progressnoteid  AND cv.activeflag = 1;

	UPDATE contactparticipant cp SET
	activeflag = 0
	, updatedby = 'EXPUNG'
	, updatedon = now()
	FROM progressnote pn
	INNER JOIN tmp_expunginvestigation s ON s.intakeserviceid = pn.intakeserviceid
	WHERE pn.progressnoteid = cp.progressnoteid  AND cp.activeflag = 1;

	UPDATE progressnote pn SET
	activeflag = 0
	, updatedby = 'EXPUNG'
	, updatedon = now()
	FROM tmp_expunginvestigation s  
	WHERE s.intakeserviceid = pn.intakeserviceid AND pn.activeflag = 1;
	-------------------------------- End for Non Sexual Abuse Case Expungement ---------------------------------------
	-------------------------------- Start for Person Expungement for non sexual abuse cases -------------------------
	DROP TABLE IF EXISTS tmp_expungperson;
	CREATE TEMP TABLE tmp_expungperson
	 ( personid uuid
	 , intakeserviceid uuid
	 , isinvolvedothercase int
	 , personname character varying
	 , actorid uuid
	 );

	create index Xie1_tmp_expungperson on tmp_expungperson(personid);
	create index Xie2_tmp_expungperson on tmp_expungperson(intakeserviceid);
	create index Xie3_tmp_expungperson on tmp_expungperson(actorid);
	INSERT INTO tmp_expungperson( personid ,intakeserviceid, isinvolvedothercase, personname, actorid)
	SELECT  a.personid, a.intakeserviceid, 0, p.firstname||COALESCE(' '||p.middlename,'')||' '||p.lastname, a.actorid
	FROM actor a
	INNER JOIN person p ON p.personid = a.personid AND p.activeflag = 1
	INNER JOIN tmp_expunginvestigation so ON so.intakeserviceid = a.intakeserviceid;

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

	UPDATE tmp_expungperson  t
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
	DELETE FROM tmp_expungperson t WHERE t.personid IN (
	SELECT p.personid
	FROM tmp_expungperson tmp
	INNER JOIN person p ON p.personid = tmp.personid
	INNER JOIN tb_chessie_client_participation tb
	ON (tb.chessie_client_id = p.cjamspid OR tb.cjams_person_id = p.cjamspid)
	AND tb.action_flag <> 'D');
	*/

	--## REMOVE ALL PERSONS HAVING PAYMENT INFORMATION
	DELETE FROM tmp_expungperson t WHERE t.personid IN
	(SELECT  DISTINCT p.personid
	FROM tmp_expungperson tmp
	INNER JOIN person p ON p.personid = tmp.personid
	INNER JOIN tb_payment_detail tb ON tb.client_id = p.cjamspid);

	--## INSERT EXPUNG DATA FOR AUDIT PURPOSE
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
	SELECT  DISTINCT p.cjamspid
	, (select personidentifiervalue mdm_id from personidentifier pf where pf.personid=p.personid and pf.personidentifiertypekey='MDM_ID' LIMIT 1)
	, p.cisclientid
	, NOW()
	, ir.servicerequestnumber
	, 0
	, NOW()
	, PGP_SYM_ENCRYPT(p.firstname, 'AES_KEY')
	, PGP_SYM_ENCRYPT(p.middlename, 'AES_KEY')
	, PGP_SYM_ENCRYPT(p.lastname, 'AES_KEY')
	, PGP_SYM_ENCRYPT(p.dob::text, 'AES_KEY')
	, PGP_SYM_ENCRYPT(p.ssnno, 'AES_KEY')
	FROM tmp_expungperson t
	INNER JOIN intakeservicerequest ir ON ir.intakeserviceid = t.intakeserviceid
	INNER JOIN person p ON p.personid = t.personid;

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
	SELECT  DISTINCT (select personidentifiervalue mdm_id from personidentifier pf where pf.personid=p.personid and pf.personidentifiertypekey='MDM_ID' LIMIT 1)
	, p.cjamspid
	, p.cisclientid
	, NOW()
	, ir.servicerequestnumber
	, 0
	, NOW()
	, NOW()
	FROM tmp_expungperson t
	INNER JOIN intakeservicerequest ir ON ir.intakeserviceid = t.intakeserviceid
	INNER JOIN person p ON p.personid = t.personid;

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
	WHERE   pe.personid = t.personid;

	--PERFORM  expungperson( (SELECT  ''''||string_agg(tp.personid::character varying, ''',''')||'''' FROM tmp_expungperson tp));
	PERFORM  expungperson( (SELECT array_agg(tp.personid::character varying ) FROM tmp_expungperson tp));
	-------------------------------- End for Person Expungement for non sexual abuse cases -------------------------
	--### PUBLISH ALLEGATION AND  PERSON DATA AND INVESTIGATION TO EXPUNG REPORT
	PERFORM publishexpungreport('REFCL',(SELECT JSON_AGG(T) FROM (SELECT t.personid, t.intakeserviceid, t.personname FROM  tmp_expungperson t) T));
	PERFORM publishexpungreport('INVT',(SELECT JSON_AGG(T) FROM (SELECT t.* FROM  tmp_expunginvestigation t) T));

	INSERT INTO tmp_expungmaltreators(cpsid, intakeserviceid, intakeservicerequestactorid, personid, investigationallegationid, investigationfindingtypekey, reporteddate, completiondate, rowindex, allegationname)
	SELECT tesm.cpsid, tesm.intakeserviceid, tesm.intakeservicerequestactorid, tesm.personid, tesm.investigationallegationid, tesm.investigationfindingtypekey, tesm.reporteddate, tesm.completiondate, tesm.rowindex, tesm.allegationname
	From tmp_expungsexualabusemaltreators tesm  where allegationname = 'Sexual Abuse';

	--## RETURN ESTIMATED MALTREATORS TO BE EXPUNGED
	RETURN QUERY
	SELECT tem.cpsid, tem.intakeserviceid, tem.intakeservicerequestactorid, tem.personid, tem.investigationallegationid, tem.investigationfindingtypekey, tem.reporteddate, tem.completiondate, tem.rowindex FROM tmp_expungmaltreators tem;

	EXCEPTION
    WHEN OTHERS THEN
        RAISE WARNING 'Error occurred: %', SQLERRM;
        RETURN;

END;

$function$
;