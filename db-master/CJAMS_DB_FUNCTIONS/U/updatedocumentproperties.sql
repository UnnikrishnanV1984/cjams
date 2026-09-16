CREATE OR REPLACE FUNCTION cjams.updatedocumentproperties(v_person_id uuid, v_uploadedpath json, v_additionalobjectid character varying, v_additionalobjecttype character varying, v_oldadditionalobjectid character varying, v_insertedby character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$ 
-- 06/21/2023 Manasa Kasula -- CIDM-7337 Changes to show the person updated by and updated on correctly

DECLARE
v_uploadinfo JSON;

Begin

    for v_uploadinfo in select * from json_array_elements(v_uploadedpath) 
    LOOP 
        update cjams.documentproperties 
        set additionalobjectid = v_additionalobjectid, additionalobjecttype = v_additionalobjecttype, updatedby = v_insertedby, updatedon = (case when additionalobjectid is not null then updatedon else now() end)
        where documentpropertiesid = (v_uploadinfo ->> 'documentpropertiesid')::uuid;
     END LOOP;

     IF (v_oldadditionalobjectid is not null) THEN 
        update cjams.documentproperties 
        set activeflag = 0, updatedby = v_insertedby, updatedon = now() 
        where additionalobjectid = v_oldadditionalobjectid and additionalobjecttype = v_additionalobjecttype;
    END IF;

    Return 'Success';
END;

$function$;
