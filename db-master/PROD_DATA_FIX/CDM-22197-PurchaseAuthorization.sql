/*
   Issue Description: CDM-22197
   Category/ Module  : record to remove from case pending Appoval inbox 
   Root cause: user wants to  removal of record
   Pull request# for code fix: 5408
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix
*/

-- Routing Fix
delete from routing r 
where routingid
 in (	'0fb1a268-e7c1-4816-b256-535a51d1823a', '064e26d9-8b1b-4775-82e6-5ec263ffef94', 
		'25672a48-3250-4c75-bc94-9f55d3480d5f', '8574bb0e-1e88-4dcb-857e-6f684f9cf9ff'
	);

update routing 
set updatedby = 'CDM-22197', 
	updatedon = now(), 
	activeflag = 1 
where routingid = 'b446d7fc-c4b8-4ed7-af5c-44b3d060b67c';


-- Child Account Fix
-- Conserved Account ID: 1016832 (C270621)
-- Comm A/C ID: 1000404
-- Duplicate Tranascation ID: 1153077 - Debit $841.00 (Ancillary Goods/Services Obligation - Obligated)

select transaction_id, transaction_amount_no, benefit_start_dt, benefit_end_dt, notes_tx,
	update_ts, update_user_id, delete_sw 
from cjams.tb_account_transaction 
where transaction_id = 1153077
	and delete_sw  = 'N' ;

update cjams.tb_account_transaction 	
	set delete_sw = 'Y',
		update_user_id = 'CDM-22197',
		update_ts = now()
where transaction_id = 1153077
	and delete_sw  = 'N' ;

-- Update obligated_for_anc Balance	
update tb_client_account
set obligated_for_anc = obligated_for_anc - 841.00 ,
	update_ts = now(),
	update_user_id = 'CDM-22197'
where client_account_id = 1016832
	and delete_sw = 'N' ;

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
	update_user_id = 'CDM-22197'
where ta.client_account_id = 1016832
	and ta.delete_sw = 'N' ;
			
update tb_client_account ta
set available_balance_no = total_balance_no - ( coalesce(obligated_for_anc,0)  + coalesce(obligated_for_coc,0) ),
	update_ts = now(),
	update_user_id = 'CDM-22197'
where ta.client_account_id = 1016832
and ta.delete_sw = 'N' ;

-- Update Commingled Account Balance
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
		update_user_id = 'CDM-22197'
where comm_account_id = 1000404
	and delete_sw = 'N' ;


/* 
-- To Revert if needed
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('064e26d9-8b1b-4775-82e6-5ec263ffef94'::uuid, 'PCAUTH', '8451ccf6-ceb6-4ce4-b888-b4f2ada4d9fb', 'a26dcd1d-a287-43bb-afc9-da75f966f69b', '263e4d5d-cf6c-4e7d-8c35-394a62e46028'::uuid, 'CWSP', 'CWSP', '1826222', 42, 1, '8451ccf6-ceb6-4ce4-b888-b4f2ada4d9fb', '2022-04-08 13:33:10.097', '8451ccf6-ceb6-4ce4-b888-b4f2ada4d9fb', '2022-04-08 13:33:10.097', true, 'Forwarded to Director Approval', NULL, 'Purchase Authorization Forwarded to Director Approval', '3189064', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('0fb1a268-e7c1-4816-b256-535a51d1823a'::uuid, 'PCAUTH', 'ee3a1a4f-ac1a-42a7-aa56-1c2f9972f814', '8451ccf6-ceb6-4ce4-b888-b4f2ada4d9fb', '60296e7e-5bb8-40b2-9bba-bb8a87a325c9'::uuid, 'CWCW', 'CWSP', '1826222', 39, 1, 'ee3a1a4f-ac1a-42a7-aa56-1c2f9972f814', '2022-04-05 08:31:45.456', 'ee3a1a4f-ac1a-42a7-aa56-1c2f9972f814', '2022-04-05 08:31:45.456', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '3189064', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('25672a48-3250-4c75-bc94-9f55d3480d5f'::uuid, 'PCAUTHR', '8451ccf6-ceb6-4ce4-b888-b4f2ada4d9fb', NULL, '332f00b5-6ed5-436d-9a43-152240009e07'::uuid, 'CWSP', 'CWSP', '1826222', 42, 0, '8451ccf6-ceb6-4ce4-b888-b4f2ada4d9fb', '2022-04-08 13:32:57.229', '8451ccf6-ceb6-4ce4-b888-b4f2ada4d9fb', '2022-04-08 13:33:10.097', true, 'Forwarded to Director Approval', NULL, 'Purchase Authorization Forwarded to Director Approval', '3189064', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('8574bb0e-1e88-4dcb-857e-6f684f9cf9ff'::uuid, 'PCAUTH', '8451ccf6-ceb6-4ce4-b888-b4f2ada4d9fb', 'a26dcd1d-a287-43bb-afc9-da75f966f69b', '263e4d5d-cf6c-4e7d-8c35-394a62e46028'::uuid, 'CWSP', 'CWSP', '1826222', 42, 1, '8451ccf6-ceb6-4ce4-b888-b4f2ada4d9fb', '2022-04-07 16:24:16.937', '8451ccf6-ceb6-4ce4-b888-b4f2ada4d9fb', '2022-04-07 16:24:16.937', true, 'Forwarded to Director Approval', NULL, 'Purchase Authorization Forwarded to Director Approval', '3189064', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/
