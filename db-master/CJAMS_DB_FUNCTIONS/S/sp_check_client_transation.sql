CREATE OR REPLACE FUNCTION cjams.sp_check_client_transation(v_client_account_id integer, v_benefit_start_dt date, v_transation_src character varying)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$


declare
	return_val boolean;
	v_exists int;
	
BEGIN 

	--if(v_transation_src in ('585','586','587', '583', '5479', '5482', '584', '5471', '5487'))
	if(v_transation_src in ('586','587', '583', '5487'))
    then
	select count(1) into v_exists from tb_account_transaction tat
    where tat.client_account_id = v_client_account_id  and
	EXTRACT(month FROM date_trunc('month', tat.benefit_start_dt)) = 
    EXTRACT(month FROM date_trunc('month', v_benefit_start_dt)) and 
    EXTRACT(year FROM date_trunc('year', tat.benefit_start_dt)) = 
    EXTRACT(year FROM date_trunc('year', v_benefit_start_dt)) and 
    tat.delete_sw = 'N' and tat.transaction_source_cd = v_transation_src;
    else 
    v_exists := 0;
    end if;
   if(v_exists > 0)
   then
   return_val := false; 
   else
   return_val := true;
   end if;
  return return_val;
END;

$function$
;
