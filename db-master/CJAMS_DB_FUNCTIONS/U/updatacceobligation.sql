CREATE OR REPLACE FUNCTION cjams.updatacceobligation(searchobj json)
 RETURNS ancillarypaymentaddtype
 LANGUAGE plpgsql
AS $function$

DECLARE 
    resultrecord ancillarypaymentaddtype;
    v_provider_id int;
	v_payment_id INT;
     v_newpayment_id INT;
     v_payment_type_cd character varying;
    v_payment_dt date;
    v_client_id bigint;
    v_clientfirstname character varying;
    v_clientlastname character varying;
    v_final_service_id integer;
    v_final_service_start_dt date;
    v_final_service_end_dt date;
    v_payment_method_cd character varying;
    v_change_reason_cd character varying;
    v_report_1099_sw character varying;
    v_costno numeric;
    v_county_cd character varying;
   v_securityid character varying;
    v_case_id bigint;
   v_type_1099_cd character varying;
  v_payment_detail_id int;
 vl_pay_header_id int;
  vl_pay_detail_id int; 
  vl_pay_status_id int;
   v_paymentid int;
  v_timestamp timestamp;
 v_intakeserviceid uuid;
v_assignedtoid uuid;
	v_sendnotification character varying;
	v_alertnotes character varying;
   v_notes_tx character varying;
  v_authorization_id int;
v_final_fiscal_category_cd character varying;
v_client_account_id integer;
BEGIN 
v_provider_id := searchobj ->> 'provider_id';
v_payment_id := searchobj ->> 'payment_id';
v_payment_type_cd := searchobj ->> 'payment_type_cd';
v_payment_dt := searchobj ->> 'payment_dt';
v_client_id := searchobj ->> 'client_id';
v_clientfirstname := searchobj ->> 'clientfirstname';
v_clientlastname := searchobj ->> 'clientlastname';
v_final_service_id := searchobj ->> 'final_service_id';
v_final_service_start_dt := searchobj ->> 'final_service_start_dt';
v_final_service_end_dt := searchobj ->> 'final_service_end_dt';
v_payment_method_cd := searchobj ->> 'payment_method_cd';
v_change_reason_cd := searchobj ->> 'change_reason_cd';
v_report_1099_sw := searchobj ->> 'report_1099_sw';
v_costno := searchobj ->> 'gross_amount_no';
v_county_cd := searchobj ->> 'county_cd';
v_securityid := searchobj ->> 'securityusersid';
v_case_id := searchobj ->> 'case_id';
v_type_1099_cd := searchobj ->> 'type_1099_cd';
v_payment_detail_id := searchobj ->> 'payment_detail_id';
v_intakeserviceid := searchobj ->> 'intakeserviceid';
v_assignedtoid := searchobj ->> 'assignedtoid';
v_notes_tx := searchobj ->> 'notes_tx';
v_timestamp := now()::timestamp with time zone;
v_authorization_id := searchobj ->> 'authorization_id';
v_final_fiscal_category_cd := searchobj ->> 'fiscal_category_cd';
v_client_account_id := searchobj ->> 'client_account_id';


	
if (v_final_fiscal_category_cd = '7503' or v_final_fiscal_category_cd = '7502')
	then
	--credit amount --Source as ‘Obligation Liquidation’ and Transaction type as ‘Ancillary Goods/Services Obligation’ 
	
	--SELECT al_next_value from  sp_nextid ( 'sq_tb_client_account') into vl_tb_client_account;

	INSERT INTO tb_account_transaction
	(client_account_id, transaction_type_cd, transaction_source_cd, benefit_start_dt, benefit_end_dt, transaction_amount_no, transaction_dt, credit_debit_sw,
	notes_tx, create_ts,  create_user_id, update_ts, update_user_id, delete_sw,payment_detail_id, authorization_id)
	select v_client_account_id,'5530', '5475', v_final_service_start_dt, v_final_service_end_dt ,v_costno , now(), 'C','',now(),v_securityid,now(),v_securityid,'N'
	,v_payment_detail_id,v_authorization_id ;
	
--	update tb_client_account set 
--	available_balance_no=coalesce (available_balance_no ,0)  + v_costno
--	,total_balance_no=coalesce (total_balance_no ,0)  + 
--	v_costno
--	where client_account_id = v_client_account_id;
	

	
	--debit amount --Source as ‘Ancillary Payments’ and Transaction type as ‘Ancillary Goods/Services Disbursements’  
	--SELECT al_next_value from  sp_nextid ( 'sq_tb_client_account') into vl_tb_client_account;
	--v_alreadydebited :=0;
	--select count(1) into v_alreadydebited from tb_account_transaction where credit_debit_sw = 'D' and authorization_id = v_authorization_id and transaction_amount_no = v_costno;
   --if (v_alreadydebited = 0) then
	INSERT INTO tb_account_transaction
	(client_account_id, transaction_type_cd, transaction_source_cd, benefit_start_dt, benefit_end_dt, transaction_amount_no, transaction_dt, credit_debit_sw,
	notes_tx, create_ts,  create_user_id, update_ts, update_user_id, delete_sw,payment_detail_id, authorization_id)
	select v_client_account_id,'5531', '5476', v_final_service_start_dt, v_final_service_end_dt , v_costno, now(), 'D','',now(),v_securityid,now(),v_securityid,'N',vl_pay_detail_id,v_authorization_id ;
	
	--end if;
	update tb_client_account set  total_balance_no=coalesce (total_balance_no ,0)  - v_costno, available_balance_no=coalesce (available_balance_no ,0)  - v_costno 
	where client_account_id = v_client_account_id;

	if (v_final_fiscal_category_cd in ('7502','7503'))
	then
		update tb_client_account set obligated_for_anc=coalesce (obligated_for_anc ,0) - coalesce(v_costno,0)
	where client_account_id = v_client_account_id;
	if (v_final_fiscal_category_cd in ('7502'))
	then
		update tb_commingled_account set total_balance_no = coalesce(total_balance_no,0) - v_costno where comm_account_id = (select comm_account_id from tb_client_account where client_account_id = v_client_account_id);
	end if;
	end if;
	end if;
return resultrecord;

END;

$function$
;
