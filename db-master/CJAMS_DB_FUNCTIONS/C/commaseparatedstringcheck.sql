CREATE OR REPLACE FUNCTION cjams.commaseparatedstringcheck(v_source character varying, v_target character varying)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$

----------------------------------------------------------------------------------------------------------------
-- CDM-36719 - Sreekanth Marrikanti - This stored proc can be used to search any word from comma separated string 
--									  in another comma separated string
----------------------------------------------------------------------------------------------------------------

declare 
 currentRow record;

BEGIN
	
	FOR currentRow IN SELECT TRIM(unnest(string_to_array(v_source::text, ','))) as inputtypekey
	LOOP
		
		IF ( currentRow.inputtypekey = any(string_to_array(v_target::text, ','))) THEN
			RETURN true;
		END IF;

	END LOOP;
	
	RETURN false;
	
END;

$function$
;
