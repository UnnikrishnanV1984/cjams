-- CDM-32943 - Insufficient funds lower amount
/*
-- Issue Description: 
   Duplicate purchase authorization blocking the Child Account Funds 
   
-- Case ID: 3167478
-- Client ID: 2182871 (TATANYA M WASHINGTON) - d788976b-3ff8-4a1a-a734-5a30d61c42cc
-- Conserved Account ID: 15517 - S000007876
-- Authorization IDs: 2083658, 2083659 & 2083661 - 04/12/2023 - $200.00
-- Financial Management (Paid) 
-- Provider ID: 5029437	(St. Mary's County Department of Social Services)

-- Category/ Module: Service Log/Purchase Authorization (Case Management) 
-- Root Cause: CJAMS is currently not allowing to use the Child Account funds as the below duplicate incomplete authorizations are blocking the funds.
-- Fix Provided: Datafix has been promoted to remove that duplicate Authorization.
--               Note: The Code Fix has been promoted to production as a part of CDM-30069 to prevent multiple clicks on authorization screen.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To Soft Delete the Duplucate Service Purchase Authorizations (CDM-32943)
select authorization_id, service_log_id, start_dt, end_dt, delete_sw, update_ts, update_user_id 
	from tb_service_purchase_authorization 
where authorization_id in (2083658, 2083659, 2083661)
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;

update tb_service_purchase_authorization 	
set delete_sw = 'Y',
	update_ts = now(), 
	update_user_id = 'CDM-32943'
where authorization_id in (2083658, 2083659, 2083661)
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;
