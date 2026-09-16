/*
   Issue Description: CDM-10276- Conserved Account-Closed
   Category/ Module  :  Client account
   Root cause: User unknowingly added
   Pull request# for code fix: 
   Reason why no related code fix: Working as expected in application
   Status of the code fix if already submitted and expected prod fix date: 
--Backup: total_balance_no:0.21 , available_balance_no = 0.21
*/
update tb_client_account set total_balance_no=0,available_balance_no=0,update_ts=now(),update_user_id='CDM-10276' where client_account_id=11700 and client_id=1078498;
update tb_account_transaction set delete_sw='Y',update_ts=now(),update_user_id='CDM-10276' where transaction_id=1131562 and client_account_id=11700;