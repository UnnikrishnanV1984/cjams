-- CDM-33630 - FM300R Incorrect
/*
-- Issue Description: 
	User request to close conserved account of Adoption client having Beginning Balance of $694.00 since 2009.

-- Worcester County 
-- Client ID: 2780396 (ANDRE B TAYLOR) - d99b3532-a7ae-447c-9cb6-56c87656e586
-- Conserved Account ID: 1521 - Balance $694.00 - Open date: 10/01/2009

-- b135541a-a02d-4a0a-8693-0055a58cc729	holly.truitt1@maryland.gov	Holly Truitt
-- f5f27dda-efb1-40a6-915d-2b8d0d3531b7	david.beach2@maryland.gov	David Beach
   
-- Category/ Module: Child Accounts (Finance Management) 
-- Root cause: Migrated conserved child account of adopted client with the beginning Balance of $694.00 since 2009. 
-- Fix provided: Datafix has been promoted to make balance $0.00 and close this child account in CJAMS.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To close conserved child account (CDM-33630)

-- Add Adjustments	Error Correction Debit Transaction
INSERT INTO cjams.tb_account_transaction
	(	transaction_id, client_account_id, transaction_type_cd, transaction_source_cd, 
		benefit_start_dt, benefit_end_dt, transaction_amount_no, transaction_dt, credit_debit_sw, 
		notes_tx, create_ts, frequency_cd, create_user_id, update_ts, update_user_id, delete_sw, 
		adjustment_approval_status_cd, manual_db_approval_status_cd, reference_transaction_id, post_sw, 
		payment_detail_id, authorization_id, late_entry_sw, comm_acct_trans_id, etl_userid, etl_load_date
	)
VALUES
	(	nextval('sq_account_transaction'::regclass), 1521, '588', '5473', 
		'2009-10-01', '2009-10-31', 694.00, '2011-02-01', 'D', 
		'ADOPTION', now(), 'N', 'CDM-33630', now(), 'CDM-33630', 'N', 
		'3047', NULL, 3848, NULL, 
		NULL, NULL, NULL, NULL, NULL, NULL
	);

INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, tosecurityusersid, 
		teamid, fromroleid, toroleid, 
		objectid, 
		routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, 
		old_id, routeddescription, servicerequestnumber, objecttypekey, 
		old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	cjams.gen_random_uuid(), 'CACCTRANS', 'b135541a-a02d-4a0a-8693-0055a58cc729', 'f5f27dda-efb1-40a6-915d-2b8d0d3531b7', 
		'e8fa60b9-84fa-4e2f-97d2-25496b4cb0f3', 'FNSFS', 'FNSFS', 
		(select transaction_id::character varying 
			from cjams.tb_account_transaction
		 where client_account_id = 1521
			and create_user_id = 'CDM-33630'
		), 
		82, 1, 
		'CDM-33630', now(), 'CDM-33630', now(), true, 'Approved Error Correction for the Client Account ID(1521)', 
		NULL, 'Approval request for Error Correction for the Client Account ID(1521)', NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	);


-- Close Child Account
select total_balance_no, obligated_for_anc, obligated_for_coc, available_balance_no, 
		open_dt, close_dt, status_cd, update_ts, update_user_id  
	from tb_client_account
where client_account_id = 1521
	and delete_sw = 'N' ;

update tb_client_account
set total_balance_no = 0,
	obligated_for_coc = 0,
	available_balance_no = 0,
	status_cd = '593',
	close_dt = '2011-02-01',
	update_ts = now(),
	update_user_id = 'CDM-33630'
where client_account_id = 1521
	and delete_sw = 'N' ;
  
-- No Commingled Account 
