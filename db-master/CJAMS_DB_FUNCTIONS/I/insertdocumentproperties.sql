drop FUNCTION  if exists cjams.insertdocumentproperties(v_uploadedpath json);

CREATE OR REPLACE FUNCTION cjams.insertdocumentproperties(v_uploadedpath json)
 RETURNS json
 LANGUAGE plpgsql
AS $function$ 

declare
v_uploadinfo JSON;
id uuid;
documentattachment json;
 v_array int[] ='{1,2}';
 v_array1 uuid[] ='{}';
v_result json;

a int;
begin
	for v_uploadinfo in select * from json_array_elements(v_uploadedpath) 
    LOOP 
	    INSERT INTO cjams.documentproperties
( objecttypekey, objectid, documenttypekey, documentdate, clientid, servicerequestid, 
thirdpartysourceid, filename, tag, title, description, mime, meta, "encoding", numberofbytes, 
updatedby, updatedon, insertedby, insertedon, activeflag, expirationdate, old_id, "timestamp",
voidedby, voidedon, voidreasonid, rootobjectid, rootobjecttypekey, s3bucketpathname, intakenumber, 
originalfilename, ecmsdocumentid, servicecaseid, etl_userid, etl_load_date, documenttemplatekey, 
repositoryid, prov_source_type, prov_source_id, actualdocumentdate, additionalobjectid, additionalobjecttype, other)
VALUES( v_uploadinfo->>'objecttypekey', (v_uploadinfo->>'objectid')::uuid,  v_uploadinfo->>'documenttypekey', now(),
(v_uploadinfo->>'clientid')::uuid, (v_uploadinfo->>'servicerequestid')::uuid, v_uploadinfo->>'thirdpartysourceid', v_uploadinfo->>'filename', 
v_uploadinfo->>'tag', v_uploadinfo->>'title', v_uploadinfo->>'description', v_uploadinfo->>'mime', v_uploadinfo->>'meta',
v_uploadinfo->>'encoding', (v_uploadinfo->>'numberofbytes')::int, v_uploadinfo->>'updatedby', now(), 
v_uploadinfo->>'insertedby', now(), 3, (v_uploadinfo->>'expirationdate')::date, v_uploadinfo->>'old_id', (v_uploadinfo->>'timestamp')::bytea ,
v_uploadinfo->>'voidedby', (v_uploadinfo->>'voidedon')::timestamp , (v_uploadinfo->>'voidreasonid')::uuid, (v_uploadinfo->>'rootobjectid')::uuid, 
v_uploadinfo->>'rootobjecttypekey', v_uploadinfo->>'s3bucketpathname', v_uploadinfo->>'intakenumber', v_uploadinfo->>'originalfilename', 
v_uploadinfo->>'ecmsdocumentid', (v_uploadinfo->>'servicecaseid')::uuid, v_uploadinfo->>'etl_userid', (v_uploadinfo->>'etl_load_date')::date, 
v_uploadinfo->>'documenttemplatekey', v_uploadinfo->>'repositoryid', v_uploadinfo->>'prov_source_type', v_uploadinfo->>'prov_source_id',
(v_uploadinfo->>'actualdocumentdate')::timestamp , v_uploadinfo->>'additionalobjectid', v_uploadinfo->>'additionalobjecttype', v_uploadinfo->>'other')
returning documentpropertiesid into id;
raise notice '%',id;
INSERT INTO cjams.documentattachment
(documentpropertiesid,attachmenttypekey,attachmentclassificationtypekey,attachmentid,attachmentdate,sourceauthor,sourceposition,sourcephonenumber,sourceaddress,attachmentsubject,attachmentpurpose,acquisitionmethod,locationoforiginal, note, updatedby, updatedon, insertedby, insertedon, activeflag, expirationdate, old_id, "timestamp", assessmenttemplateid, attachmentclassificationsubtypekey, etl_userid, etl_load_date)
select id, a.attachmenttypekey,a.attachmentclassificationtypekey,a.attachmentid ,a.attachmentdate,a.sourceauthor,a.sourceposition,a.sourcephonenumber,a.sourceaddress,a.attachmentsubject ,a.attachmentpurpose,a.acquisitionmethod ,a.locationoforiginal,a.note ,a.updatedby,now(),a.insertedby,now(),1,a.expirationdate ,a.old_id,a."timestamp",a.assessmenttemplateid ,a.attachmentclassificationsubtypekey,a.etl_userid,a.etl_load_date
from cjams.documentattachment a where documentpropertiesid=(v_uploadinfo->>'documentpropertiesid')::uuid ;
raise notice '%',documentattachment;
     v_array1 :=v_array1 || array[id];     
     END LOOP;

   --SELECT array_length(v_array, 1) into a FROM parametercodescontacttracks p  limit 1;
    raise notice '%',v_array1;
   
--   SELECT json_agg(pe)  result into v_result FROM 
--		(
			select json_agg(x)  into v_result from (select d.*,up.fullname as insertedby , (select row_to_json(y) as documentattachment from (select * from documentattachment da where da.documentpropertiesid=d.documentpropertiesid limit 1) as y)
            from documentproperties d LEFT JOIN userprofile up ON d.insertedby = up.securityusersid where d.documentpropertiesid =any(v_array1) and d.activeflag in (1,3)  ) 
            as x;
--		) pe;
		
	RETURN v_result;
	END;

$function$
;
