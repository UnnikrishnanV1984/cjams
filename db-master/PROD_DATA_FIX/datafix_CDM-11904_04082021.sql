-- CDM-11904 - Conserved Account
/*
-- Issue Description: 
   Conserved  Child Account was incorrectly  linked with Commingled Account 
   
   Client ID: 4019576 (AMY LYNN	HEMPHILL) - 7b8bcf55-a2b7-4720-a65e-d16ff42e1d9d
   Conserved  Account CLIENT_ACCOUNT_ID:  1016957
   
-- Category/ Module: Child Accounts (Finance Management) 
-- Root cause: User Error 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to disassociate Conserved Child Account from Commingled Account
-- 5500336865 for PNC Bank
select account_type_cd, account_exists_sw, bank_nm, account_no_tx, comm_account_id, update_ts, update_user_id 
   from cjams.tb_client_account  
where client_account_id = 1016957
  and delete_sw  = 'N' ;

update cjams.tb_client_account
set comm_account_id = null,
    account_exists_sw = 'Y',
	bank_nm = 'PNC Bank',
	account_no_tx = '5500336865',
	update_ts = now(),
	update_user_id = 'CDM-11904' 		
where client_account_id = 1016957
  and delete_sw  = 'N' ;


-- Update Commingled Account Balance
select comm_account_id, bank_nm, total_balance_no, update_ts, update_user_id 
	from cjams.tb_commingled_account  
where comm_account_id = 1000405
	and delete_sw = 'N' ;
						
update cjams.tb_commingled_account
	set total_balance_no = ( select sum(coalesce(total_balance_no,0))
								from cjams.tb_client_account
							 where comm_account_id = 1000405
								and delete_sw = 'N' ),
		update_ts = now(),
		update_user_id = 'CDM-11904'
where comm_account_id = 1000405
	and delete_sw = 'N' ;
