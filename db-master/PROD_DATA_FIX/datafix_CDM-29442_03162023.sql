-- CDM-29442 - Error correction issue - CJAMS ID 2154801
/*
-- Issue Description: 
	Error Correction was done on SSI transaction, still an amount of $914.00 showing as Available for COC

-- Client ID: 2154801 (DIAMOND HILL) - dd7bec02-8043-446c-8d40-e4e8b2f28d69
-- Conserved Account ID: 12184 - S000005627 - $5297.00
-- Commingled Account ID: 201
-- Transaction: 1193307	914.00	Receipts	SSI					2023-03-01	2023-03-31
-- Transaction: 1193749	914.00	Adjustments	Error Correction	2023-03-01	2023-03-31

-- Category/ Module: Child Accounts (Finance Management) 
-- Root cause: The apporval record is missing in routing table, user is having option to submit the apporval request without selecting the supervisor. 
-- Fix Provided: Code fix has been promoted to make supervsiro selection mandetory.
--				 Datafix has been promoted update Error Correction as approved and to re-calcualte the Child Account balance.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To update Error Correction as approved
INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, tosecurityusersid, 
		teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, isreviewrequest, 
		remarks, 
		old_id, routeddescription, 
		servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, 
		actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	cjams.gen_random_uuid(), 'CACCTRANS', '773e4a95-e85e-42c6-9657-fbb17b624ce6', 'e7ea364c-c81d-473b-82db-2abbdf28b9e0', 
		'abf11605-707e-457d-9f07-6a31abca13d7', 'FNSFW', 'FNSFS', '1193749', 82, 1, 
		'CDM-29442', now(), 'CDM-29442', now(), true, 
		'Approved Error Correction for the Client Account ID(12184)',
		NULL, 'Approval request for Error Correction for the Client Account ID(12184)', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL
	);
 
update tb_account_transaction
set adjustment_approval_status_cd = '3047',
	update_user_id = 'CDM-29442',
	update_ts = now()
where transaction_id = 1193749
	and delete_sw = 'N';


-- Script to re-calculate and update the Child Account Balances accordingly   

-- Update Obligated for Ancillary
update tb_client_account ta
set obligated_for_anc = 
	 ( select coalesce(sum(spa.cost_no),0) 
			from tb_service_purchase_authorization spa
		where spa.delete_sw  = 'N'
			and spa.authorization_id 
				in (	select tr.authorization_id 
							from tb_account_transaction tr
						where tr.client_account_id = 12184
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
	update_user_id = 'CDM-29442'
where ta.client_account_id = 12184
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
	update_user_id = 'CDM-29442'
where ta.client_account_id = 12184
	and ta.delete_sw = 'N' ;
			
update tb_client_account ta
set available_balance_no = total_balance_no - ( coalesce(obligated_for_anc,0)  + coalesce(obligated_for_coc,0) ),
	update_ts = now(),
	update_user_id = 'CDM-29442'
where ta.client_account_id = 12184
	and ta.delete_sw = 'N' ;

select comm_account_id, client_id, client_account_id, 
	total_balance_no, obligated_for_anc,obligated_for_coc, available_balance_no, 
	comm_account_id, county_cd	
from tb_client_account 
where client_account_id = 12184
	and delete_sw = 'N' ;

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
		update_user_id = 'CDM-29442'
where comm_account_id = 201
	and delete_sw = 'N' ;

