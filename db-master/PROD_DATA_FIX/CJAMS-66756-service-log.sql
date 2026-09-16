/*
  Issue Description:  CJAMS-66756
   Category/ Module: service log  
   Root cause: user request to remove the draft purchase authorization.
   Pull request# for code fix: 
   Reason why no related code fix:NA 
*/


update tb_service_purchase_authorization
set delete_sw = 'Y', 
    update_user_id='CJAMS-66756', 
    update_ts=now()
where authorization_id in ('4337456', '4337457') 
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null;