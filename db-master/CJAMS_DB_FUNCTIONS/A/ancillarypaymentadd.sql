CREATE OR REPLACE FUNCTION cjams.ancillarypaymentadd(searchobj json)
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
v_final_fiscal_category_cd := searchobj ->> 'final_fiscal_category_cd';
v_client_account_id := searchobj ->> 'client_account_id';
	
SELECT al_next_value from  sp_nextid ( 'sq_payment_header') into vl_pay_header_id;
SELECT al_next_value from  sp_nextid ( 'sq_payment_detail') into vl_pay_detail_id;
SELECT al_next_value from  sp_nextid ( 'sq_payment_status') into vl_pay_status_id;

INSERT INTO cjams.tb_payment_header
(payment_id, provider_id, payment_dt, payment_type_cd, check_status_cd, payment_method_cd, gross_amount_no, manual_sw, approval_status_cd, 
 create_ts,  create_user_id, update_ts, update_user_id, delete_sw,authorization_id,client_account_id)
VALUES(vl_pay_header_id, v_provider_id , v_timestamp , '3294', '', v_payment_method_cd, v_costno, 'Y', '3045',v_timestamp,v_securityid,v_timestamp,v_securityid,'N',v_authorization_id ,v_client_account_id)
RETURNING payment_id into v_newpayment_id; 
select v_newpayment_id into resultrecord.paymentid;
raise notice 'v_paymentid%',v_newpayment_id;

	INSERT INTO cjams.tb_payment_detail
(payment_detail_id, payment_id, payment_amount_no, client_id, final_service_id, final_service_start_dt, final_service_end_dt, final_amount_no, create_ts, create_user_id, update_ts, update_user_id,case_id,type_1099_cd,report_1099_sw,reference_payment_detail_id,change_reason_cd,county_cd,notes_tx,final_fiscal_category_cd)
values(vl_pay_detail_id,v_newpayment_id, v_costno,  v_client_id , v_final_service_id, v_final_service_start_dt, v_final_service_end_dt, v_costno,v_timestamp,v_securityid,v_timestamp,v_securityid,v_case_id,v_type_1099_cd,v_report_1099_sw,v_payment_detail_id,v_change_reason_cd,v_county_cd,v_notes_tx,v_final_fiscal_category_cd);

raise notice 'vl_pay_detail_id%',vl_pay_detail_id;
INSERT INTO cjams.tb_payment_status
(payment_status_id, payment_status_cd, payment_status_dt, payment_id,  create_ts, create_user_id, update_ts, update_user_id,active_sw)
VALUES(vl_pay_status_id,'1637', v_timestamp, v_newpayment_id,v_timestamp,v_securityid,v_timestamp,v_securityid,'Y');
raise notice 'vl_pay_status_id%',vl_pay_status_id;
select v_intakeserviceid,v_assignedtoid into resultrecord.intakeserviceid,resultrecord.assignedtoid;

 v_alertnotes = 'Ancillary Adjustment Payment has been assigned for payment id #' || v_payment_id ||'.' ;
 select send_notification into v_sendnotification from send_notification(v_assignedtoid::character varying,v_securityid::character varying,v_assignedtoid::character varying,'System'::character varying,'High'::character varying,v_alertnotes::character varying,v_alertnotes::text,v_intakeserviceid::character varying,false);
raise notice 'v_sendnotification%',v_sendnotification;


--if (v_final_fiscal_category_cd in  ('7502','7503'))
--	then
--	raise notice 'v_client_account_id%',v_client_account_id;
--	raise notice 'v_costno%',v_costno;
--
--		update tb_client_account set obligated_for_anc=coalesce(obligated_for_anc,0) + v_costno	where client_account_id = v_client_account_id;
--	end if;

	update TB_SERVICE_PURCHASE_AUTHORIZATION set sprvsr_approval_status_cd= 3047 , sprvsr_approval_dt=now(),ads_approval_status_cd= 3047 , ads_approval_dt=now() where authorization_id = v_authorization_id;
--	update routing set tosecurityusersid = v_securityid where eventcode = 'PCAUTHR' and objectid = v_authorization_id :: character varying and routingstatustypeid =40;
	
	if (v_final_fiscal_category_cd = '7503' or v_final_fiscal_category_cd = '7502')
	then
	--add amount to transation Source as ‘Obligated’ and Transaction type as ‘Ancillary Goods/Services Obligation’ 
	--SELECT al_next_value from  sp_nextid ( 'sq_tb_client_account') into vl_tb_client_account;
		update tb_client_account set obligated_for_anc=coalesce(obligated_for_anc,0) + v_costno	where client_account_id = v_client_account_id;

	INSERT INTO tb_account_transaction
	(client_account_id ,transaction_type_cd, transaction_source_cd, benefit_start_dt, benefit_end_dt, transaction_amount_no, transaction_dt, credit_debit_sw,
	notes_tx, create_ts,  create_user_id, update_ts, update_user_id, delete_sw,payment_detail_id, authorization_id)
	select v_client_account_id,'5530', '5474', v_final_service_start_dt, v_final_service_end_dt , v_costno, now(), 'D','',now(),v_securityid,now(),v_securityid,'N',null,v_authorization_id ;
	
--	update tb_client_account set 
--	available_balance_no=coalesce (available_balance_no ,0)  - v_costno, 
--	total_balance_no=coalesce (total_balance_no ,0)  - v_costno 
--	where client_account_id = v_client_account_id;
	
	--update tb_service_purchase_authorization set client_account_id=v_client_account_id  where  authorization_id= v_authorization_id;
	raise notice 'v_final_fiscal_category_cd%',v_final_fiscal_category_cd;

	
	end if;
	

return resultrecord;

END;

$function$
;
