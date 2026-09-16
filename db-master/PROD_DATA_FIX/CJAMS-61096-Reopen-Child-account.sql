/*
   Issue Description: CJAMS-61096
   Category/ Module  :  Reopen Child AccountClient ID: 1683437, 
   Root cause: The Child Account was closed and the child account Final Disbursement was approved on 06/05/2025.
    User is requested to re-open the child account.
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix
*/

update tb_client_account 
set	status_cd = '592', --593
	close_dt = null,
	final_close_dt = null,
	update_user_id = 'CJAMS-61096',
	update_ts = now()
where client_account_id = 15815 
and delete_sw = 'N';