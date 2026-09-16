DROP FUNCTION IF EXISTS cjams.getproviderinfo_filter(request json, v_lipagenumber bigint, v_lipagesize bigint); --clean up _ ones in all envs
DROP FUNCTION IF EXISTS cjams.getproviderinfofilter(request json, v_lipagenumber bigint, v_lipagesize bigint);
CREATE OR REPLACE FUNCTION cjams.getproviderinfofilter(request json, v_lipagenumber bigint, v_lipagesize bigint)
 RETURNS TABLE(totalcount bigint, updatedby character varying, 
    updatedon timestamp, personphycisianinfo_id uuid, personid uuid, is_primary_care_physician boolean, physician_name character varying, physician_facility character varying, physician_child_lang_check boolean, translation_service_available boolean, startdate timestamp without time zone, enddate timestamp without time zone, physician_phone character varying, physician_email character varying, physician_speciality character varying, physician_speciality_desc character varying, otherspeciality character varying, degreetype character varying, degreetype_desc character varying, address1 character varying, address2 character varying, city character varying, state character varying, zipcode character varying, county character varying, uploadpath json)
 LANGUAGE plpgsql
AS $function$

-- 02/28/2025 -- Akhil Katukuri - CIDM-10103 - provider information and filtering
-- 03/24/2025 Simar Singh -- CIDM-10103 add filter values for searching along with person id

declare

v_pagenumber int;
v_personid uuid;
v_startDate timestamp;
v_endDate timestamp;
v_pageoffset int;
begin

v_pagenumber := v_liPageNumber - 1;

v_pageoffset := v_pagenumber * v_liPageSize;
v_startDate := (request ->> 'startDate')::timestamp;
v_endDate := (request ->> 'endDate')::timestamp;
v_personid := (request ->> 'personid')::uuid;

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
	ppi.otherspeciality,
	ppi.degreetype,
	(SELECT description FROM referencevalues r WHERE ref_key = ppi.degreetype AND referencetypeid = 335 AND teamtypekey = 'CW' ORDER BY r.updatedon LIMIT 1) AS degreetype_desc,
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
	ppi.personid = v_personid
	and ppi.activeflag = 1
		and case when v_startDate is not null then ppi.insertedon >= Date(v_startDate) else true end
	and case when v_endDate is not null then ppi.insertedon <= Date(v_endDate) + 1 else true end
limit v_liPageSize offset v_pageoffset;
end;

$function$
;