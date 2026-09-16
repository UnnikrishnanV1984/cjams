DROP FUNCTION cjams.getproviderinfo(person_id uuid, v_lipagenumber bigint, v_lipagesize bigint);
CREATE OR REPLACE FUNCTION cjams.getproviderinfo(person_id uuid, v_lipagenumber bigint, v_lipagesize bigint)
 RETURNS TABLE(totalcount bigint, updatedby character varying, 
    updatedon timestamp, personphycisianinfo_id uuid, personid uuid, is_primary_care_physician boolean, physician_name character varying, physician_facility character varying, physician_child_lang_check boolean, translation_service_available boolean, startdate timestamp without time zone, enddate timestamp without time zone, physician_phone character varying, physician_email character varying, physician_speciality character varying, physician_speciality_desc character varying, otherspeciality character varying, degreetype character varying, address1 character varying, address2 character varying, city character varying, state character varying, zipcode character varying, county character varying, uploadpath json)
 LANGUAGE plpgsql
AS $function$

-- 06/18/2024 Anil Dharni -- CIDM-8991 Changes to bring to updatedby and updatedon
-- 06/21/2023 Manasa Kasula -- CIDM-7337 Changes to show the person updated by and updated on correctly

declare

v_pagenumber int;

v_pageoffset int;
begin

v_pagenumber := v_liPageNumber - 1;

v_pageoffset := v_pagenumber * v_liPageSize;

return query

select
	count(1) over() as totalcount,
	u.fullname AS updatedby,
    ppi.updatedon,
	ppi.personphycisianinfoid,
	ppi.personid,
	ppi.isprimaryphycisian,
	ppi."name",
	ppi.facility,
    ppi.physician_child_lang_check,
	ppi.translation_service_available,
		ppi.startdate,
	ppi.enddate,	
		ppi.phone ,
	ppi.email ,
	ppi.physician_speciality,	
	ps.description as physician_speciality_desc,
	ppi.otherspeciality ,
	ppi.degreetype ,
	ppi.address1,
	ppi.address2,
	ppi.city,
	ppi.state,
		ppi.zip,
	(select c.countyname from county c where c.countyid = ppi.countyid) county,
	(SELECT json_agg(docs) FROM  (
		SELECT dp.documentpropertiesid, dp.objecttypekey, dp.title, dp.actualdocumentdate, dp.documenttypekey, dp.insertedon, dp.updatedon,
		(select up.fullname as insertedby from userprofile up where up.securityusersid = dp.insertedby), 
		dp.updatedby, dp.documentdate, dp.mime, dp.s3bucketpathname, dp.description, dp.other,dp.filename,dp.numberofbytes, dp.originalfilename,
		(SELECT row_to_json(x) AS documentattachment FROM(                                                                               
		SELECT dat.documentpropertiesid, dat.attachmenttypekey, dat.attachmentclassificationtypekey, dat.attachmentclassificationsubtypekey, dat.assessmenttemplateid,
		(select up.fullname as updatedby from userprofile up where up.securityusersid = dat.updatedby) from documentattachment dat                                                                                   
		WHERE dat.documentpropertiesid = dp.documentpropertiesid                                                  
		) x),dp.uploadstatus, dp.finalstatus, dp.ecmsdocumentid
	from documentproperties dp where dp.additionalobjectid = ppi.personphycisianinfoid::varchar and dp.additionalobjecttype = 'personphycisianinfo' and dp.activeflag in (1,3,4,5)
	)docs) as uploadpath
from
	personphycisianinfo ppi
	 LEFT JOIN userprofile u ON ppi.updatedby = u.securityusersid 
inner join physicianspecialtytype as ps on ps.physicianspecialtytypekey = ppi.physician_speciality and ps.activeflag = 1
where
	ppi.personid = person_id
	and ppi.activeflag = 1
limit v_liPageSize offset v_pageoffset;
end;

$function$
;
