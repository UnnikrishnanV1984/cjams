DROP FUNCTION cjams.getpersonhlthfeeding(person_id uuid, v_lipagenumber bigint, v_lipagesize bigint);
CREATE OR REPLACE FUNCTION cjams.getpersonhlthfeeding(person_id uuid, v_lipagenumber bigint, v_lipagesize bigint)
 RETURNS TABLE(totalcount bigint, updatedby_fullname character varying, personhlthfeedingid uuid, provided_name character varying, relationship character varying, ishousehold boolean, iscollateral boolean, isfeedinginfoknown boolean, diettype jsonb, eatertype jsonb, liquids jsonb, solidfood jsonb, feeding_position jsonb, otherneeds jsonb, typeofformula character varying, amountperfeeding character varying, schedule character varying, v_insertedon timestamp without time zone, insertedby character varying, updatedon timestamp without time zone, updatedby character varying, activeflag integer, comments character varying,
 personid uuid,uploadpath json)
 LANGUAGE plpgsql
AS $function$

-- 06/18/2024 Anil Dharni -- CIDM-8991 Changes to bring to updatedby and updatedon
-- 06/21/2023 Manasa Kasula -- CIDM-7337 Changes to show the person updated by and updated on correctly

DECLARE  


v_pagenumber int;

v_pageoffset int;

	
	
BEGIN 





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
		) x)
	from documentproperties dp where dp.additionalobjectid = pf.personhlthfeedingid::varchar and dp.additionalobjecttype = 'personhlthfeeding' and dp.activeflag = 1
	)docs) as uploadpath
FROM cjams.personhlthfeeding pf
LEFT JOIN userprofile u ON pf.updatedby = u.securityusersid
    where pf.personid = person_id
	and pf.activeflag = 1
 LIMIT v_liPageSize OFFSET v_pageoffset; 
END;

$function$;
