/*
Issue:Need to reopen required child accounts.
Root Cause:User request to reopen child accounts due to they do not have acces to do that.
Fix Provided (Data Fix Only):Data fix was done by Updated tb_client_account table .
Data/Code fix ticket#: CJAMS-60975
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/
update tb_client_account 
set	status_cd = '592', 
	close_dt = null,
	final_close_dt = null,
	update_user_id = 'CJAMS-60975',
	update_ts = now()
where client_account_id in(1022579,15286,1031391,1017014,13120,1017346,1017550)
and delete_sw = 'N';
