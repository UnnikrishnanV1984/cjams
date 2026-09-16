-- CDM-26440 - trust fund request insufficient funds issue
/*
-- Issue Description: 
   Duplicate purchase authorizations blocking the Child Account Funds 
   
-- Case ID: 211030008202
-- Client ID: 4197073 (NOVIA ALEMAYEHU) - 893ad303-3086-48c1-97a6-99951d39ff8c
-- Conserved Account ID: 1017769 - C481380 - $1776.35

-- Authorization IDs
-- 5092315 (The Foundation of The Arc of Northern Virginia)
-- 1859938 - 08/25/2022 To 08/25/2022 - $800.00
-- 1859939 - 08/25/2022 To 08/25/2022 - $800.00

-- Category/ Module: Service Log/Purchase Authorization (Case Management) 
-- Root cause: TDB (mostly multiple clicks on submit button)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To Soft Delete the Duplucate Service Purchase Authorizations
select service_log_id, start_dt, end_dt, delete_sw, update_ts, update_user_id 
	from tb_service_purchase_authorization 
where authorization_id in ( 1859938, 1859939 )
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;

update tb_service_purchase_authorization 	
set delete_sw = 'Y',
	update_ts = now(), 
	update_user_id = 'CDM-26440'
where authorization_id in ( 1859938, 1859939 )
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;

