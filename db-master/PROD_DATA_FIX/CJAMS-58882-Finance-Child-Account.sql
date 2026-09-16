/*
   Issue Description: CJAMS-58882
   Category/ Module  :  Reopen Child AccountClient ID: 2690353, 
   Root cause: User Error,user wants to reopen the clild account.
   A final disbursement was issued in error and the funds must be redeposited back into the child's account until Baltimore City DSS becomes official Rep Payee for the youth.
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix
*/
--select status_cd , close_dt , final_close_dt ,update_user_id , * from tb_client_account tca where client_account_id  = 1037079
update tb_client_account 
set	status_cd = '592',
	close_dt = null,
	final_close_dt = null,
	update_user_id = 'CJAMS-58882',
	update_ts = now()
where client_account_id = 1037079 
and delete_sw = 'N';