DROP FUNCTION IF EXISTS cjams.getbirthinfolist_filter(filters json, v_lipagenumber bigint, v_lipagesize bigint); --clean up _ ones in all envs
DROP FUNCTION IF EXISTS cjams.getbirthinfolistfilter(filters json, v_lipagenumber bigint, v_lipagesize bigint);
CREATE OR REPLACE FUNCTION cjams.getbirthinfolistfilter(filters json, v_lipagenumber bigint, v_lipagesize bigint)
 RETURNS JSON
 LANGUAGE plpgsql
AS $function$

-- 06/18/2024 Anil Dharni -- CIDM-8991 Changes to bring to updatedby and updatedon
-- 06/21/2023 Manasa Kasula -- CIDM-7337 Changes to show the person updated by and updated on correctly
-- 03/16/2025 Simar Singh -- CIDM-10103 add filter values for searching along with person id

DECLARE  
v_pagenumber int;
v_pageoffset int;
v_resultjson json;
v_personid uuid;
v_startDate timestamp;
v_endDate   timestamp; 
	
BEGIN 
v_pagenumber := v_liPageNumber - 1;
v_pageoffset := v_pagenumber * v_liPageSize;
v_startDate := (filters ->> 'startDate')::timestamp;
v_endDate := (filters ->> 'endDate')::timestamp;
v_personid := (filters ->> 'personid')::uuid;
	
	select json_build_object('personBirth', (select json_agg(x) from
            (select bi.mothersusepregnant,mothersusepregnantspecify,bi.mentalcondition,bi.mentalconditionspecify
            ,bi.diseasescondition,bi.diseasesconditionspecify,bi.birthdefects,bi.comments,
            u.fullname AS updatedby,
            bi.updatedon,
            bi.insertedon,
            (SELECT json_agg(docs) FROM  (
                SELECT dp.documentpropertiesid, dp.objecttypekey, dp.title, dp.actualdocumentdate, dp.documenttypekey, dp.insertedon, dp.updatedon, 
                (select up.fullname as insertedby from userprofile up where up.securityusersid = dp.insertedby),
                dp.updatedby, dp.documentdate, dp.mime, dp.s3bucketpathname, dp.description, dp.other,dp.filename,dp.numberofbytes, dp.originalfilename,
                (SELECT row_to_json(x) AS documentattachment FROM(                                                                               
                SELECT dat.documentpropertiesid, dat.attachmenttypekey, dat.attachmentclassificationtypekey, dat.attachmentclassificationsubtypekey, dat.assessmenttemplateid,
                (select up.fullname as updatedby from userprofile up where up.securityusersid = dat.updatedby) from documentattachment dat                                                                                   
                WHERE dat.documentpropertiesid = dp.documentpropertiesid                                                  
                ) x),dp.uploadstatus, dp.finalstatus,dp.ecmsdocumentid 
            from documentproperties dp where dp.additionalobjectid = bi.birthhealthinfoid::varchar and dp.additionalobjecttype = 'birthhealthinfo' and dp.activeflag in (1,3,4,5)
            )docs) as uploadpath 
            from birthhealthinfo bi LEFT JOIN userprofile u ON bi.updatedby = u.securityusersid where bi.personid= v_personid and bi.activeflag=1 
            and case when v_startDate is not null then Date(bi.insertedon) >= Date(v_startDate) else true end
            and case when v_endDate is not null then Date(bi.insertedon) <= Date(v_endDate) else true end
            order by bi.insertedon
            ) as x ),
            'underfive', (select json_agg(a) from (
            select  ci.prenatalcaretypekey as prenatalproblem ,ci.gestation,ci.parentcare,ci.deliverytypekey as deliverytype,ci.hospitalname as childbornin,ci.address1,
            ci.address2,ci.phone,ci.email,ci.cityname as city,ci.statetypekey as state,ci.county,ci.zip5no,
            ci.deliverycomplicationnotes,ci.complicationsspecify,ci.comments,
            (SELECT json_agg(docs) FROM  (
                SELECT dp.documentpropertiesid, dp.objecttypekey, dp.title, dp.actualdocumentdate, dp.documenttypekey, dp.insertedon, dp.updatedon,
                (select up.fullname as insertedby from userprofile up where up.securityusersid = dp.insertedby), dp.updatedby, dp.documentdate, dp.mime, dp.s3bucketpathname, dp.description, dp.other,dp.filename,dp.numberofbytes, dp.originalfilename,
                (SELECT row_to_json(x) AS documentattachment FROM(                                                                               
                SELECT dat.documentpropertiesid, dat.attachmenttypekey, dat.attachmentclassificationtypekey, dat.attachmentclassificationsubtypekey, dat.assessmenttemplateid,
                (select up.fullname as updatedby from userprofile up where up.securityusersid = dat.updatedby) from documentattachment dat                                                                                   
                WHERE dat.documentpropertiesid = dp.documentpropertiesid                                                  
                ) x),dp.uploadstatus, dp.finalstatus,dp.ecmsdocumentid
            from documentproperties dp where dp.additionalobjectid = ci.clientunder5yearsinfoid::varchar and dp.additionalobjecttype = 'clientunder5yearsinfo' and dp.activeflag in (1,3,4,5)
            )docs) as uploadpath,
            ci.whenbegun,ci.parity,ci.prenatalproblemspecify,ci.complications,ci.hospitalcomments,ci.speciality
              from clientunder5yearsinfo ci  where ci.personid= v_personid and ci.activeflag=1 
              and case when v_startDate is not null then Date(ci.insertedon) >= Date(v_startDate) else true end
              and case when v_endDate is not null then Date(ci.insertedon) <= Date(v_endDate) else true end
              order by ci.insertedon
            ) as a )  
            ) as json into v_resultjson;

            return v_resultjson;
END;

$function$
;