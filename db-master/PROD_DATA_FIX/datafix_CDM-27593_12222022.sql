-- CDM-27593 - Final Disbursement
/*
-- Issue Description: 
	Error Correction in a pending status (Migrated Data from MD CHESSIE) preventing final disbursement
   
-- Client ID: 1050380 (CODY	A IRWIN) - ddd9c1f8-7596-4ce5-80c3-ed5f5124351b
-- Conserved Account ID: 9860 - $3957.45
-- Transaction ID: 119691 - Adjustments/Error Correction - 10/01/2019 To 10/31/2019 - Debit $114.87
   
-- Category/ Module: Child Accounts (Finance Management) 
-- Root cause: Error Correction in a pending status (Migrated Data from MD CHESSIE) preventing final disbursement
-- Fix Provided: Datafix has been promoted to update status a ??? for  Error Correction
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Transaction ID: 119691 - Adjustments/Error Correction - 10/01/2019 To 10/31/2019 - Debit $114.87
select adjustment_approval_status_cd, transaction_id, transaction_amount_no, benefit_start_dt, benefit_end_dt, notes_tx,
	update_ts, update_user_id, delete_sw 
from cjams.tb_account_transaction 
where transaction_id = 119691
	and delete_sw  = 'N' ;

update cjams.tb_account_transaction 	
	set adjustment_approval_status_cd = '3281', -- Denied (Old Value 3045)
		update_user_id = 'CDM-27593',
		update_ts = now()
where transaction_id = 119691
	and delete_sw  = 'N' ;
	
-- Script to re-calculate and update the Child Account Balances accordingly   
/* 
-- Not Required for this case

-- Update Obligated for Ancillary
update tb_client_account ta
set obligated_for_anc = 
	 ( select coalesce(sum(spa.cost_no),0) 
			from tb_service_purchase_authorization spa
		where spa.delete_sw  = 'N'
			and spa.authorization_id 
				in (	select tr.authorization_id 
							from tb_account_transaction tr
						where tr.client_account_id = 9860
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
	),	
	update_ts = now(),
	update_user_id = 'CDM-27593'
where ta.client_account_id = 9860
and ta.delete_sw = 'N' ;
*/

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
	update_user_id = 'CDM-27593'
where ta.client_account_id = 9860
	and ta.delete_sw = 'N' ;
			
update tb_client_account ta
set available_balance_no = total_balance_no - ( coalesce(obligated_for_anc,0)  + coalesce(obligated_for_coc,0) ),
	update_ts = now(),
	update_user_id = 'CDM-27593'
where ta.client_account_id = 9860
	and ta.delete_sw = 'N' ;

select comm_account_id, client_id, client_account_id, 
	total_balance_no, obligated_for_anc,obligated_for_coc, available_balance_no, 
	comm_account_id, county_cd	
from tb_client_account 
where client_account_id = 9860
	and delete_sw = 'N' ;

-- Not associated to Commingled Account 
-- Update Commingled Account Balance
/*
select comm_account_id, bank_nm, total_balance_no, update_ts, update_user_id 
	from cjams.tb_commingled_account  
where comm_account_id = ?
	and delete_sw = 'N' ;
						
update cjams.tb_commingled_account
	set total_balance_no = ( select sum(coalesce(total_balance_no,0))
								from cjams.tb_client_account
							 where comm_account_id = 360
								and delete_sw = 'N' ),
		update_ts = now(),
		update_user_id = 'CDM-27593'
where comm_account_id = ?
	and delete_sw = 'N' ;
*/	
