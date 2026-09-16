/*
Issue:Need to reopen required child accounts.
Root Cause:User request to reopen child accounts as most of the closed child account were migrated data and the last child account is still active.
Fix Provided (Data Fix Only):Data fix was done by Updated tb_client_account table .
Data/Code fix ticket#: CJAMS-65980
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/


update tb_client_account 
set    status_cd = '592',
    close_dt = null,
    final_close_dt = null,
    update_user_id = 'CJAMS-65980',
    update_ts = now()
where client_account_id in ('15308','13003','12996','12983')
and delete_sw = 'N';