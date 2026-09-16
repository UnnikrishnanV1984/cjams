-- CDM-26620 - trust fund request issue
/*
-- Issue Description: 
   Duplicate purchase authorizations blocking the Child Account Funds 
   
-- Case ID: 3212844
-- Client ID: 1708191 (PRECIOUS	G PRINCE) - 51dc4fac-4965-4301-af4a-c28acb82ddb9
-- Conserved Account ID: 1017525 - C549079 - $2643.40

-- Authorization IDs
-- 5047144 (Target)
-- 1826801	04/06/2022 To 04/06/2022 - $1000.00
-- 1826802	04/06/2022 To 04/06/2022 - $1000.00

-- Category/ Module: Service Log/Purchase Authorization (Case Management) 
-- Root cause: TDB (mostly multiple clicks on submit button)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To Soft Delete the Duplucate Service Purchase Authorizations
select service_log_id, start_dt, end_dt, delete_sw, update_ts, update_user_id 
	from tb_service_purchase_authorization 
where authorization_id in ( 1826801, 1826802 )
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;

update tb_service_purchase_authorization 	
set delete_sw = 'Y',
	update_ts = now(), 
	update_user_id = 'CDM-26620'
where authorization_id in ( 1826801, 1826802 )
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;
