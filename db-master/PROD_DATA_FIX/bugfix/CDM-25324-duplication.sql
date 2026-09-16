/*
   Issue Description: CDM-25324
   Category/ Module  : Service Log Needs To Be Deleted
   Root cause: User request to delete the duplicate purchase authorizations, 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


-- Case ID: 3185645
-- Client Name : DANIEL MAXWELL
-- 1854060 - 09/14/2022  TO	09/14/2022	 - $419.00
-- 1854059 - 09/14/2022  TO	09/14/2022   - $419.00

-- Category/ Module: Service Log/Purchase Authorization (Case Management) 
-- Root cause: Duplicate Authorization (mostly multiple clicks on submit button)
-- Fix Provided: Datafix has been provided to delete the requested Duplicate Purchase Authorizations
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

-- To Soft Delete the Duplucate Service Purchase Authorizations
select service_log_id, start_dt, end_dt, delete_sw, update_ts, update_user_id 
	from tb_service_purchase_authorization 
where authorization_id in ('1854060', '1854059') 
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;

update tb_service_purchase_authorization 	
set delete_sw = 'Y',
	update_ts = now(), 
	update_user_id = 'CDM-25324'
where authorization_id in ('1854060', '1854059') 
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;