DROP FUNCTION IF EXISTS cjams.addupdateemaillog(
  v_objecttype character varying,
  v_objectid character varying,
  v_toemail character varying,
  v_body character varying,
  v_response character varying,
  v_subject character varying,
  v_insertedby character varying,
  v_addorupdate character varying,
  v_emaillogsid character varying,
  v_responsestatus character varying
);

-- -----------------------------------------------------------------------------------------------
-- 06/27/2025 Prasanna Sai Kommineni - Email Logging Utility
-- Logs outbound emails into cjams.emaillogs table for auditing and traceability
-- -----------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION cjams.addupdateemaillog(
  v_objecttype character varying,
  v_objectid character varying,
  v_toemail character varying,
  v_body character varying,
  v_response character varying,
  v_subject character varying,
  v_insertedby character varying,
  v_addorupdate character varying,
  v_emaillogsid character varying,
  v_responsestatus character varying

)
RETURNS json
LANGUAGE plpgsql
AS $function$
DECLARE
  v_result json;
  v_output varchar;
BEGIN
if (v_addorupdate	= 'add') then
  INSERT INTO cjams.emaillogs (
    emaillogsid,
    objecttype,
    objectid,
    toemail,
    body,
    response,
    subject,
    insertedon,
    insertedby,
    updatedon,
    updatedby,
    activeflag
  )
  VALUES (
    cjams.gen_random_uuid(),
    v_objecttype,
    v_objectid,
    v_toemail,
    v_body,
    v_response,
    v_subject,
    NOW(),
    v_insertedby,
    NOW(),
    v_insertedby,
    1
  )
  RETURNING emaillogsid::varchar INTO v_output;
  else 


update
	cjams.emaillogs 
set
	response = v_response,
  responsestatus =v_responsestatus,
	updatedon = now(),
	updatedby = v_insertedby
where
	emaillogsid = (v_emaillogsid)::uuid;
v_output:= 'success';
end if;
    SELECT json_agg(a) into v_result FROM 
		(
		select v_output    
			
		) a;

RETURN v_result;
END;
$function$;