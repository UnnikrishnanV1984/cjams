-- CDM-27451 - Insufficient funds issue
/*
-- Issue Description: 
   Duplicate purchase authorization blocking the Child Account Funds 
   
-- Case ID: 3280463
-- Client ID: 4067081 (BROOKE M HEDDINGER) - 3d1f69d9-9133-4817-b4cc-336d48fdad0c
-- Conserved Account ID: 1017260 (C280846) - $1292.00
-- Authorization ID: 1825942 - 2022-04-01 TO 2022-04-01	 - $1223.00 - Other (Paid)
-- Provider ID: 5002553	(Target)

-- Category/ Module: Service Log/Purchase Authorization (Case Management) 
-- Root cause: Duplicate Authorization (mostly multiple clicks on submit button)
-- Fix Provided: Datafix has been provided to delete the requested incomplete Purchase Authorization
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To Soft Delete the Duplucate Service Purchase Authorizations
select service_log_id, start_dt, end_dt, delete_sw, update_ts, update_user_id 
	from tb_service_purchase_authorization 
where authorization_id = 1825942
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;

update tb_service_purchase_authorization 	
set delete_sw = 'Y',
	update_ts = now(), 
	update_user_id = 'CDM-27451'
where authorization_id = 1825942
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;
