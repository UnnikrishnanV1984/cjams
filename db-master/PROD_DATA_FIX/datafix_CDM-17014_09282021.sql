-- CDM-17014 - Negative Child Account
/*
-- Issue Description: 
	Keith Jerome Smith (3964668) The child account balance is -$500.00. 
	The negative balance makes the management of the account difficult. 
	Workers will not be able to spend funds to keep the balance below $2,000.00.
   
-- Client ID: 3964668 (KEITH JEROME	SMITH) - 71e227d5-b09e-4df1-9f4a-5c85ed069ed9
-- Conserved Account ID: 1016885
   
-- Category/ Module: Child Accounts (Finance Management) 
-- Root cause: Data error (Auth ID: 1785482 - $300.00)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Auth ID: 1785482 - $300.00 - Paid with Payment ID: 3073441
/* 
Insert Transaction Ancillary Goods/Services Disbursements - Ancillary Payments
1141822	1785482	C	300.00	Ancillary Goods/Services Obligation	Obligation Liquidation
Update Payment Detil ID: 1140118	1785482	D	300.00	Ancillary Goods/Services Obligation	Obligated
DELETE -- 1140117	1785482	D	300.00	Ancillary Goods/Services Obligation	Obligated
*/

INSERT INTO cjams.tb_account_transaction
	(	transaction_id, client_account_id, transaction_type_cd, transaction_source_cd, benefit_start_dt, 
		benefit_end_dt, transaction_amount_no, transaction_dt, credit_debit_sw, notes_tx, 
		create_ts, frequency_cd, create_user_id, update_ts, update_user_id, 
		delete_sw, adjustment_approval_status_cd, manual_db_approval_status_cd, reference_transaction_id, 
		post_sw, payment_detail_id, authorization_id, late_entry_sw, comm_acct_trans_id, 
		etl_userid, etl_load_date
	)
VALUES
	(	nextval('sq_account_transaction'::regclass), 1016885, '5531', '5476', '2021-07-14', 
		'2021-07-17', 300.00, '2021-08-13', 'D', '', 
		now(), NULL, 'CDM-17014', now(), 'CDM-17014', 
		'N', NULL, NULL, NULL, NULL, 
		4230830, 1785482, NULL, NULL, 
		NULL, NULL
	);
	
update tb_account_transaction
set payment_detail_id = 4230830, 
	update_ts = now(),
	update_user_id = 'CDM-17014'
where transaction_id = 1141822
	and delete_sw = 'N';
	
update tb_account_transaction
set delete_sw = 'Y', 
	update_ts = now(),
	update_user_id = 'CDM-17014'
where transaction_id = 1140117
	and delete_sw = 'N';
	
-- Update Account Balance	
update tb_client_account ta
set obligated_for_anc = 
	 ( select sum(spa.cost_no) 
			from tb_service_purchase_authorization spa
		where spa.delete_sw  = 'N'
			and spa.authorization_id 
				in (	select tr.authorization_id 
							from tb_account_transaction tr
						where tr.client_account_id = 1016885
							and tr.delete_sw = 'N'
							and tr.authorization_id is not null
							and (select count(*)
									from tb_payment_header ph
								 where ph.authorization_id = tr.authorization_id
									and ph.delete_sw = 'N'
								) = 0 
							and (select count(*)
									from routing ro
								 where ro.objectid = tr.authorization_id
									and ro.activeflag = 1
									and ro.routingstatustypeid = '62'
								) = 0
					)
	),	
	update_ts = now(),
	update_user_id = 'CDM-17014'
where ta.client_account_id = 1016885
and ta.delete_sw = 'N' ;

update tb_client_account ta
set total_balance_no = 
	(
		coalesce(( select sum(coalesce(tr.transaction_amount_no,0))
			from tb_account_transaction tr
			where tr.client_account_id = ta.client_account_id
			   and ( 	tr.transaction_type_cd <> '588' 
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd = '5472' )
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd <> '5472' 
							and tr.adjustment_approval_status_cd = '3047' ) 
					)
			   and tr.transaction_type_cd <> '5530'    
			   and tr.credit_debit_sw = 'C'
			   and tr.delete_sw = 'N' 
		),0)	   
		- 
		coalesce(( select sum(coalesce(tr.transaction_amount_no,0))
			from tb_account_transaction  tr
			where tr.client_account_id =  ta.client_account_id
				and ( 	tr.transaction_type_cd <> '588' 
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd = '5472' )
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd <> '5472' 
							and tr.adjustment_approval_status_cd = '3047' ) 
					)
				and tr.transaction_type_cd <> '5530'    
				and tr.credit_debit_sw = 'D'
				and tr.delete_sw = 'N' 
		),0)
	),
	obligated_for_coc = 
	coalesce(( select
		( select sum(coalesce(tr.transaction_amount_no,0))
			from tb_account_transaction tr
		   where tr.client_account_id = ca.client_account_id
			and tr.delete_sw = 'N'
			and tr.credit_debit_sw = 'C'
			and tr.transaction_source_cd in ('587','586','585')	
			and benefit_start_dt > f_daymonth((current_date - interval '2 month')::date  ,'L' , 'C') 
		 )
		+
		coalesce((
		  select sum(coalesce(tr1.transaction_amount_no,0))	
			from tb_account_transaction tr1
		   where tr1.transaction_type_cd = '588'
			and tr1.credit_debit_sw = 'C'
			and tr1.transaction_source_cd = '5473'	
			and tr1.adjustment_approval_status_cd = '3047'
			and tr1.reference_transaction_id in
					(
					  select tr.transaction_id
						from tb_account_transaction tr
					  where tr.client_account_id = ca.client_account_id
						and tr.delete_sw = 'N'
						and tr.credit_debit_sw = 'C'
						and tr.transaction_source_cd in ('587','586','585')	
						and benefit_start_dt > f_daymonth((current_date - interval '2 month')::date  ,'L' , 'C') 
					)

		),0)
		-
		coalesce((
		  select sum(coalesce(tr1.transaction_amount_no,0))	
			from tb_account_transaction tr1
		   where tr1.transaction_type_cd = '588'
			and tr1.credit_debit_sw = 'D'
			and tr1.transaction_source_cd = '5473'	
			and tr1.adjustment_approval_status_cd = '3047'
			and tr1.reference_transaction_id in
					(
					  select tr.transaction_id
						from tb_account_transaction tr
					  where tr.client_account_id = ca.client_account_id
						and tr.delete_sw = 'N'
						and tr.credit_debit_sw = 'C'
						and tr.transaction_source_cd in ('587','586','585')	
						and benefit_start_dt > f_daymonth((current_date - interval '2 month')::date  ,'L' , 'C') 
					)

		),0)
		from tb_client_account ca
	where ca.client_account_id = ta.client_account_id
		and ca.delete_sw = 'N'
	),0),
	update_ts = now(),
	update_user_id = 'CDM-17014'
where ta.client_account_id = 1016885
	and ta.delete_sw = 'N' ;
			
update tb_client_account ta
set available_balance_no = total_balance_no - ( coalesce(obligated_for_anc,0)  + coalesce(obligated_for_coc,0) ),
	update_ts = now(),
	update_user_id = 'CDM-17014'
where ta.client_account_id = 1016885
	and ta.delete_sw = 'N' ;
   
-- No Commingled Account Associated 