-- CDM-41900 - Receipts posted in child account
/*
-- Issue Description: 
   CJAMS is not allowing the user to add cents to the Error Correction transaction amount column.
   
-- Client ID: 2978872 (BRANDON CHRISTOPHER BOWLES) - dfee49b8-7ea1-4ed8-82e1-c4cf5de4f679 
-- Conserved Account ID: 1017278 - C643157
-- Commigled Account ID: N/A
   
-- Category/ Module: Child Accounts (Finance Management) 
-- Root cause: CJAMS is not allowing the user to add cents to the Error Correction transaction amount column.
-- Fix provided: Datafix has been promoted to fix the Error Correction transaction amount. 
	Regression Impacts: Child Account Transaction Screen.
	Is Code fix Required?: Yes
	Code fix ticket#: CIDM-9542
	Reason why no related code fix: N/A
*/

-- TO update Error Correction transaction amount (CDM-41900)

-- 1517297 update transaction_amount_no = 565.80 and late_entry_sw = 'Y'
update cjams.tb_account_transaction 	
	set late_entry_sw = 'Y',
		transaction_amount_no = 565.80,
		update_user_id = 'CDM-41900',
		update_ts = now()
where transaction_id = 1517297
	and delete_sw = 'N' ;

-- 1516282  & 1516281 update late_entry_sw = 'Y'
update cjams.tb_account_transaction 	
	set late_entry_sw = 'Y',
		update_user_id = 'CDM-41900',
		update_ts = now()
where transaction_id in ( 1516282, 1516281 )
	and delete_sw = 'N' ;

-- Update Account Balance	
update tb_client_account ta
set obligated_for_anc = 
	 coalesce(( select sum(spa.cost_no) 
			from tb_service_purchase_authorization spa
		where spa.delete_sw  = 'N'
			and spa.authorization_id 
				in (	select tr.authorization_id 
							from tb_account_transaction tr
						where tr.client_account_id = 1017278
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
	update_user_id = 'CDM-41900'
where ta.client_account_id = 1017278
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
	),0) + 565.80,
	update_ts = now(),
	update_user_id = 'CDM-41900'
where ta.client_account_id = 1017278
	and ta.delete_sw = 'N' ;
			
update tb_client_account ta
set available_balance_no = total_balance_no - ( coalesce(obligated_for_anc,0)  + coalesce(obligated_for_coc,0) ),
	update_ts = now(),
	update_user_id = 'CDM-41900'
where ta.client_account_id = 1017278
	and ta.delete_sw = 'N' ;
   

-- Update Commingled Account Balance - NOT applicable 
/*
select comm_account_id, bank_nm, total_balance_no, update_ts, update_user_id 
    from cjams.tb_commingled_account  
where comm_account_id = ???
    and delete_sw = 'N' ;
                        
update cjams.tb_commingled_account
    set total_balance_no = ( select sum(coalesce(total_balance_no,0))
                                from cjams.tb_client_account
                             where comm_account_id = ???
                                and delete_sw = 'N' ),
        update_ts = now(),
        update_user_id = 'CDM-41900'
where comm_account_id = ???
    and delete_sw = 'N' ;
*/	