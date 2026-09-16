-- CDM-21127 - Conserved account
/*
-- Issue Description: 
	Child has an Obligated balance of $300.00 showing on the account. 
	Final disbursement was completed on 5/6/2014. 
	How do we go about to close this child's account in CJAMS?
   
-- Client ID: 1537200 (JOSHUA KERBY) - f67b6591-1358-4bb4-8f8b-ab6bbed510bc
-- Conserved Child Account ID: 510 (# 9835197287)
   
-- Category/ Module: Child Accounts (Finance Management) 
-- Root cause: Data migration error (Denied Auth ID: 287303 - $300.00)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/
-- Insert missing routing record - Denied Auth ID: 287303 - $300.00
INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, 
		tosecurityusersid, teamid, 
		fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, 
		objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, 
		etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	gen_random_uuid()::uuid, 'PCAUTH', '5eac9ebb-90fa-4f0c-a9f6-730f6fa5da4c', 
		'00000000-0000-0000-0000-000000000000', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a'::uuid, 
		'FNSFS', 'FNSFS', '287303', 62, 1, 
		'CDM-21127', now(), 'CDM-21127', now(), 
		true, 'Denied', NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL
	);
	
select eventcode, activeflag, objectid, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro 
where ro.routingid = '8d2f61ff-72e9-45ff-a50c-89f220d0dfb3'
	and ro.activeflag = 1 ;	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CDM-21127',
	ro.updatedon = now()	
where ro.routingid = '8d2f61ff-72e9-45ff-a50c-89f220d0dfb3'
	and ro.activeflag = 1 ;	

-- Add Obligation Liquidation
INSERT INTO cjams.tb_account_transaction
	(	transaction_id, client_account_id, transaction_type_cd, transaction_source_cd, benefit_start_dt, 
		benefit_end_dt, transaction_amount_no, transaction_dt, credit_debit_sw, 
		notes_tx, 
		create_ts, frequency_cd, create_user_id, update_ts, update_user_id, 
		delete_sw, adjustment_approval_status_cd, manual_db_approval_status_cd, reference_transaction_id, 
		post_sw, payment_detail_id, authorization_id, late_entry_sw, comm_acct_trans_id, 
		etl_userid, etl_load_date
	)
VALUES
	(	nextval('sq_account_transaction'::regclass), 510, '5530', '5475', '2012-10-31', 
		'2012-10-31', 300.00, '2012-10-31', 'C', 
		'System generated entry for Ancillary Goods/Services Obligation  - Obligation Liquidation.', 
		now(), NULL, 'CDM-21127', now(), 'CDM-21127', 
		'N', NULL, NULL, NULL, NULL, 
		0, 287303, NULL, NULL, 
		NULL, NULL
	);

/*
-- Remove the Obligated Transactions
select transaction_id, transaction_amount_no, benefit_start_dt, benefit_end_dt, notes_tx,
	update_ts, update_user_id, delete_sw 
from cjams.tb_account_transaction 
where transaction_id = 36347
	and delete_sw  = 'N' ;


update cjams.tb_account_transaction 	
	set delete_sw = 'Y',
		update_user_id = 'CDM-21127',
		update_ts = now()
where transaction_id = 36347
	and delete_sw  = 'N' ;
*/
	
-- Update Account Balance	
update tb_client_account ta
set obligated_for_anc = 
	 ( select sum(spa.cost_no) 
			from tb_service_purchase_authorization spa
		where spa.delete_sw  = 'N'
			and spa.authorization_id 
				in (	select tr.authorization_id 
							from tb_account_transaction tr
						where tr.client_account_id = 510
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
	update_user_id = 'CDM-21127'
where ta.client_account_id = 510
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
	update_user_id = 'CDM-21127'
where ta.client_account_id = 510
	and ta.delete_sw = 'N' ;
			
update tb_client_account ta
set available_balance_no = total_balance_no - ( coalesce(obligated_for_anc,0)  + coalesce(obligated_for_coc,0) ),
	update_ts = now(),
	update_user_id = 'CDM-21127'
where ta.client_account_id = 510
	and ta.delete_sw = 'N' ;

-- No Commingled Account Associated 
