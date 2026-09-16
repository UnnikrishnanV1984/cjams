-- CDM-24812 - Erase error
/*
-- Issue Description: 
   User request to delete purchase authorization
   
-- Case ID: 3238047
-- Client ID: 3246142 (BRIANNA ALSTON-FULLER) - c0c0e890-5ecb-477f-8327-a5acf077e11b
-- Authorization ID: 1850738 - 08/31/2022 TO 08/31/2022	- $275.00
-- Transportation assistance (Paid)
-- Provider ID: 5036607	(Baltimore City Department of Social Services)   

-- Category/ Module: Service Log/Purchase Authorization (Case Management) 
-- Root cause: User error
-- Fix Provided: Datafix has been provided to delete the requested incomplete Purchase Authorization
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To Soft Delete the Duplucate Service Purchase Authorizations
select service_log_id, start_dt, end_dt, delete_sw, update_ts, update_user_id 
	from tb_service_purchase_authorization 
where authorization_id = 1850738
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;

update tb_service_purchase_authorization 	
set delete_sw = 'Y',
	update_ts = now(), 
	update_user_id = 'CDM-24812'
where authorization_id = 1850738
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;
