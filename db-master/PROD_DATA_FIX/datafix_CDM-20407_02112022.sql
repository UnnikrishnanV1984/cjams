-- CDM-20407 - Duplicate Service Log
/*
-- Issue Description: 
   User Request to delete duplicate purchase authorization 
   
-- Case ID:3284563
-- Client ID: 4109878 (IMIYA CHRISTIAN) - c7dafb5f-ffdd-4a4d-bd8f-98bd80a0238d
-- Authorization ID: 1818374 - 01/01/2022 To 01/31/2022
-- Service Log ID: 2031675 - Special Education (Paid) 
-- Provider ID: 5041606	(Specialized Education of MD, Inc.)


-- Category/ Module: Service Log/Purchase Authorization (Case Management) 
-- Root cause: User error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Soft_delete the requested Duplucate Service Purchase Authorization
select service_log_id, start_dt, end_dt, delete_sw, update_ts, update_user_id 
	from tb_service_purchase_authorization 
where authorization_id = 1818374
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;

update tb_service_purchase_authorization 	
set delete_sw = 'Y',
	update_ts = now(), 
	update_user_id = 'CDM-20407'
where authorization_id = 1818374
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;

