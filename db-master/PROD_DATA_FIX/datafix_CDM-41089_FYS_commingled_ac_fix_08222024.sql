-- CDM-41089 - Setup of Child FYS Account
/*
-- Issue Description: 
   User error, commingled account is NOT linked to Foster Care Youth Saving Accounts

-- St. Mary's County (1446)
-- Commingled Account ID: 400	Foster Youth Savings-Comm # 933156732

1. Client ID: 202831578	(Raneem Alameer) - 15d94bb6-4d54-4a15-8ae4-b90f067230a7
   sub #F989014 - 1040097
   
2. Client ID: 201345023	(Skylar Alvey) - 66f2016c-3e2e-4360-9502-5a410bf73565
   sub # F698001 - 1040592
   
-- Category/ Module: Child Accounts (Finance Management) 
-- Root cause: User Error, commingled account is NOT linked to Foster Care Youth Saving Accounts
-- Fix provided: Datafix has been promoted to Link Commingled account and 2 Foster Care Youth Saving Accounts.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To associate Commingled Account for 2 FYS Accounts (CDM-41089)
update cjams.tb_client_account  
set comm_account_id = 400, -- Foster Youth Savings-Comm # 933156732
	update_user_id = 'CDM-41089',
	update_ts = now()
where client_account_id in (1040097, 1040592)
  and delete_sw  = 'N' ;

-- Update Commingled Account Balance
update cjams.tb_commingled_account
    set total_balance_no = ( select sum(coalesce(total_balance_no,0))
                                from cjams.tb_client_account
                             where comm_account_id = 400
                                and delete_sw = 'N' ),
        update_ts = now(),
        update_user_id = 'CDM-41089'
where comm_account_id = 400
    and delete_sw = 'N' ;
	