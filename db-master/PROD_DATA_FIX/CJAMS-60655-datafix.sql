-- CJAMS-60655 -  Purchase Authorization
/*
-- Issue Description: 
   Duplicate purchase authorizations delete the authorization number 3837391 
   
-- Case ID: 202108506858 - angela.shreves1@maryland.gov

-- Provider ID: 3837391 
-- Authorizations:
 
-- Category/ Module: Service Log/Purchase Authorization (Case Management) 
-- Root cause: TDB (mostly multiple clicks on submit button)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update tb_service_purchase_authorization 	
set delete_sw = 'Y',
	update_ts = now(), 
	update_user_id = 'CJAMS-60655'
where authorization_id = '3837391'
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;