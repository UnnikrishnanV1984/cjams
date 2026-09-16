/*
   Issue Description: CDM-40104
   Category/ Module  : Accounts
   Root cause:User error ( User requested to update transaction_amount_no =314.33)
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update tb_account_transaction 
set transaction_amount_no =314.33,
update_user_id = 'CDM-40104', update_ts = now()
where transaction_id = 1441247 and delete_sw = 'N';