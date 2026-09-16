-- CDM-33431 - Missing Child Account transaction
/*
-- Issue Description: 
   Purchase Authorization ID: 2275683 was approved by Finance on 7/14/2023 to make a payment 
   out of a Client's Conserved Account. But the corresponding Child Account Transactions are missing.   
   
-- Case ID: 3181169
-- Client ID: 2503989 (TANITH PHIPPS) - 32c3260d-8365-42af-8cde-5ffdf9199c6a
-- Authorization ID: 2275683  - 2023-07-11 - $700.00 - Clothing Purchase (Paid) 
-- Provider ID: 5003711	(Safeway)
-- Conserved Account ID: 1021211 - C495858
-- Commingled Account ID: 1000404
-- 7502 - Child Account Conserved
   
-- Category/ Module: Child Accounts (Finance Management) 
-- Root cause: Data integrity issue (Client Account ID value is not saved in the tb_service_purchase_authorization table – column: client_account_id)
-- Fix provided: Datafix has been promoted add the missing Child Account transactions and update the account balance.  
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To fix Purchase Authorization & Child Accounts Data (CDM-33431)
select authorization_id, fiscal_category_cd, client_account_id, update_ts, update_user_id
	from tb_service_purchase_authorization
where authorization_id = 2275683 
	and delete_sw = 'N' ;
	
update tb_service_purchase_authorization
set client_account_id = 1021211,
	update_ts = now(), 
	update_user_id	=  'CDM-33431'
where authorization_id = 2275683 
	and delete_sw = 'N' ;

-- 2023-07-12 11:37:38
-- D	Ancillary Goods/Services Obligation	Obligated - 5530	5474

INSERT INTO cjams.tb_account_transaction
	(	transaction_id, client_account_id, transaction_type_cd, transaction_source_cd, 
		benefit_start_dt, benefit_end_dt, transaction_amount_no, transaction_dt, credit_debit_sw, 
		notes_tx, create_ts, frequency_cd, create_user_id, update_ts, update_user_id, delete_sw, 
		adjustment_approval_status_cd, manual_db_approval_status_cd, reference_transaction_id, post_sw, 
		payment_detail_id, authorization_id, late_entry_sw, comm_acct_trans_id, etl_userid, etl_load_date
	)
VALUES
	(	nextval('sq_account_transaction'::regclass), 1021211, '5530', '5474', 
		'2023-07-14', '2023-07-14', 700.00, '2023-07-14', 'D', 
		'', now(), NULL, 'CDM-33431',now(), 'CDM-33431', 'N', 
		NULL, NULL, NULL, NULL, 
		NULL, 2275683, NULL, NULL, NULL, NULL
	);

-- 2023-07-14 09:30:35
-- C	Ancillary Goods/Services Obligation	Obligation Liquidation - 5530	5475
-- D	Ancillary Goods/Services Disbursements	Ancillary Payments - 5531	5476

INSERT INTO cjams.tb_account_transaction
	(	transaction_id, client_account_id, transaction_type_cd, transaction_source_cd, 
		benefit_start_dt, benefit_end_dt, transaction_amount_no, transaction_dt, credit_debit_sw, 
		notes_tx, create_ts, frequency_cd, create_user_id, update_ts, update_user_id, delete_sw, 
		adjustment_approval_status_cd, manual_db_approval_status_cd, reference_transaction_id, post_sw, 
		payment_detail_id, authorization_id, late_entry_sw, comm_acct_trans_id, etl_userid, etl_load_date
	)
VALUES
	(	nextval('sq_account_transaction'::regclass), 1021211, '5530', '5475', 
		'2023-07-14', '2023-07-14', 700.00, '2023-07-14', 'C', 
		'', now(), NULL, 'CDM-33431',now(), 'CDM-33431', 'N', 
		NULL, NULL, NULL, NULL, 
		4756518, 2275683, NULL, NULL, NULL, NULL
	);

INSERT INTO cjams.tb_account_transaction
	(	transaction_id, client_account_id, transaction_type_cd, transaction_source_cd, 
		benefit_start_dt, benefit_end_dt, transaction_amount_no, transaction_dt, credit_debit_sw, 
		notes_tx, create_ts, frequency_cd, create_user_id, update_ts, update_user_id, delete_sw, 
		adjustment_approval_status_cd, manual_db_approval_status_cd, reference_transaction_id, post_sw, 
		payment_detail_id, authorization_id, late_entry_sw, comm_acct_trans_id, etl_userid, etl_load_date
	)
VALUES
	(	nextval('sq_account_transaction'::regclass), 1021211, '5531', '5476', 
		'2023-07-14', '2023-07-14', 700.00, '2023-07-14', 'D', 
		'', now(), NULL, 'CDM-33431',now(), 'CDM-33431', 'N', 
		NULL, NULL, NULL, NULL, 
		4756518, 2275683, NULL, NULL, NULL, NULL
);

-- Update obligated_for_anc Balance	
update tb_client_account ta
set obligated_for_anc = 
	 coalesce(( select sum(spa.cost_no) 
			from tb_service_purchase_authorization spa
		where spa.delete_sw  = 'N'
			and spa.authorization_id 
				in (	select tr.authorization_id 
							from tb_account_transaction tr
						where tr.client_account_id = 1021211
							and tr.delete_sw = 'N'
							and tr.authorization_id is not null
							and (select count(*)
									from tb_payment_header ph
								 where ph.authorization_id = tr.authorization_id
									and ph.delete_sw = 'N'
								) = 0 
							and (select count(*)
									from routing ro
								 where ro.objectid::character varying = tr.authorization_id::character varying
									and ro.activeflag = 1
									and ro.routingstatustypeid = '62'
								) = 0
					)
	),0),	
	update_ts = now(),
	update_user_id = 'CDM-33431'
where ta.client_account_id = 1021211
and ta.delete_sw = 'N' ;

-- Update Account Balance
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
	update_user_id = 'CDM-33431'
where ta.client_account_id = 1021211
	and ta.delete_sw = 'N' ;
			
update tb_client_account ta
set available_balance_no = total_balance_no - ( coalesce(obligated_for_anc,0)  + coalesce(obligated_for_coc,0) ),
	update_ts = now(),
	update_user_id = 'CDM-33431'
where ta.client_account_id = 1021211
and ta.delete_sw = 'N' ;
  
-- Update Commingled Account Balance - NOT applicable 
select comm_account_id, bank_nm, total_balance_no, update_ts, update_user_id 
    from cjams.tb_commingled_account  
where comm_account_id = 1000404
    and delete_sw = 'N' ;
                        
update cjams.tb_commingled_account
    set total_balance_no = ( select sum(coalesce(total_balance_no,0))
                                from cjams.tb_client_account
                             where comm_account_id = 1000404
                                and delete_sw = 'N' ),
        update_ts = now(),
        update_user_id = 'CDM-33431'
where comm_account_id = 1000404
    and delete_sw = 'N' ;
