DROP FUNCTION IF EXISTS cjams.sp_check_release_payment(v_provider_id integer);
CREATE OR REPLACE FUNCTION cjams.sp_check_release_payment(v_provider_id integer)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$

declare
status_count bigint;
v_SP_RELEASE_PAYMENTS integer;
BEGIN 
	
        select count(1) into status_count from tb_payment_status tps 
        join tb_payment_header tph on tph.payment_id = tps.payment_id and tph.delete_sw = 'N'
        join tb_provider tp on tp.provider_id = tph.provider_id and tp.delete_sw = 'N'
        where tps.payment_status_cd='1635'
         and tp.withhold_payment_sw='N' and tp.provider_id = v_provider_id  ;
        
        if(status_count>0)
        then 
        select SP_RELEASE_PAYMENTS into v_SP_RELEASE_PAYMENTS from SP_RELEASE_PAYMENTS(v_provider_id);
       return v_SP_RELEASE_PAYMENTS;
       else
       return 0;
       end if;
        
END;

$function$
;
