/*
   Issue Description: CJAMS-59559
   Category/ Module  : PA needs to be deleted
   Root cause: User request to delete the duplicate purchase authorizations, Duplicate Authorization (mostly multiple clicks on submit button)
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

/*
select service_log_id, start_dt, end_dt, delete_sw, update_ts, update_user_id
	from tb_service_purchase_authorization 
where authorization_id in (3796362) 
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;--3676976
*/

update tb_service_purchase_authorization 	
set delete_sw = 'Y',
	update_ts = now(), 
	update_user_id = 'CJAMS-59559'
where authorization_id in (3796362) 
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;
