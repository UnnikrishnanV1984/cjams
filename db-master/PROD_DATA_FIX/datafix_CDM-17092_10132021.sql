-- CDM-17092 - Delete Payment Authorization
/*
-- Issue Description: 
   User request to delete duplicate purchase authorization(1740467)
   Duplicate Auth ID: 1740468
   
-- Case ID: 2020016101416 
-- Client ID: 3764614 (AVA NICHOLE NOON) - fe92d305-7e8b-405f-916e-e704550a8ebf
-- Provider ID: 5085335 (Ethel Brown)
-- Service Log ID: 1963445 - Clothing Purchase (Paid) 
-- Authorization ID: 1740467 - 08/27/2020 To 08/27/202 - $55.73

-- Category/ Module: Service Log/Purchase Authorization (Case Management) 
-- Root cause: User error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Soft_delete the requested Duplucate Service Purchase Authorization
select service_log_id, start_dt, end_dt, delete_sw, update_ts, update_user_id 
	from tb_service_purchase_authorization 
where authorization_id = 1740467
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;

update tb_service_purchase_authorization 	
set delete_sw = 'Y',
	update_ts = now(), 
	update_user_id = 'CDM-17092'
where authorization_id = 1740467
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;	
	