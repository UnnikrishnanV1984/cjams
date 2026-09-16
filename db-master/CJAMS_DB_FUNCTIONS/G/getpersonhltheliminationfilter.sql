DROP FUNCTION IF EXISTS cjams.getpersonhlthelimination_filter(request json, v_lipagenumber bigint, v_lipagesize bigint); --clean up _ ones in all envs
DROP FUNCTION IF EXISTS cjams.getpersonhltheliminationfilter(request json, v_lipagenumber bigint, v_lipagesize bigint);
CREATE OR REPLACE FUNCTION cjams.getpersonhltheliminationfilter(request json, v_lipagenumber bigint, v_lipagesize bigint)
 RETURNS TABLE(totalcount bigint, updatedby_fullname character varying, v_personhltheliminationid uuid, v_providedname character varying, v_relationship character varying, v_ishousehold boolean, v_iscollateral boolean, v_iseliminationinfoknown boolean, v_considerunknown boolean, v_elimination_currentstatus jsonb, v_toilettrainingmethod jsonb, v_wordforbowelmovement character varying, v_wordforurination character varying, v_insertedon timestamp without time zone, v_insertedby character varying, v_updatedon timestamp without time zone, v_updatedby character varying, v_activeflag integer, v_toiletcomments character varying, v_specialcomments character varying, v_personid uuid, v_otherspecify character varying)
 LANGUAGE plpgsql
AS $function$

-- 02/28/2024 Akhil Katukuri -- CIDM-10103 Person health elimination info and filtering
-- 03/24/2025 Simar Singh -- CIDM-10103 add filter values for searching along with person id

DECLARE  
v_personid uuid;
v_startDate timestamp;
v_endDate timestamp;

v_pagenumber int;

v_pageoffset int;

	
	
BEGIN 

v_startDate := (request ->> 'startDate')::timestamp;
v_endDate := (request ->> 'endDate')::timestamp;
v_personid := (request ->> 'personid')::uuid;


v_pagenumber := v_liPageNumber - 1;
v_pageoffset := v_pagenumber * v_liPageSize;

	return query		
	select count(1) over() as totalcount,
	u.fullname AS updatedby_fullname,
	personhltheliminationid, providedname, relationship, ishousehold, iscollateral, iseliminationinfoknown,isspecialconsiderunknown, elimination_currentstatus, toilettrainingmethod, wordforbowelmovement, wordforurination, phe.insertedon, phe.insertedby, phe.updatedon, phe.updatedby, phe.activeflag, "comments",specialcomments, personid, otherspecify
FROM personhlthelimination phe
LEFT JOIN userprofile u ON phe.updatedby = u.securityusersid
    where personid = v_personid
	and phe.activeflag = 1
	and case when v_startDate is not null then phe.insertedon >= Date(v_startDate) else true end
	and case when v_endDate is not null then phe.insertedon <= Date(v_endDate) + 1 else true end
 LIMIT v_liPageSize OFFSET v_pageoffset; 
END;

$function$;