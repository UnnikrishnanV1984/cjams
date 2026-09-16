DROP FUNCTION cjams.getpersonhlthelimination(person_id uuid, v_lipagenumber bigint, v_lipagesize bigint);
CREATE OR REPLACE FUNCTION cjams.getpersonhlthelimination(person_id uuid, v_lipagenumber bigint, v_lipagesize bigint)
 RETURNS TABLE(totalcount bigint, updatedby_fullname character varying, v_personhltheliminationid uuid, v_providedname character varying, v_relationship character varying, v_ishousehold boolean, v_iscollateral boolean, v_iseliminationinfoknown boolean, v_considerunknown boolean, v_elimination_currentstatus jsonb, v_toilettrainingmethod jsonb, v_wordforbowelmovement character varying, v_wordforurination character varying, v_insertedon timestamp without time zone, v_insertedby character varying, v_updatedon timestamp without time zone, v_updatedby character varying, v_activeflag integer, v_toiletcomments character varying, v_specialcomments character varying, v_personid uuid, v_otherspecify character varying)
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
	personhltheliminationid, providedname, relationship, ishousehold, iscollateral, iseliminationinfoknown,isspecialconsiderunknown, elimination_currentstatus, toilettrainingmethod, wordforbowelmovement, wordforurination, phe.insertedon, phe.insertedby, phe.updatedon, phe.updatedby, phe.activeflag, "comments",specialcomments, personid, otherspecify
FROM personhlthelimination phe
LEFT JOIN userprofile u ON phe.updatedby = u.securityusersid
    where personid = person_id
	and phe.activeflag = 1
 LIMIT v_liPageSize OFFSET v_pageoffset; 
END;

$function$;
