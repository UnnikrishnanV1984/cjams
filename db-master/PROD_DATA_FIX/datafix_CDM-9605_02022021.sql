-- CDM-9605 - Conserved Account
/*
-- Issue Description: 
   I accidentally deposit money into conserved account for COC instead of available for ancillary. 
   Client ID: 4264543 (CLIENT_ACCOUNT_ID: 15051)
   
-- Category/ Module: Child Accounts (Finance Management)
-- Root cause: User error (Note: Currently Error Correction is not an option for Conserved Child Account)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to update the Transaction Source as 5471 Other (Ancillary Payments) (Old value was 585 Other (Cost Of Care))
select client_account_id, transaction_type_cd, transaction_source_cd, 
	transaction_amount_no, credit_debit_sw, update_ts, update_user_id 
from tb_account_transaction
where transaction_id = 1130097
	and delete_sw = 'N';

-- Update 
update tb_account_transaction
	set transaction_source_cd = '5471',
		update_ts =  now(),
		update_user_id = 'CDM-9605'
where transaction_id = 1130097
	and delete_sw = 'N';
	
