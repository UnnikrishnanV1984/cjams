CREATE OR REPLACE FUNCTION cjams.addupdateoverrideup(v_data json)
 RETURNS TABLE(message character varying, success boolean)
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- SQL Stored Procedure
-- 04/14/2023 - Prashanth Sampathirao - CW-Placement/Living Arrangement Placeholder Options  (CIDM-6996)

------------------------------------------------------------------------  
DECLARE
	v_overduepopupid uuid;
	v_responsemessage character varying; 
	v_approvalmsg character varying;
	v_approvalsts boolean;
   	
BEGIN 
	v_responsemessage = 'CPS response timer actions saved successfully';

	IF ( LENGTH(v_data->>'overduepopupid') > 1 ) THEN 
		-- Update
		v_overduepopupid := (v_data->>'overduepopupid')::uuid ;

		UPDATE cjams.overduepopup
		SET updatedby = (v_data->>'securityuserid')::uuid,
			updatedon = now(),
            objectid = (v_data->>'objectid')::uuid,
            objecttype = (v_data->>'objecttype')::character varying,
			revisioncount = (v_data->>'revisioncount')::int4,
			caseworkercomments = coalesce((v_data->>'caseworkercomments')::character varying, caseworkercomments)
		WHERE overduepopupid = v_overduepopupid;

	ELSE
		-- Insert
		INSERT INTO cjams.overduepopup
			(	intakeserviceid,
				updatedby,	
				updatedon,	
				insertedby,	
				insertedon,	
				activeflag,
				caseworkercomments,
                objectid,
                objecttype,
				revisioncount
			)
		VALUES
			(	(v_data->>'intakeserviceid')::uuid,
				(v_data->>'securityuserid')::uuid,
				now(), 
				(v_data->>'securityuserid')::uuid,
				now(), 
				1,
				(v_data->>'caseworkercomments')::character varying,
                (v_data->>'objectid')::uuid,
                (v_data->>'objecttype')::character varying,
				(v_data->>'revisioncount')::int4
			) RETURNING overduepopupid INTO  v_overduepopupid; 
	
	

	END IF;
	
	RETURN QUERY SELECT v_responsemessage, true;

	-- Handling exceptions
	EXCEPTION WHEN OTHERS then
	BEGIN
		RAISE NOTICE 'Internal error: %', sqlerrm;
		RETURN QUERY SELECT 'Unable to process add or update override up. Please try again later.'::character varying, false;  
	END; 

END;
$function$
;
