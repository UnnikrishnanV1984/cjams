--drop function if exits sp_ncands_insert();
CREATE OR REPLACE FUNCTION cjams.sp_ncands_insert(OUT vl_output_sqlcode character varying, OUT vs_message character varying)
 RETURNS record
 LANGUAGE plpgsql
AS $function$

declare

		vl_error_flag				integer;
  		v1_from_date				timestamp without time zone;
		v1_to_date					timestamp without time zone;
       
begin  

	vl_error_flag := 0;--
	
	select to_date((EXTRACT(YEAR FROM now() )::integer-1)::character varying||'-10-01','YYYY-MM-DD') INTO v1_from_date;
	select to_date(EXTRACT(YEAR FROM now() )::character varying||'-09-30','YYYY-MM-DD') INTO v1_to_date;
	
	RAISE NOTICE 'CALLING sp_ncands_insert_with_dates';
	select * FROM cjams.sp_ncands_insert_with_dates(v1_from_date::character varying, v1_to_date::character varying) INTO vl_output_sqlcode,vs_message;
	
end;

$function$
;
