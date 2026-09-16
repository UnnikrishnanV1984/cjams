DROP FUNCTION IF EXISTS cjams.getpersonhlthsleeping_filter(request json, v_lipagenumber bigint, v_lipagesize bigint);  --clean up _ ones in all envs
DROP FUNCTION IF EXISTS cjams.getpersonhlthsleepingfilter(request json, v_lipagenumber bigint, v_lipagesize bigint); 
CREATE OR REPLACE FUNCTION cjams.getpersonhlthsleepingfilter(request json, v_lipagenumber bigint, v_lipagesize bigint)
 RETURNS TABLE(totalcount bigint, updatedby_fullname character varying, personhlthsleepingid uuid, providedname character varying, relationship character varying, ishousehold boolean, iscollateral boolean, issleepinginfoknown boolean, sleepingenvironment jsonb, sleepingproblems jsonb, sleepingposition jsonb, sleepingpositiondesc character varying, sleepingschedule_naptime timestamp without time zone, sleepingschedule_bedtime timestamp without time zone, insertedon timestamp without time zone, insertedby character varying, updatedon timestamp without time zone, updatedby character varying, activeflag integer, comments character varying, personid uuid, otherspecify character varying)
 LANGUAGE plpgsql
AS $function$

-- 03/24/2025 Simar Singh -- CIDM-10103 add filter values for searching along with person id

DECLARE  

v_pagenumber int;
v_pageoffset int;
v_personid uuid;
v_startDate timestamp;
v_endDate timestamp;
	
BEGIN 


v_pagenumber := v_liPageNumber - 1;
v_pageoffset := v_pagenumber * v_liPageSize;
v_startDate := (request ->> 'startDate')::timestamp;
v_endDate := (request ->> 'endDate')::timestamp;
v_personid := (request ->> 'personid')::uuid;

	return query		
	select count(1) over() as totalcount,
  u.fullname AS updatedby_fullname,
	phs.personhlthsleepingid, phs.providedname, phs.relationship, phs.ishousehold, phs.iscollateral, phs.issleepinginfoknown, phs.sleepingenvironment, phs.sleepingproblems, phs.sleepingposition,
	(select value_tx from tb_picklist_values where trim(picklist_value_cd)=(phs.sleepingposition)::text and picklist_type_id=201 limit 1) as sleepingpositiondesc,phs.sleepingschedule_naptime, phs.sleepingschedule_bedtime, phs.insertedon, phs.insertedby, phs.updatedon, phs.updatedby,
	phs.activeflag, phs.comments, phs.personid, phs.otherspecify
FROM personhlthsleeping phs
LEFT JOIN userprofile u ON phs.updatedby = u.securityusersid
    where phs.personid = v_personid
	and phs.activeflag = 1
	and case when v_startDate is not null then phs.insertedon >= Date(v_startDate) else true end
	and case when v_endDate is not null then phs.insertedon <= Date(v_endDate) + 1 else true end
 LIMIT v_liPageSize OFFSET v_pageoffset; 
END;

$function$