-- CDM-16430 - Delmy Manuel-Crespin
/*
-- Issue Description: 
   User Request to delete the duplicates Interest Transactions
   
-- Client ID: 4114604 (DELMY MANUEL CRESPIN)- 51d111a8-1593-4dfb-83e0-93ca5891f26b
-- Conserved Account ID: 13555 (# S000006706)
-- Commingled Account ID: 286 (# 00000000446026612395)

-- 1142402	0.21	2020-02-01	2020-02-29	Interest Earned for February 2020
-- 125774	0.20	2020-03-11	2020-03-12	Interest earned for the month of February 2020
   
-- Category/ Module: Child Accounts (Finance Management) 
-- Root cause: User Error 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Remove the duplicate Interest Transactions
select transaction_id, transaction_amount_no, benefit_start_dt, benefit_end_dt, notes_tx,
	update_ts, update_user_id, delete_sw 
from cjams.tb_account_transaction 
where transaction_id in (1142402, 125774)
	and delete_sw  = 'N' ;


update cjams.tb_account_transaction 	
	set delete_sw = 'Y',
		update_user_id = 'CDM-16430',
		update_ts = now()
where transaction_id in (1142402, 125774)
	and delete_sw  = 'N' ;

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
			and benefit_start_dt > f_daymonth((current_date - interval '1 month')::date  ,'L' , 'C') 
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
						and benefit_start_dt > f_daymonth((current_date - interval '1 month')::date  ,'L' , 'C') 
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
						and benefit_start_dt > f_daymonth((current_date - interval '1 month')::date  ,'L' , 'C') 
					)

		),0)
		from tb_client_account ca
	where ca.client_account_id = ta.client_account_id
		and ca.delete_sw = 'N'
	),0),
	update_ts = now(),
	update_user_id = 'CDM-16430'
where ta.client_account_id = 13555
	and ta.delete_sw = 'N' ;
			
update tb_client_account ta
set available_balance_no = total_balance_no - ( coalesce(obligated_for_anc,0)  + coalesce(obligated_for_coc,0) ),
	update_ts = now(),
	update_user_id = 'CDM-16430'
where ta.client_account_id = 13555
and ta.delete_sw = 'N' ;
   

-- Update Commingled Account Balance
select comm_account_id, bank_nm, total_balance_no, update_ts, update_user_id 
	from cjams.tb_commingled_account  
where comm_account_id = 286
	and delete_sw = 'N' ;
						
update cjams.tb_commingled_account
	set total_balance_no = ( select sum(coalesce(total_balance_no,0))
								from cjams.tb_client_account
							 where comm_account_id = 286
								and delete_sw = 'N' ),
		update_ts = now(),
		update_user_id = 'CDM-16430'
where comm_account_id = 286
	and delete_sw = 'N' ;

