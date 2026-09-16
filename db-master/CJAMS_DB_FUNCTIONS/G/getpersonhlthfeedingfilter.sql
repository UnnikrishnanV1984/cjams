DROP FUNCTION IF EXISTS cjams.getpersonhlthfeeding_filter(request json, v_lipagenumber bigint, v_lipagesize bigint); --clean up _ ones in all envs
DROP FUNCTION IF EXISTS cjams.getpersonhlthfeedingfilter(request json, v_lipagenumber bigint, v_lipagesize bigint);
CREATE OR REPLACE FUNCTION cjams.getpersonhlthfeedingfilter(request json, v_lipagenumber bigint, v_lipagesize bigint)
 RETURNS TABLE(totalcount bigint, updatedby_fullname character varying, personhlthfeedingid uuid, provided_name character varying, relationship character varying, ishousehold boolean, iscollateral boolean, isfeedinginfoknown boolean, diettype jsonb, eatertype jsonb, liquids jsonb, solidfood jsonb, feeding_position jsonb, otherneeds jsonb, typeofformula character varying, amountperfeeding character varying, schedule character varying, v_insertedon timestamp without time zone, insertedby character varying, updatedon timestamp without time zone, updatedby character varying, activeflag integer, comments character varying,
 personid uuid,uploadpath json)
 LANGUAGE plpgsql
AS $function$

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
	pf.personhlthfeedingid, pf.providedname, pf.relationship, pf.ishousehold, pf.iscollateral, pf.isfeedinginfoknown, pf.diettype, pf.eatertype, pf.liquids, pf.solidfood, pf.feeding_position, pf.otherneeds, pf.typeofformula, pf.amountperfeeding, pf.schedule, pf.insertedon, pf.insertedby, pf.updatedon, pf.updatedby, pf.activeflag, pf.comments, pf.personid,
	(SELECT json_agg(docs) FROM  (
		SELECT dp.documentpropertiesid, dp.objecttypekey, dp.title, dp.actualdocumentdate, dp.documenttypekey, dp.insertedon, dp.updatedon,
		(select up.fullname as insertedby from userprofile up where up.securityusersid = dp.insertedby), dp.updatedby, dp.documentdate, dp.mime, dp.s3bucketpathname, dp.description, dp.other,dp.filename,dp.numberofbytes, dp.originalfilename,
		(SELECT row_to_json(x) AS documentattachment FROM(                                                                               
		SELECT dat.documentpropertiesid, dat.attachmenttypekey, dat.attachmentclassificationtypekey, dat.attachmentclassificationsubtypekey, dat.assessmenttemplateid,
		(select up.fullname as updatedby from userprofile up where up.securityusersid = dat.updatedby) from documentattachment dat                                                                                   
		WHERE dat.documentpropertiesid = dp.documentpropertiesid                                                  
		) x),dp.uploadstatus, dp.finalstatus,dp.ecmsdocumentid
	from documentproperties dp where dp.additionalobjectid = pf.personhlthfeedingid::varchar and dp.additionalobjecttype = 'personhlthfeeding' and dp.activeflag in (1,3,4,5)
	)docs) as uploadpath
FROM cjams.personhlthfeeding pf
LEFT JOIN userprofile u ON pf.updatedby = u.securityusersid
    where pf.personid = v_personid
	and pf.activeflag = 1
		and case when v_startDate is not null then pf.insertedon >= Date(v_startDate) else true end
	and case when v_endDate is not null then pf.insertedon <= Date(v_endDate) + 1 else true end
 LIMIT v_liPageSize OFFSET v_pageoffset; 
END;

$function$;