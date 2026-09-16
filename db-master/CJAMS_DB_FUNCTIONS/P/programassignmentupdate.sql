DROP FUNCTION IF EXISTS cjams.programassignmentupdate(v_evencode character varying , v_objecttypekey character varying,v_userid character varying,v_tranid character varying );
CREATE OR REPLACE FUNCTION cjams.programassignmentupdate(v_evencode character varying, v_objecttypekey character varying, v_userid character varying, v_tranid character varying)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
--------------------------------------------------------------------------
-- Revision(s)
-- CDM-23377 - 06-28 Veera- GAP Rate approval issue fix
-- CIDM-4426 - 04-12 GAP agreement Rate changes
-- 11-19 Aurora Issue fixes
-- 05/04/2023 Vineet Tirodkar - To fix Child Removal and OOH Dates Discrepancies (CIDM-6945)
-- 7/7/2023 Palani/Chandra -- Query tuning (CIDM-7474)
--08/01/2025- Triveni Bala- CIDM-10625 - Plan of selfcare user story changes
--------------------------------------------------------------------------
DECLARE l_count bigint;
l_programkey character varying;
l_subprogramkey character varying;
l_personid uuid;
l_enddate timestamp without time zone;
l_objectid character varying;
l_exitdate timestamp without time zone;
l_rev_exitdate timestamp without time zone;
l_isallfinalized numeric;
l_intakeserviceid uuid;
l_returnval character varying;
l_casenumber character varying;
l_removaldate timestamp without time zone;
l_rev_removaldate timestamp without time zone;
l_startdate timestamp without time zone;
l_record RECORD;

BEGIN

l_returnval := 'SUCCESS';
CREATE TEMP TABLE IF NOT EXISTS
Temp_insert_person_program_area (
personprogramid uuid
);

/*Get Program area and Sub program Area*/
SELECT programkey, subprogramkey INTO l_programkey, l_subprogramkey FROM programareaconfig WHERE LOWER(servicerequestsubtypekey) = 'ohm' AND isdefault =1 ;

IF (v_evencode ='CHRR') THEN
/*GET Removal Personid */
-- Get Removal Details
SELECT ISRA.personid,
--ISRA.servicecaseid::character varying,
coalesce(cr.servicecaseid, ISRA.servicecaseid)::character varying as servicecaseid,
exitdate,
cr.removaldate  
INTO l_personid,
l_objectid,
l_exitdate,
l_removaldate
FROM Intakeservreqchildremoval cr
INNER JOIN intakeservicerequestactor ISRA
ON ISRA.intakeservicerequestactorID = CR.intakeservicerequestactorid  
-- AND ISRA.activeflag =1
WHERE cr.activeflag = 1  
AND cr.intakeservreqchildremovalid = v_tranid ::uuid
LIMIT 1;

-- Get Removal Exit date from Revision table
SELECT removaldate,
exitdate
INTO l_rev_removaldate,
l_rev_exitdate
FROM intakeservreqchildremoval_history
WHERE intakeservreqchildremovalid = v_tranid::uuid
and "rowtype" = 'REVISION'
and activeflag = 1
ORDER BY updatedon desc
LIMIT 1;

if l_rev_removaldate is not null then
l_removaldate := l_rev_removaldate;
end if;

if l_rev_exitdate is not null then
l_exitdate := l_rev_exitdate;
end if;

-- Should not be the case ???
IF (l_removaldate is NULL) THEN
l_removaldate = Now()::DATE;
END IF;

-- Do we need this update ???
/*UPDATE PROGRAM AREA ACTIVEFLAG TO 1 AFTER SUPERVISOR APPROVAL*/
-- UPDATE personprogramarea SET activeflag = 1 WHERE activeflag = 2 AND objectid = l_objectid;

-- Get Active OOH count
SELECT COUNT(1)
INTO l_count
FROM personprogramarea
WHERE personid = l_personid
AND activeflag = 1
AND enddate IS NULL
AND objectid = l_objectid
AND LOWER(programkey) = 'ooh'
AND sourcetype = 'CW' ;

-- Get Service Case number
SELECT casenumber INTO l_casenumber FROM getcasenumber (v_objecttypekey, l_objectid ::character varying);

/*Add program area for removal child*/
IF (COALESCE(l_count,0) = 0 AND l_exitdate IS NULL ) THEN

-- Commented on 04/18/2023
/*
WITH temp_ids AS (
UPDATE personprogramarea
SET enddate =now()::date,
updatedby =v_userid,
datatransferflag='U'
WHERE personid = l_personid
AND activeflag =1
AND enddate IS NULL
AND objectid::character varying = l_objectid
AND LOWER(programkey) <> 'cps'
RETURNING personprogramid)
INSERT INTO Temp_insert_person_program_area SELECT personprogramid from temp_ids;
*/

WITH temp_ids AS
( INSERT INTO personprogramarea
(personid, programkey, subprogramkey,
objecttypekey, objectid, startdate,
insertedby, updatedby, entityid, datatransferflag, sourcetype)
VALUES
( l_personid, l_programkey, l_subprogramkey,
v_objecttypekey, l_objectid, l_removaldate:: DATE,
v_userid, v_userid, l_casenumber, 'A', 'CW')
RETURNING personprogramid)
INSERT INTO Temp_insert_person_program_area SELECT personprogramid from temp_ids;

ELSE  
IF (l_exitdate IS NULL) THEN -- Entry Date Update
WITH temp_ids AS
( UPDATE personprogramarea
SET startdate = l_removaldate::date,
updatedby = v_userid,
datatransferflag = 'U'  
WHERE personid = l_personid
AND activeflag = 1
AND enddate IS NULL
AND objectid::character varying = l_objectid
AND programkey = l_programkey
RETURNING personprogramid)
INSERT INTO Temp_insert_person_program_area SELECT personprogramid from temp_ids;
ELSE -- Removal Exit
WITH temp_ids AS
( UPDATE personprogramarea
SET startdate = l_removaldate::date,
enddate = l_exitdate::date,
updatedby = v_userid,
datatransferflag = 'U'  
WHERE personid = l_personid
AND activeflag = 1
AND enddate IS NULL
AND objectid::character varying = l_objectid
AND programkey = l_programkey
RETURNING personprogramid)
INSERT INTO Temp_insert_person_program_area SELECT personprogramid from temp_ids;
END IF;
END IF;

-- Commented on 04/18/2023
/*
IF (l_exitdate IS NOT NULL) THEN
WITH temp_ids AS (UPDATE personprogramarea SET enddate = l_exitdate , updatedby =v_userid  
WHERE  personid =l_personid AND activeflag =1 AND enddate IS NULL AND objectid::character varying = l_objectid AND LOWER(programkey) = 'ooh'
RETURNING personprogramid)
INSERT INTO Temp_insert_person_program_area SELECT personprogramid from temp_ids;
END IF;
*/

ELSIF  (v_evencode ='PLTR') THEN
SELECT p.personid,p.enddatetime,servicecaseid INTO l_personid, l_enddate,l_objectid
FROM placement p  
WHERE p.activeflag =1   AND placementid = v_tranid::uuid AND enddatetime IS NOT NULL LIMIT 1;

ELSIF (v_evencode='SCDR') THEN
SELECT  servicecaseid::character varying INTO l_objectid
FROM servicecasedisposition  
WHERE  lower(dispositioncode) ='closed'  AND servicecasedispositionid  = v_tranid::uuid;
WITH temp_ids AS (UPDATE personprogramarea SET enddate=now(),updatedby=v_userid,updatedon=now(), datatransferflag='U'
WHERE objectid::character varying = l_objectid AND enddate IS NULL AND objecttypekey=v_objecttypekey
RETURNING personprogramid)
INSERT INTO Temp_insert_person_program_area SELECT personprogramid from temp_ids;

ELSIF (v_evencode='INDR') THEN
SELECT  isd.intakeserviceid::character varying INTO l_objectid
FROM servicerequesttypeconfigdispositioncode scd
INNER JOIN intakeservicerequestdispositioncode isd ON isd.servicerequesttypeconfigiddispostionid = scd.servicerequesttypeconfigiddispostionid
INNER JOIN intakeservicerequest isr ON isr.intakeserviceid = isd.intakeserviceid AND isr.actiontype ='AR'
WHERE  lower(dispositioncode) IN ('rfc','closed')  AND isd.intakeservicerequestdispositioncodeid  = v_tranid::uuid;

WITH temp_ids AS (UPDATE personprogramarea SET enddate=now(),updatedby=v_userid,updatedon=now(), datatransferflag='U'
WHERE objectid::character varying = l_objectid AND enddate IS NULL AND LOWER(objecttypekey)='servicerequest'
RETURNING personprogramid)
INSERT INTO Temp_insert_person_program_area SELECT personprogramid from temp_ids;

--## FOR IR CASES IF ALL FINDINGS ARE RULED OUT AND SUPERVISOR APPOVES IT THEN CLOSE ALL PROGRAM ASSIGNMENTS
SELECT  isd.intakeserviceid::character varying INTO l_objectid
FROM servicerequesttypeconfigdispositioncode scd
INNER JOIN intakeservicerequestdispositioncode isd ON isd.servicerequesttypeconfigiddispostionid = scd.servicerequesttypeconfigiddispostionid
INNER JOIN intakeservicerequest isr ON isr.intakeserviceid = isd.intakeserviceid AND isr.actiontype ='IR'
INNER JOIN intakeserreqstatustype t ON t.intakeserreqstatustypeid = isd.intakeserreqstatustypeid
WHERE   t.intakeserreqstatustypekey = 'Completed'
AND isd.intakeservicerequestdispositioncodeid  = v_tranid::uuid;

SELECT SUM(CASE findingtypekey
WHEN 'RO' THEN 0
WHEN 'ID' THEN 1
WHEN 'UD' THEN 1 END) INTO l_isallfinalized
FROM (SELECT DISTINCT investigationfindingtypekey findingtypekey
FROM investigation iv
INNER JOIN investigationallegation ia ON ia.investigationid = iv.investigationid
INNER JOIN investigationfinding id ON id.investigationallegationid = ia.investigationallegationid
INNER JOIN intakeservicerequest ir ON ir.intakeserviceid = iv.intakeserviceid
WHERE id.activeflag = 1 AND ir.intakeserviceid = l_objectid ::uuid
) v;

IF (l_isallfinalized = 0 ) THEN
RAISE NOTICE 'CAN END DATE ALL PROGRAM ASSIGNMENTS FOR %', l_objectid;
WITH temp_ids AS (UPDATE personprogramarea SET enddate=now(),updatedby=v_userid,updatedon=now(), datatransferflag='U' WHERE objectid::character varying = l_objectid AND enddate IS NULL
RETURNING personprogramid)
INSERT INTO Temp_insert_person_program_area SELECT personprogramid from temp_ids;

l_returnval := l_objectid;

--## FINALIZE THIS CPS IR CASE SINCE ALL ARE RULED OUT
UPDATE investigationallegationmaltreators im SET finalizeddate = now()::DATE
FROM (SELECT DISTINCT ia.investigationallegationid
FROM investigation iv
INNER JOIN investigationallegation ia ON ia.investigationid = iv.investigationid
INNER JOIN investigationfinding id ON id.investigationallegationid = ia.investigationallegationid
INNER JOIN intakeservicerequest ir ON ir.intakeserviceid = iv.intakeserviceid
WHERE iv.intakeserviceid = l_objectid::uuid) v
WHERE im.investigationallegationid = v.investigationallegationid;
END IF;

ELSIF (v_evencode='IRFINALIZE') THEN
SELECT  isa.intakeserviceid::character varying, isa.personid INTO l_objectid, l_personid
FROM investigationallegationmaltreators im
INNER JOIN investigationallegation ia ON ia.investigationallegationid = im.investigationallegationid AND ia.activeflag =1
INNER JOIN investigationmaltreatmentactor ima ON ima.maltreatmentid = ia.maltreatmentid AND ima.activeflag =1
INNER JOIN intakeservicerequestactor isa ON isa.intakeservicerequestactorid = ima.intakeservicerequestactorid AND isa.activeflag =1
WHERE  im.investigationallegationmaltreatorsid = v_tranid::uuid;

WITH temp_ids AS (UPDATE personprogramarea SET enddate=now(),updatedby=v_userid,updatedon=now(), datatransferflag='U' WHERE objectid::character varying = l_objectid AND enddate IS NULL AND LOWER(objecttypekey)='servicerequest' AND  personid =l_personid
RETURNING personprogramid)
INSERT INTO Temp_insert_person_program_area SELECT personprogramid from temp_ids;

SELECT  cnt INTO l_isallfinalized
FROM intakeservicerequest ir LEFT JOIN
(SELECT  isa.intakeserviceid, COUNT(1) cnt
FROM investigationallegationmaltreators im
INNER JOIN investigationallegation ia ON ia.investigationallegationid = im.investigationallegationid AND ia.activeflag =1
INNER JOIN investigationmaltreatmentactor ima ON ima.maltreatmentid = ia.maltreatmentid AND ima.activeflag =1
INNER JOIN intakeservicerequestactor isa ON isa.intakeservicerequestactorid = ima.intakeservicerequestactorid AND isa.activeflag =1
WHERE  isa.intakeserviceid = l_objectid::UUID AND im.finalizeddate IS NULL AND im.activeflag = 1
GROUP BY isa.intakeserviceid) v ON v.intakeserviceid = ir.intakeserviceid
WHERE ir.intakeserviceid = l_objectid::UUID;

RAISE NOTICE 'Can Perform Finalization - %', l_isallfinalized;
IF (l_isallfinalized IS NULL) THEN
WITH temp_ids AS (UPDATE personprogramarea SET enddate=now(),updatedby=v_userid,updatedon=now(), datatransferflag='U' WHERE objectid::character varying = l_objectid AND enddate IS NULL
RETURNING personprogramid)
INSERT INTO Temp_insert_person_program_area SELECT personprogramid from temp_ids;

l_returnval := l_objectid;
END IF;

ELSIF (v_evencode ='GARR') THEN
/*GET GAP Personid */

SELECT programkey, subprogramkey INTO l_programkey, l_subprogramkey FROM programareaconfig WHERE LOWER(servicerequestsubtypekey) = 'guardianship' AND isdefault =1 ;

SELECT G.servicecaseid::character varying,ISA.personid,GA.startdate,GA.enddate  INTO l_objectid,l_personid,l_startdate,l_exitdate
FROM gapagreement GA
INNER JOIN guardianship G on G.gapid = GA.gapid and G.activeflag =1
INNER JOIN permanencyplan PP on PP.permanencyplanid = G.permanencyplanid and PP.activeflag = 1
INNER JOIN intakeservicerequestactor ISA on ISA.intakeservicerequestactorid = PP.intakeservicerequestactorid --and ISA.activeflag =1
inner join gapagreementrate g2 on g2.gapagreementid  = GA.gapagreementid and g2.activeflag  =1
WHERE g2.gapagreementrateid = v_tranid::uuid order by g2.updatedon desc limit 1;

SELECT COUNT(1) INTO l_count FROM personprogramarea WHERE  personid =l_personid AND activeflag =1 AND enddate IS NULL AND objectid = l_objectid and programkey = l_programkey;

SELECT casenumber INTO l_casenumber FROM getcasenumber (v_objecttypekey, l_objectid ::character varying);

IF (COALESCE(l_count,0) =0) THEN
WITH temp_ids AS (INSERT INTO personprogramarea
(personid, programkey, subprogramkey,
objecttypekey, objectid, startdate,
insertedby, updatedby, entityid, datatransferflag, sourcetype)
VALUES( l_personid, l_programkey, l_subprogramkey,
v_objecttypekey, l_objectid, l_startdate::DATE,
v_userid, v_userid, l_casenumber, 'A', 'CW')
RETURNING personprogramid)
INSERT INTO Temp_insert_person_program_area SELECT personprogramid from temp_ids;

ELSE
--## END THIS GAP PROGRAM ASSIGNMENT WHEN END DATE OF AGREEMENT APPROVED AND LESS THEN TODAY
IF l_exitdate <= CURRENT_TIMESTAMP THEN
WITH temp_ids AS (UPDATE personprogramarea SET enddate=l_exitdate,updatedby=v_userid,updatedon=now(), datatransferflag='U' WHERE objectid::character varying = l_objectid AND enddate IS NULL AND programkey = 'GAP'
RETURNING personprogramid)
INSERT INTO Temp_insert_person_program_area SELECT personprogramid from temp_ids;
END IF;
END IF;

END IF;

with personids as(
	select
	  distinct  p.personid 
	from personprogramarea p 
	inner join Temp_insert_person_program_area t on t.personprogramid = p.personprogramid 
	where programkey = 'IHSFP' 	
	and subprogramkey = 'SFCI'
)
update person p
   set senstatusflag = 0,
	 updatedby = v_userid,
	 updatedon = now()
from personids pid
where p.personid = pid.personid;

FOR l_record IN (select personprogramid from Temp_insert_person_program_area group by personprogramid)
LOOP
  INSERT INTO auditlog(referenceid, logtypekey, description, metadata, insertedon, insertedby)
  VALUES(l_record.personprogramid,'PRGMAREA','systemupdate09',
            (SELECT row_to_json(personprogramarea) FROM personprogramarea WHERE personprogramid = l_record.personprogramid), now(), v_userid);
END LOOP;

DROP TABLE Temp_insert_person_program_area;

return l_returnval;

END ;
$function$
;