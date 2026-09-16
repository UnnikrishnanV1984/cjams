DROP FUNCTION IF exists cjams.addupdateform1080b(formdata json, v_userid character varying);
CREATE OR REPLACE FUNCTION cjams.addupdateform1080b(formdata json, v_userid character varying)
 RETURNS TABLE(message text, formid uuid)
 LANGUAGE plpgsql
AS $function$

-------------------------------------------------------------------------
--  06-09-2025 - CIDM-10539 1080 Form B - Naveenkumar Chemutu 
-------------------------------------------------------------------------

DECLARE
 v_formId uuid;
 v_existingId uuid;
begin
	
 -- Safely extract UUID only if it's valid
	 BEGIN
	 IF nullif(trim(formData ->> 'form1080bid'), '') IS NOT NULL THEN
	 v_formId := (formData ->> 'form1080bid')::uuid;
	 END IF;
	 EXCEPTION WHEN others THEN
	 v_formId := NULL;
	 END;

	 -- Check if the ID exists in DB
	 IF v_formId IS NOT NULL THEN
	 SELECT form1080bid INTO v_existingId FROM form1080b WHERE form1080bid = v_formId;
	 END IF;
	
	 IF v_existingId IS NULL THEN
	 -- Insert into form1080b
	 v_formId := gen_random_uuid();
   

        INSERT INTO form1080b (
           form1080bid, 
           objectid, 
           objecttype, 
           casenumber,
           personid, 
           provideasummaryoftheinvestigationandidentifyanybarriestheldss,
           whatisthemedicalexaminerspreliminaryfinding, 
           signatureofpersoncompletingthisreport, 
           datecompleted, 
           copyofform1080b,
           submitforapproval,
            supervisorcomments,
            status,
           activeflag, 
           insertedby, 
           insertedon, 
           updatedby, 
           updatedon
        ) VALUES (
           v_formId,
            (formData ->> 'objectid')::character varying,
            (formData ->> 'objecttype')::character varying,
            (formData ->> 'casenumber')::character varying,
            (formData ->> 'personid')::uuid,            
            (formData ->> 'provideasummaryoftheinvestigationandidentifyanybarriestheldss')::character varying,
            (formData ->> 'whatisthemedicalexaminerspreliminaryfinding')::character varying,            
            (formData ->> 'signatureofpersoncompletingthisreport')::character varying,            
            (formData ->> 'datecompleted')::timestamp,
            (formData ->> 'copyofform1080b')::JSON,             
            (formData ->> 'submitforapproval')::character varying,             
            (formData ->> 'supervisorcomments')::character varying,             
            (formData ->> 'status')::character varying,             
            1,
            v_userid,
            now(),
            v_userid,
            now()
        );
    ELSE
       
        UPDATE form1080b
        SET 
            objectid = (formData ->> 'objectid')::character varying,
            objecttype = (formData ->> 'objecttype')::character varying,            
            casenumber = (formData ->> 'casenumber')::character varying,
            personid = (formData ->> 'personid')::uuid,
            provideasummaryoftheinvestigationandidentifyanybarriestheldss = (formData ->> 'provideasummaryoftheinvestigationandidentifyanybarriestheldss')::character varying,           
            whatisthemedicalexaminerspreliminaryfinding = (formData ->> 'whatisthemedicalexaminerspreliminaryfinding')::character varying,
            signatureofpersoncompletingthisreport = (formData ->> 'signatureofpersoncompletingthisreport')::character varying,       
            datecompleted = (formData ->> 'datecompleted')::timestamp,       
             submitforapproval = (formData ->> 'submitforapproval')::character varying,             
            supervisorcomments = (formData ->> 'supervisorcomments')::character varying,             
            status = (formData ->> 'status')::character varying,       
            updatedby = v_userid,
            updatedon = now()
            WHERE form1080bid = v_formId;
 
    END IF;

    RETURN QUERY
  
    SELECT 
        CASE 
	        WHEN ( formdata  ->> 'copyofform1080b') IS NOT NULL THEN 'Form 1080B Copied Successfully' 
            WHEN ( formdata  ->> 'form1080bid') IS NULL THEN 'Form 1080B Saved Successfully'             
            ELSE 'Form 1080B Updated Successfully' 
        END,       
 		v_formId;
END;
$function$
;
