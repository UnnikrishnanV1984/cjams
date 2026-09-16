DROP FUNCTION IF EXISTS cjams.getpersonhlthmobilityspeech_filter(request json, v_lipagenumber bigint, v_lipagesize bigint); --clean up _ ones in all envs
DROP FUNCTION IF EXISTS cjams.getpersonhlthmobilityspeechfilter(request json, v_lipagenumber bigint, v_lipagesize bigint);
CREATE OR REPLACE FUNCTION cjams.getpersonhlthmobilityspeechfilter(request json, v_lipagenumber bigint, v_lipagesize bigint)
 RETURNS TABLE(totalcount bigint,updatedby_fullname character varying,  personhlthmobilityspeechid uuid, provided_name character varying, relationship character varying, relationship_desc character varying, ishousehold boolean, iscollateral boolean, ismbltyspchknown boolean, mblty jsonb, speech jsonb, satupage character varying, walkedage character varying, talkedage character varying, insertedon timestamp without time zone, insertedby character varying, updatedon timestamp without time zone, updatedby character varying, activeflag integer, comments character varying, personid uuid)
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
pms.personhlthmobilityspeechid, pms.providedname, pms.relationship, 
rtype.description::character varying as relationship_desc, pms.ishousehold, 
pms.iscollateral, pms.ismbltyspchknown, pms.mblty, pms.speech, pms.satupage, pms.walkedage, pms.talkedage, pms.insertedon, 
pms.insertedby, pms.updatedon, pms.updatedby, pms.activeflag, pms.comments, pms.personid
FROM personhlthmobilityspeech pms
LEFT JOIN userprofile u ON pms.updatedby = u.securityusersid
LEFT JOIN relationshiptype rtype on pms.relationship = rtype.relationshiptypekey AND rtype.activeflag = 1 
where pms.personid = v_personid and pms.activeflag=1
	and case when v_startDate is not null then pms.insertedon >= Date(v_startDate) else true end
	and case when v_endDate is not null then pms.insertedon <= Date(v_endDate) + 1 else true end
LIMIT v_liPageSize OFFSET v_pageoffset; 

END;

$function$;