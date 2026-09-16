CREATE OR REPLACE FUNCTION cjams.getadoptionpaymenthistory(v_providerid integer, v_clientid bigint, v_caseid bigint, v_page integer, v_limit integer)
 RETURNS TABLE(totalcount bigint, paymentid integer, payment_detail_id bigint, final_service_start_dt date, final_service_end_dt date, providerid integer, paymenttype character varying, paymentdate date, grossamount numeric, offsetamount numeric, final_amount_no numeric, netamount numeric, paymentstatus character varying)
 LANGUAGE plpgsql
AS $function$
--------------------------------------------------------------------------
-- Revision(s) 
-- 05/04/2023 Vineet Tirodkar - To exclude soft deleted payments (CDM-30913) 
--------------------------------------------------------------------------
declare

v_pagenumber int;
v_pageoffset int;

begin
	
		
v_pagenumber := v_page - 1;
v_pageoffset := v_pagenumber * v_limit;

	return QUERY 
	
	
SELECT COUNT(1) OVER() totalcount, x.* from( select 
	distinct tph.payment_id as paymentid,
	tpd.payment_detail_id::bigint as payment_detail_id,
	tpd.final_service_start_dt,
	tpd.final_service_end_dt,
	tbp.provider_id as providerid,
	(select value_tx from tb_picklist_values where PICKLIST_type_id=2 AND delete_sw='N'
		AND active_sw='Y' AND  TRIM(PICKLIST_VALUE_CD)=TRIM(tph.payment_type_cd )) as paymenttype,
	tph.payment_dt as paymentdate,
	tph.gross_amount_no as grossamount,
	tph.offset_amount_no as offsetamount,
	tpd.final_amount_no as final_amount_no, 
	coalesce(tph.gross_amount_no,0) - coalesce(tph.offset_amount_no,0)  as netamount ,
	(select value_tx from tb_picklist_values where PICKLIST_type_id=133 AND delete_sw='N'
		AND active_sw='Y' AND  TRIM(PICKLIST_VALUE_CD)=TRIM(tps.payment_status_cd )) as paymentstatus
	from tb_provider tbp 
		inner join tb_payment_header  tph on tbp.provider_id=tph.provider_id   
			and tph.payment_type_cd in ('5689','3294')
			and tph.delete_sw = 'N' 	
	inner join tb_payment_detail tpd on tpd.payment_id =  tph.payment_id
		 and tpd.delete_sw = 'N' 	
	inner join tb_payment_status tps on tph.payment_id=tps.payment_id
		and tps.delete_sw = 'N' 	
	where 
	-- tbp.provider_id=v_providerid and 
	tpd.client_id=v_clientid and tpd.case_id=v_caseid
	and TRIM(tps.payment_status_cd ) <> '1639'
	ORDER BY tph.payment_dt desc ) as x
	LIMIT v_limit OFFSET v_pageoffset;
  
end;
$function$
;
