/*
  Issue Description:  CJAMS-58000
   Category/ Module  : service log  
   Root cause: user request to remove the draft purchase authorization.
   Pull request# for code fix: 
   Reason why no related code fix:NA 
*/

update tb_service_purchase_authorization
	set delete_sw = 'Y',
		update_ts = now(),
		update_user_id = 'CJAMS-58000'
	where authorization_id = 1803440;