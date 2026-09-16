DROP FUNCTION IF EXISTS getpersonprogramarea(v_objectid character varying, v_personid uuid);
DROP FUNCTION IF EXISTS getpersonprogramarea(character varying, uuid,integer,character varying);
DROP FUNCTION IF EXISTS getpersonprogramarea(character varying, uuid,integer,character varying, integer);
DROP FUNCTION IF EXISTS getpersonprogramarea(character varying, uuid,integer, integer);
CREATE OR REPLACE FUNCTION getpersonprogramarea(v_objectid character varying, v_personid uuid,isExpungementSuperUser integer DEFAULT 0, isexpunged integer DEFAULT 0)
 RETURNS TABLE(personprogramarea json, persondetails json)
 LANGUAGE plpgsql
AS $function$

-----------------------------------------------------------------------------------------------------
--Revision(s)
-- 08/08/2025 - CIDM-10473 - Simar Singh - adding 'ishousehold' info along with the program area
-----------------------------------------------------------------------------------------------------

DECLARE l_personprogramarea json;
        l_persondetails json;
		v_isexpunged integer; 
		v_uuidornot character varying(50);
BEGIN

v_isexpunged := 0;
IF isExpungementSuperUser = 1 THEN
	v_isexpunged = isexpunged;
END IF;
 
IF v_isexpunged = 1 THEN 
-------------------------------------------------------------------------------------------------
       -- Fully expunged
----------------------------------------------------------------------------------------------------


	SELECT json_agg(ppg) INTO l_personprogramarea FROM 
	(
		SELECT 
		ppa.personprogramid, date(ppa.startdate) as startdate, date(ppa.enddate) as enddate,
		ppa.personid, ppa.objecttypekey, ppa.objectid,
		ppa.endreasonkey,ppa.programkey, ppa.subprogramkey,
		ppa.datavalidflag, ppa.clientmergeid,ppa.ifpsatriskflag,
		ppa.entityid As casenumber,
		(SELECT apa.programname FROM agencyprogramarea apa WHERE apa.programkey = ppa.programkey AND apa.activeflag =1),
		(SELECT rv.description AS subprogram FROM referencevalues rv WHERE rv.ref_key = ppa.subprogramkey AND rv.referencetypeid = 12 AND rv.activeflag =1),
		(SELECT rv.description AS endreason FROM referencevalues rv WHERE rv.ref_key = ppa.endreasonkey AND rv.referencetypeid = 357 AND rv.activeflag =1),
		(SELECT (firstname ||' '|| lastname) AS updatedby FROM v_userprofile WHERE securityusersid = ppa.updatedby  LIMIT  1),
		(SELECT ac.ishouseholdmember 
			FROM expunge.actor_expunge ac
			JOIN expunge.intakeservicerequestactor_expunge isra ON ac.actorid = isra.actorid AND isra.activeflag = 1
			WHERE ac.activeflag = 1 AND isra.personid = v_personid
				AND
				(CASE 
					WHEN ppa.objecttypekey = 'servicecase' THEN isra.servicecaseid = ppa.objectid::uuid
					WHEN ppa.objecttypekey = 'servicerequest' THEN isra.intakeserviceid = ppa.objectid::uuid
					ELSE FALSE
				END) LIMIT 1
		) AS ishousehold,
		ppa.datatransferflag,
		ppa.isdefault
		FROM personprogramarea ppa 		   
		WHERE ppa.personid = v_personid AND ((ppa.activeflag =0 and ppa.isexpunged = 1) or ppa.activeflag =1)  and ppa.sourcetype = 'CW'
		ORDER BY COALESCE(ppa.enddate, now()) DESC, ppa.startdate DESC
	) AS ppg;

ELSE 
	-------------------------------------------------------------------------------------------------
       -- Partial expunged or Normal
	----------------------------------------------------------------------------------------------------

	SELECT json_agg(ppg) INTO l_personprogramarea FROM 
	(
		SELECT 
		ppa.personprogramid, date(ppa.startdate) as startdate, date(ppa.enddate) as enddate,
		ppa.personid, ppa.objecttypekey, ppa.objectid,
		ppa.endreasonkey,ppa.programkey, ppa.subprogramkey,
		ppa.datavalidflag, ppa.clientmergeid,ppa.ifpsatriskflag,
		ppa.entityid As casenumber,
		(SELECT apa.programname FROM agencyprogramarea apa WHERE apa.programkey = ppa.programkey AND apa.activeflag =1),
		(SELECT rv.description AS subprogram FROM referencevalues rv WHERE rv.ref_key = ppa.subprogramkey AND rv.referencetypeid = 12 AND rv.activeflag =1),
		(SELECT rv.description AS endreason FROM referencevalues rv WHERE rv.ref_key = ppa.endreasonkey AND rv.referencetypeid = 357 AND rv.activeflag =1),
		(SELECT (firstname ||' '|| lastname) AS updatedby FROM v_userprofile WHERE securityusersid = ppa.updatedby  LIMIT  1),
		(SELECT ac.ishouseholdmember 
			FROM actor ac
			JOIN intakeservicerequestactor isra ON ac.actorid = isra.actorid AND isra.activeflag = 1
			WHERE ac.activeflag = 1 AND isra.personid = v_personid
				AND
				(CASE 
					WHEN ppa.objecttypekey = 'servicecase' THEN isra.servicecaseid = ppa.objectid::uuid
					WHEN ppa.objecttypekey = 'servicerequest' THEN isra.intakeserviceid = ppa.objectid::uuid
					ELSE FALSE
				END) LIMIT 1
			) AS ishousehold,
		ppa.datatransferflag,
			ppa.isdefault
		FROM personprogramarea ppa 		   
		WHERE ppa.personid = v_personid AND ppa.activeflag =1 and ppa.sourcetype = 'CW'
		ORDER BY COALESCE(ppa.enddate, now()) DESC, ppa.startdate DESC
	) AS ppg;
END IF;

SELECT row_to_json(personinfo) INTO l_persondetails  FROM (
	SELECT 
		p.cjamspid,
		p.personid, 
		p.dob,
		(p.firstname ||' '|| p.lastname) AS clientname,
		coalesce((select pii.personidentifiervalue from personidentifier pii where pii.personidentifiertypekey = 'IRN' and pii.personid = p.personid and pii.activeflag = 1 limit 1), p.cisclientid) as cisclientid
		FROM person p
	WHERE  P.personid = v_personid AND p.activeflag =1
	AND p.activeflag =1
) AS personinfo;

RETURN query select  l_personprogramarea, l_persondetails;      
end;

$function$
;
