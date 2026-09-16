/*
  Issue Description:  CJAMS-63173
   Category/ Module  : service log  
   Root cause: user request to remove the draft purchase authorization.
   Pull request# for code fix: 
   Reason why no related code fix:NA 
*/

update tb_service_purchase_authorization
	set delete_sw = 'Y',
		update_ts = now(),
		update_user_id = 'CJAMS-63173'
	where authorization_id = 1832538;