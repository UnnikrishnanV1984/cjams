-- CDM-43048 - deny PA and update child account
/*
-- Issue Description: 
	deny or delete Purchase Authorization with Authorization ID 643990 from the youths record so the Obligated Amount on the Child Account would be removed.On 7/3/2018, 
    a Purchase Authorization (Service Log) was prepared in CHESSIE to Provider -Michael Craig to be paid from the Child Account of Xavier Craig, CJAMS ID 3786248 for reimbursement of expenses. 
    Expenses are not allowed to be paid directly from youths Conserved account (Code used was 7502). 
    As a result of the pending transaction, an Obligated Amount of $112.06 shows on the Child Account. 
    This Request has to be denied, but none of the current Finance Approvers can see this transaction to deny it.
   
-- Client ID: 3786248 
-- client acoount id: 12135
-- Commingled Account ID: 201

-- Category/ Module: Child Accounts (Finance Management) 
-- Root cause:   Purchase Authorization (Service Log) was prepared in CHESSIE to Provider -Michael Craig to be paid from
     the Child Account of Xavier Craig, CJAMS ID 3786248 for reimbursement of expenses. 
     Expenses are not allowed to be paid directly from youths Conserved account (Code used was 7502). 
     As a result of the pending transaction, an Obligated Amount of $112.06 shows on the Child Account. 
     This Request has to be denied, but none of the current Finance Approvers can see this transaction to deny it. 
-- Fix Provided: Datafix has been promoted to change the Purchase Authorization with Authorization ID 643990 to deny. Also, re-calcualte the Obligated for Ancillary amount and update the Child Account balance.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- step-1: deny PA 
/*
select activeflag, routingstatustypeid, remarks,  *
    from routing 
where objectid = '643990'
    and eventcode  in ( 'PCAUTHR', 'PCAUTH' )
order by insertedon desc
-- routingid: 53ae7523-4e5b-429a-a638-d6303e172b55
*/

update routing 
set routingstatustypeid = 62,
	updatedby = 'CDM-43048',
	remarks = 'Denied',
	updatedon = now()	
where routingid = '53ae7523-4e5b-429a-a638-d6303e172b55'
and	eventcode = 'PCAUTH'
and activeflag = 1;


/*
select authorization_id, service_log_id, sprvsr_approval_status_cd, sprvsr_approval_dt,
    ads_approval_status_cd, ads_approval_dt,
    funding_approval_status_cd, funding_approval_dt,
    payment_approval_status_cd, payment_approval_dt, client_account_id 
    ,*
from tb_service_purchase_authorization 
where authorization_id = 643990;
*/

-- check the paymentstatus
/*
select picklist_value_cd , value_tx, *
from cjams.tb_picklist_values tpv where btrim(picklist_value_cd ) = '3281'
*/

update tb_service_purchase_authorization
set funding_approval_dt = current_date,
	funding_approval_status_cd = '3281',
	update_user_id = 'CDM-43048',
	update_ts = now()	
where delete_sw = 'N'
	and authorization_id = 643990 ;


-- Step 2: update child account
/*
client acoount id: 12135
*/

/*
select     authorization_id,
    transaction_id,
    adjustment_approval_status_cd,
    credit_debit_sw, 
    transaction_amount_no,
    ( select value_tx 
        from cjams.tb_picklist_values tpv 
      where picklist_type_id = 39
        and btrim(picklist_value_cd) = btrim(transaction_type_cd)
    ) as transaction_type,
    ( select value_tx 
        from cjams.tb_picklist_values tpv 
      where picklist_type_id = 38
        and btrim(picklist_value_cd) = btrim(transaction_source_cd)
    ) as transaction_source,
    benefit_start_dt,     
    benefit_end_dt 
    , *
from tb_account_transaction
where client_account_id = 12135
    and delete_sw = 'N'
     and authorization_id = 643990  
order by authorization_id, transaction_id desc
*/
	
/*
-- comm_account_id: 201
select comm_account_id , *
from tb_client_account tca 
where client_account_id = 12135

*/

--adding credit transection

INSERT INTO cjams.tb_account_transaction
(transaction_id, client_account_id, transaction_type_cd, transaction_source_cd, benefit_start_dt, benefit_end_dt, 
transaction_amount_no, transaction_dt, credit_debit_sw, notes_tx, 
create_ts, frequency_cd, create_user_id, update_ts, update_user_id, delete_sw, 
adjustment_approval_status_cd, manual_db_approval_status_cd, reference_transaction_id, post_sw, payment_detail_id, authorization_id, late_entry_sw, comm_acct_trans_id, etl_userid, etl_load_date)
values
(nextval('sq_account_transaction'::regclass), 12135, '5530', '5475', '2018-07-03', '2018-07-03', 
112.06, current_date, 'C', '', 
now(), NULL, 'CDM-43048', now(), 'CDM-43048', 'N', 
NULL, NULL, NULL, NULL, NULL, 643990  , NULL, NULL, NULL, NULL);



-- To Fix the Child Account Balances (CDM-43048)
-- Update Obligated for Ancillary
update tb_client_account ta
set obligated_for_anc = 
	 ( select coalesce(sum(spa.cost_no),0) 
			from tb_service_purchase_authorization spa
		where spa.delete_sw  = 'N'
			and spa.authorization_id 
				in (	select tr.authorization_id 
							from tb_account_transaction tr
						where tr.client_account_id = 12135
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
	update_user_id = 'CDM-43048'
where ta.client_account_id = 12135
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
	update_user_id = 'CDM-43048'
where ta.client_account_id = 12135
	and ta.delete_sw = 'N' ;
			
update tb_client_account ta
set available_balance_no = total_balance_no - ( coalesce(obligated_for_anc,0)  + coalesce(obligated_for_coc,0) ),
	update_ts = now(),
	update_user_id = 'CDM-43048'
where ta.client_account_id = 12135
	and ta.delete_sw = 'N' ;

-- Commigled Account
-- Update Commingled Account Balance
update cjams.tb_commingled_account
	set total_balance_no = ( select sum(coalesce(total_balance_no,0))
								from cjams.tb_client_account
							 where comm_account_id = 201
								and delete_sw = 'N' ),
		update_ts = now(),
		update_user_id = 'CDM-43048'
where comm_account_id = 201
	and delete_sw = 'N' ;