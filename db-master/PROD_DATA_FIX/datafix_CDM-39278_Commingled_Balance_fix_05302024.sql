-- CDM-39278 Commingled Bank Account Balance
/*
-- Issue Description: 
	To fix Child Account Balance
   
-- Commingled Account ID: 1000404 (Calvert)

-- Category/ Module: Child Accounts (Finance Management) 
-- Root cause: Wrong fix was promoted as a part of CDM-38919 Child Account Balances fix
-- Fix Provided: Datafix has been promoted to re-calcualte update the Commingled Account Balance.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To fix Commingled Account Balance (CDM-39278)
update cjams.tb_commingled_account
	set total_balance_no = ( select sum(coalesce(total_balance_no,0))
								from cjams.tb_client_account
							 where comm_account_id = 1000404
								and delete_sw = 'N' ),
		update_ts = now(),
		update_user_id = 'CDM-39278'
where comm_account_id = 1000404
	and delete_sw = 'N' ;
