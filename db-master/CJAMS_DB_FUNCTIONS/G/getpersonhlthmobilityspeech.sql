DROP FUNCTION IF EXISTS cjams.getpersonhlthmobilityspeech(person_id uuid, v_lipagenumber bigint, v_lipagesize bigint);
CREATE OR REPLACE FUNCTION cjams.getpersonhlthmobilityspeech(person_id uuid, v_lipagenumber bigint, v_lipagesize bigint)
 RETURNS TABLE(totalcount bigint,updatedby_fullname character varying,  personhlthmobilityspeechid uuid, provided_name character varying, relationship character varying, relationship_desc character varying, ishousehold boolean, iscollateral boolean, ismbltyspchknown boolean, mblty jsonb, speech jsonb, satupage character varying, walkedage character varying, talkedage character varying, insertedon timestamp without time zone, insertedby character varying, updatedon timestamp without time zone, updatedby character varying, activeflag integer, comments character varying, personid uuid)
 LANGUAGE plpgsql
AS $function$

-- 06/18/2024 Anil Dharni -- CIDM-8991 Changes to bring to updatedby and updatedon

DECLARE  

v_pagenumber int;
v_pageoffset int;

BEGIN 

v_pagenumber := v_liPageNumber - 1;
v_pageoffset := v_pagenumber * v_liPageSize;

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
where pms.personid = person_id and pms.activeflag=1
LIMIT v_liPageSize OFFSET v_pageoffset; 

END;

$function$;
