/*
  Issue Description:  3156702:This Purchase Authorization is preventing the provider from being closed.
   Category/ Module  : service log  
   Root cause: user request to remove the draft purchase authorization.
   Pull request# for code fix: 
   Reason why no related code fix:NA 
*/
update tb_service_purchase_authorization
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CJAMS-63265'
where authorization_id = 324672
	and delete_sw = 'N';