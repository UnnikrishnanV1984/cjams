/*

Issue Description: CDM-10386-
   Category/ Module  :  Bringing account to zero balance
   Root cause: Moved from chessie and not updated the account balance correctly
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
Back up:total_balance_no=351.92,available_balance_no=351.92

*/

update tb_client_account set total_balance_no=0, available_balance_no=0,update_ts=now(),update_user_id='CDM-10386' where client_id=1737100 and client_account_id=11523;
