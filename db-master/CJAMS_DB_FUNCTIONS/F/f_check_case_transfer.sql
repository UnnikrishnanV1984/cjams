CREATE OR REPLACE FUNCTION cjams.f_check_case_transfer(v_case_number bigint)
	RETURNS int4
LANGUAGE plpgsql
	
AS $function$

	BEGIN

	if exists (select case_id from transferred_cases where case_number = v_case_number) then
		return 1;
	else 
		return 0;
	end if;
	
	END;

$function$
;
