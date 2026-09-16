DROP FUNCTION cjams.getpersonfamilyhistory(person_id uuid, v_lipagenumber bigint, v_lipagesize bigint);
CREATE OR REPLACE FUNCTION cjams.getpersonfamilyhistory(person_id uuid, v_lipagenumber bigint, v_lipagesize bigint)
 RETURNS TABLE(totalcount bigint, personfmlymdcl_hstryid uuid, personid uuid, major_health_problems json, clientlist character varying, relationship character varying, updatedby character varying, 
    updatedon timestamp, insertedon timestamp, cause_of_death json, comments character varying, uploadpath json)
 LANGUAGE plpgsql
AS $function$
-- 06/18/2024 Anil Dharni -- CIDM-8991 Changes to bring to updatedby and updatedon
-- 06/21/2023 Manasa Kasula -- CIDM-7337 Changes to show the person updated by and updated on correctly
-- 03/24/2025 Simar Singh -- CIDM-10103 return insertedon value for showing records

DECLARE  


	v_pagenumber int;
	v_pageoffset int;
	
	
BEGIN 

v_pagenumber := v_liPageNumber - 1;
v_pageoffset := v_pagenumber * v_liPageSize;

	return query
		
	select count(1) over() as totalcount,
	pfh.personfmlymdclhstryid,pfh.personid,
	personfmhist_hlthproblist(pfh.personfmlymdclhstryid),
	pfh.famhistclient as client_name,
	pfh.famhistrelationtype,
	u.fullname AS updatedby,
    pfh.updatedon,
	pfh.insertedon,
	--pfh.deathcausetype,
	( select json_build_object(
'description_tx',b.description_tx,'picklist_value_cd',trim(b.picklist_value_cd),'picklist_type_id',b.picklist_type_id,'value_tx',b.value_tx)
from tb_picklist_values b where trim(b.picklist_value_cd) = trim(pfh.deathcausetype) and b.picklist_type_id = 34
   ) as deathcausetype,
	pfh."comments" ,
	(SELECT json_agg(docs) FROM  (
		SELECT dp.documentpropertiesid, dp.objecttypekey, dp.title, dp.actualdocumentdate, dp.documenttypekey, dp.insertedon, dp.updatedon,
		(select up.fullname as insertedby from userprofile up where up.securityusersid = dp.insertedby), dp.updatedby, dp.documentdate, dp.mime, dp.s3bucketpathname, dp.description, dp.other,dp.filename,dp.numberofbytes, dp.originalfilename,
		(SELECT row_to_json(x) AS documentattachment FROM(                                                                               
		SELECT dat.documentpropertiesid, dat.attachmenttypekey, dat.attachmentclassificationtypekey, dat.attachmentclassificationsubtypekey, dat.assessmenttemplateid,
		(select up.fullname as updatedby from userprofile up where up.securityusersid = dat.updatedby) from documentattachment dat                                                                                   
		WHERE dat.documentpropertiesid = dp.documentpropertiesid                                                  
		) x)
	from documentproperties dp where dp.additionalobjectid = pfh.personfmlymdclhstryid::varchar and dp.additionalobjecttype = 'personfmlymdclhstry' and dp.activeflag = 1
	)docs) as uploadpath
	from personfmlymdclhstry pfh
	LEFT JOIN userprofile u ON pfh.updatedby = u.securityusersid 
    where pfh.personid = person_id and pfh.activeflag=1
 LIMIT v_liPageSize OFFSET v_pageoffset; 
END;

$function$
;