CREATE OR REPLACE FUNCTION cjams.addupdaterestrictedcase(v_data json)
 RETURNS TABLE(message character varying, success boolean)
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Vigneshwar Kumar
-- Date Created : 06/27/2022 
-- Stored Procedure to Insert/Update the Restricted/Unrestricted Case
------------------------------------------------------------------------  
DECLARE
	v_restricteditemsid uuid;
    v_responsemessage character varying;
   	v_rec json;   
	v_userids character varying[];   

BEGIN 
	
	v_responsemessage := Case (v_data->>'activeflag')::boolean WHEN true THEN 'Case restricted successfully'::character varying ELSE 'Case unrestricted successfully'::character varying END ;
	v_userids := string_to_array(translate((v_data->'userids')::text, '[] "', ''), ',')::varchar[]; 

	-- Update activeflag for removed from users
	UPDATE restricteditems r 
	SET activeflag = 0, updatedby = (v_data->>'securityuserid')::character varying , updatedon = now()
	WHERE objectid = (v_data->>'objectid')::character varying 
	AND objecttypekey = (v_data->>'objecttypekey')::character varying 
	AND NOT (accessuserid = ANY ( v_userids)); 
				
	-- Add New Users 	
	FOR v_rec IN 
		SELECT * FROM json_array_elements((v_data->>'userslist')::json)
	LOOP
			-- raise notice 'Userid%', v_rec ->> 'userid';
	
			IF NOT EXISTS(SELECT 1 FROM restricteditems WHERE objectid = (v_data->>'objectid')::character varying AND objecttypekey = (v_data->>'objecttypekey')::CHARACTER VARYING AND activeflag = 1 AND accessuserid = (v_rec ->> 'userid')::character varying) THEN 
				INSERT INTO cjams.restricteditems(objectid, objecttypekey, accessuserid, description, isadd, isedit, isdelete, insertedby, updatedby, insertedon, updatedon, activeflag, roletypekey)
				VALUES((v_data->>'objectid')::character varying, (v_data->>'objecttypekey')::character varying, (v_rec ->> 'userid')::character varying , NULL, false, false, false, (v_data->>'securityuserid')::character varying, (v_data->>'securityuserid')::character varying, now(), now(), 1, (v_rec ->> 'roletypekey')::character varying);
			END IF;
	END LOOP;
	
	RETURN QUERY SELECT v_responsemessage, true;

	-- Handling exceptions
	EXCEPTION WHEN OTHERS then
	BEGIN
		RAISE NOTICE 'Internal error: %', sqlerrm;
		RETURN QUERY SELECT 'Unable to process add or update restricted case. Please try again later.'::character varying, false;  
	END; 

END;
$function$;