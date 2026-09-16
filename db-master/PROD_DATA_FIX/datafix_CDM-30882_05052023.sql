-- CDM-30882 - System not accepting entry - CJAMS ID 4358299
/*
-- Issue Description: 
   System is not allowing the 2nd entry for SSA benefit March 2023 	

   User reuest to revert the SSA transaction by removing the transaction ID # 1196491 & # 1193650 
   and update the entry date to 04/28/2023 on transaction ID # 1193340.
   
-- Client ID: 4358299 (JONATHAN LONG) - bc875f25-8437-4db6-bb52-1be288705e14
-- Conserved Accout ID: 1017571 - $26965.96 - C365640
-- Commingled Account ID: 201
   
-- Category/ Module: Child Accounts (Finance Management) 
-- Root cause: User Error
-- Fix provided: Datafix has been promoted to delete Child Account transaction and update the balance accordingly.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete Transaction IDs: 
-- 1196491	3047	D	1888.00	Adjustments	Error Correction
-- 1193650	3281	C	1888.00	Adjustments	Error Correction

select transaction_id, transaction_amount_no, benefit_start_dt, benefit_end_dt, notes_tx,
	update_ts, update_user_id, delete_sw 
from cjams.tb_account_transaction 
where transaction_id in (1196491, 1193650)
	and delete_sw  = 'N' ;

update cjams.tb_account_transaction 	
	set delete_sw = 'Y',
		update_user_id = 'CDM-30882',
		update_ts = now()
where transaction_id in (1196491, 1193650)
	and delete_sw  = 'N' ;

select routingid, eventcode, routingstatustypeid, remarks, activeflag, updatedby, updatedon  
	from routing
where objectid  in ('1196491', '1193650')
	and eventcode = 'CACCTRANS'
	and activeflag = 1 ;

update routing
set activeflag = 0, 
	updatedby = 'CDM-30882',
	updatedon  = now() 
where objectid  in ('1196491', '1193650')
	and eventcode = 'CACCTRANS'
	and activeflag = 1 ;
	
-- Update Trasnaction Date
-- 1193340		C	1888.00	Receipts	SSA	2023-03-01	2023-03-31	
select transaction_id, transaction_amount_no, benefit_start_dt, benefit_end_dt, 
	late_entry_sw , transaction_dt, notes_tx, update_ts, update_user_id, delete_sw 
from cjams.tb_account_transaction 
where transaction_id = 1193340
	and delete_sw  = 'N' ;

update cjams.tb_account_transaction 	
	set transaction_dt = '2023-04-28',
		late_entry_sw = 'Y',
		update_user_id = 'CDM-30882',
		update_ts = now()
where transaction_id  = 1193340
	and delete_sw  = 'N' ;
	
-- Update obligated_for_anc Balance	
update tb_client_account ta
set obligated_for_anc = 
	 coalesce(( select sum(spa.cost_no) 
			from tb_service_purchase_authorization spa
		where spa.delete_sw  = 'N'
			and spa.authorization_id 
				in (	select tr.authorization_id 
							from tb_account_transaction tr
						where tr.client_account_id = 1017571
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
	update_user_id = 'CDM-30882'
where ta.client_account_id = 1017571
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
	obligated_for_coc = 1888.00 + 
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
	update_user_id = 'CDM-30882'
where ta.client_account_id = 1017571
	and ta.delete_sw = 'N' ;
			
update tb_client_account ta
set available_balance_no = total_balance_no - ( coalesce(obligated_for_anc,0)  + coalesce(obligated_for_coc,0) ),
	update_ts = now(),
	update_user_id = 'CDM-30882'
where ta.client_account_id = 1017571
and ta.delete_sw = 'N' ;
   

-- Update Commingled Account Balance
select comm_account_id, bank_nm, total_balance_no, update_ts, update_user_id 
    from cjams.tb_commingled_account  
where comm_account_id = 201
    and delete_sw = 'N' ;
                        
update cjams.tb_commingled_account
    set total_balance_no = ( select sum(coalesce(total_balance_no,0))
                                from cjams.tb_client_account
                             where comm_account_id = 201
                                and delete_sw = 'N' ),
        update_ts = now(),
        update_user_id = 'CDM-30882'
where comm_account_id = 201
    and delete_sw = 'N' ;