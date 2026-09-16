CREATE OR REPLACE FUNCTION cjams.update_permanencyplan_history(v_permanencyplanid uuid, v_input json, user_id uuid, v_status character varying)
 RETURNS TABLE(message character varying, code integer)
 LANGUAGE plpgsql
AS $function$ 
------------------------------------------------------------------------

------------------------------------------------------------------------ 

BEGIN
		
		-- Insert a History
		INSERT INTO permanencyplan_history 
        SELECT gen_random_uuid ()
                , v_input::json 
                , 'HISTORY'::character varying
                , *
            FROM permanencyplan 
		      WHERE permanencyplanid = v_permanencyplanid;
		
	
	RETURN QUERY
		SELECT 'success'::character varying, 200;

END;	

$function$
;
