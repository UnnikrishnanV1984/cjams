-- CDM-13255 - Finance Service Log
/*
-- Issue Description: 
   User request to delete un-approved /Incomplete Purchase Authorization 
   
-- Case ID: 3246089
-- Client ID: 3171139 (JANAY A WINKLER) - f036bdc0-6d5e-4377-bdfe-b73e5765cb0c
-- Provider ID: 5008913	(Baltimore County DSS)
-- Service Log ID: 1997694 - Financial Management (Paid)
-- Authorization ID: 1776144 - 05/14/2021 To 05/14/2021 - $500.00

-- Category/ Module: Service Log/Purchase Authorization (Case Management) 
-- Root cause: User error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Soft_delete the requested Service Purchase Authorization

select service_log_id, start_dt, end_dt, delete_sw, update_ts, update_user_id 
	from tb_service_purchase_authorization 
where authorization_id = 1776144
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;

update tb_service_purchase_authorization 	
set delete_sw = 'Y',
	update_ts = now(), 
	update_user_id = 'CDM-13255'
where authorization_id = 1776144
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;	
	