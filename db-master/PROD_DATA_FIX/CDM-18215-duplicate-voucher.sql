-- CDM-18215 - duplicate voucher
/*
-- Issue Description: 
   User request to delete the duplicate purchase authorizations, 
   
-- Case ID: 3089333
-- Client Name :CLAYTON Lytle
-- Client ID :1289108 
-- Provider ID: 5006715 (CLAYTON Lytle) 
-- 1802541 - 11/03/2021 to 11/03/2021 -	$350.00

-- Category/ Module: Service Log/Purchase Authorization (Case Management) 
-- Root cause: Duplicate Authorization (mostly multiple clicks on submit button)
-- Fix Provided: Datafix has been provided to delete the requested Duplicate Purchase Authorizations
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To Soft Delete the Duplucate Service Purchase Authorizations
select service_log_id, start_dt, end_dt, delete_sw, update_ts, update_user_id 
	from tb_service_purchase_authorization 
where authorization_id in (1802541) 
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;

update tb_service_purchase_authorization 	
set delete_sw = 'Y',
	update_ts = now(), 
	update_user_id = 'CDM-18215'
where authorization_id in (1802541) 
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;