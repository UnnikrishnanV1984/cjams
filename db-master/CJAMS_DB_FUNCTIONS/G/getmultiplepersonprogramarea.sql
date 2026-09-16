
DROP FUNCTION IF EXISTS cjams.getmultiplepersonprogramarea(v_objectid character varying, v_personid text);
CREATE OR REPLACE FUNCTION cjams.getmultiplepersonprogramarea(v_objectid character varying, v_personid text)
 RETURNS TABLE(personprogramarea json, persondetails json)
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 09/18/2023 Chandra/Palani - Performance tuning (CIDM-7944)

------------------------------------------------------------------------------------------------------------

DECLARE l_personprogramarea json;
        l_persondetails json;
v_person text[];


BEGIN

SELECT json_agg(ppg) INTO l_personprogramarea FROM (select * from (
SELECT ppa.personprogramid, ppa.startdate, ppa.enddate,
       ppa.personid, ppa.objecttypekey, ppa.objectid,
  ppa.endreasonkey,ppa.programkey, ppa.subprogramkey,
  ppa.datavalidflag, ppa.clientmergeid,ppa.ifpsatriskflag,
  sc.servicecasenumber As casenumber,
(
SELECT apa.programname FROM agencyprogramarea apa
WHERE apa.programkey = ppa.programkey AND apa.activeflag =1
),
(
SELECT rv.description AS subprogram FROM referencevalues rv
WHERE rv.ref_key = ppa.subprogramkey AND rv.referencetypeid = 12 AND rv.activeflag =1
),
(
SELECT rv.description AS endreason FROM referencevalues rv
WHERE rv.ref_key = ppa.endreasonkey AND rv.referencetypeid = 357 AND rv.activeflag =1
),
(SELECT (firstname ||' '|| lastname) AS updatedby FROM userprofile WHERE securityusersid = ppa.updatedby  LIMIT  1)
FROM person p
     INNER JOIN personprogramarea ppa ON ppa.personid = p.personid AND ppa.sourcetype = 'CW' AND p.activeflag =1
 INNER  JOIN  servicecase sc on  sc.servicecaseid= ppa.objectid::uuid    and sc.activeflag =1
WHERE ppa.personid = Any (v_personid :: uuid[])
 AND ppa.activeflag =1
 union
 SELECT ppa.personprogramid, ppa.startdate, ppa.enddate,
       ppa.personid, ppa.objecttypekey, ppa.objectid,
  ppa.endreasonkey,ppa.programkey, ppa.subprogramkey,
  ppa.datavalidflag, ppa.clientmergeid,ppa.ifpsatriskflag,
  sc.servicerequestnumber As casenumber,
(
SELECT apa.programname FROM agencyprogramarea apa
WHERE apa.programkey = ppa.programkey AND apa.activeflag =1
),
(
SELECT rv.description AS subprogram FROM referencevalues rv
WHERE rv.ref_key = ppa.subprogramkey AND rv.referencetypeid = 12 AND rv.activeflag =1
),
(
SELECT rv.description AS endreason FROM referencevalues rv
WHERE rv.ref_key = ppa.endreasonkey AND rv.referencetypeid = 357 AND rv.activeflag =1
),
(SELECT (firstname ||' '|| lastname) AS updatedby FROM userprofile WHERE securityusersid = ppa.updatedby  LIMIT  1)
FROM person p
     INNER JOIN personprogramarea ppa ON ppa.personid = p.personid AND ppa.sourcetype = 'CW' AND p.activeflag =1
 INNER  JOIN intakeservicerequest sc on sc.intakeserviceid = ppa.objectid::uuid  and sc.activeflag =1 and sc.teamtypekey ='CW'
  WHERE ppa.personid = Any (v_personid :: uuid[])
 AND ppa.activeflag =1
 union
 SELECT ppa.personprogramid, ppa.startdate, ppa.enddate,
       ppa.personid, ppa.objecttypekey, ppa.objectid,
  ppa.endreasonkey,ppa.programkey, ppa.subprogramkey,
  ppa.datavalidflag, ppa.clientmergeid,ppa.ifpsatriskflag,
  sc.adoptioncasenumber As casenumber,
(
SELECT apa.programname FROM agencyprogramarea apa
WHERE apa.programkey = ppa.programkey AND apa.activeflag =1
),
(
SELECT rv.description AS subprogram FROM referencevalues rv
WHERE rv.ref_key = ppa.subprogramkey AND rv.referencetypeid = 12 AND rv.activeflag =1
),
(
SELECT rv.description AS endreason FROM referencevalues rv
WHERE rv.ref_key = ppa.endreasonkey AND rv.referencetypeid = 357 AND rv.activeflag =1
),
(SELECT (firstname ||' '|| lastname) AS updatedby FROM userprofile WHERE securityusersid = ppa.updatedby  LIMIT  1)
FROM person p
     INNER JOIN personprogramarea ppa ON ppa.personid = p.personid AND ppa.sourcetype = 'CW' AND p.activeflag =1
 INNER  JOIN adoptioncase sc on  sc.adoptioncaseid= ppa.objectid::uuid  and sc.activeflag =1
  WHERE ppa.personid = Any (v_personid :: uuid[])
 AND ppa.activeflag =1) a ORDER BY coalesce(a.enddate, now()) DESC, a.startdate DESC
) AS ppg;

SELECT row_to_json(personinfo) INTO l_persondetails  FROM (
SELECT
p.cjamspid,
p.personid,
p.dob,
(p.firstname ||' '|| p.lastname) AS clientname
FROM person p
WHERE  P.personid = Any (v_personid :: uuid[])   AND p.activeflag =1
AND p.activeflag =1
) AS personinfo;

RETURN query select  l_personprogramarea,
       l_persondetails;      
end;

$function$
;
