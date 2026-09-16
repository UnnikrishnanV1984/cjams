/*
   Issue Description: CJAMS-60395
   Category/ Module  :  Reopen Child AccountClient ID: 3158046 , 
   Root cause: User Error,user wants to reopen the clild account.
    A final disbursement was made on 2/21/2025 for youth CI#3158046, child acct: C434496. 
    The check remained outstanding. Recently the worker indicated the youth is back in state custody and the check needs to be voided and funds redeposited into the child account.    Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix
*/
--select status_cd , close_dt , final_close_dt ,update_user_id , * from tb_client_account tca where client_account_id  = 1031259 
update tb_client_account 
set	status_cd = '592',
	close_dt = null,
	final_close_dt = null,
	update_user_id = 'CJAMS-60395',
	update_ts = now()
where client_account_id = 1031259 
and delete_sw = 'N';