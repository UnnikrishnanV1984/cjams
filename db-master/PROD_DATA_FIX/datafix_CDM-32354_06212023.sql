-- CDM-32354 - Cannot Add Commingled Account
/*
-- Issue Description: 
   Commingled account is NOT linked to Foster Care Youth Saving Accounts

-- Montgomery County (1442)
-- Commingled Account ID: 1000401 -	Bank of America	- 446026601717

-- Client ID: 10040264 (KIONA STRANGE) - aab3d813-33d3-4bc6-bf90-d99a267ed044
-- Client Account ID: 1017711 - F1020899 - Foster Care Youth Saving

-- Client ID: 3731043 (ANIYA VAUGHAN) - 682984b8-ae75-4fee-8497-e3a5f72a79d1
-- Client Account ID: 1022678 - F986516 - Foster Care Youth Saving  
   
-- Category/ Module: Child Accounts (Finance Management) 
-- Root cause: User Error
-- Fix provided: Datafix has been promoted to Link Commingled account and 2 Foster Care Youth Saving Accounts.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


-- Associate Commingled Account for 2 Foster Care Youth Saving Accounts (CDM-32354)
-- Client ID: 10040264 (KIONA STRANGE) - aab3d813-33d3-4bc6-bf90-d99a267ed044
-- Client Account ID: 1017711 - F1020899 - Foster Care Youth Saving

select account_type_cd, account_exists_sw, bank_nm, account_no_tx, comm_account_id, update_ts, update_user_id 
   from cjams.tb_client_account  
where client_account_id = 1017711
  and delete_sw  = 'N' ;

update cjams.tb_client_account  
set comm_account_id = 1000401, -- Bank of America - 446026601717
	update_user_id = 'CDM-32354',
	update_ts = now()
where client_account_id = 1017711
  and delete_sw  = 'N' ;

-- Client ID: 3731043 (ANIYA VAUGHAN) - 682984b8-ae75-4fee-8497-e3a5f72a79d1
-- Client Account ID: 1022678 - F986516 - Foster Care Youth Saving  

select account_type_cd, account_exists_sw, bank_nm, account_no_tx, comm_account_id, update_ts, update_user_id 
   from cjams.tb_client_account  
where client_account_id = 1022678
  and delete_sw  = 'N' ;

update cjams.tb_client_account  
set comm_account_id = 1000401, -- Bank of America - 446026601717
	update_user_id = 'CDM-32354',
	update_ts = now()
where client_account_id = 1022678
  and delete_sw  = 'N' ;

-- Update Commingled Account Balance
select comm_account_id, bank_nm, total_balance_no, update_ts, update_user_id 
    from cjams.tb_commingled_account  
where comm_account_id = 1000401
    and delete_sw = 'N' ;
                        
update cjams.tb_commingled_account
    set total_balance_no = ( select sum(coalesce(total_balance_no,0))
                                from cjams.tb_client_account
                             where comm_account_id = 1000401
                                and delete_sw = 'N' ),
        update_ts = now(),
        update_user_id = 'CDM-32354'
where comm_account_id = 1000401
    and delete_sw = 'N' ;