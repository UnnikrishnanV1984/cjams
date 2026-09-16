-- CDM-22996 - Child Account Funds
/*
-- Issue Description: 
   Duplicate purchase authorizations blocking the Child Account Funds 
   
-- Case ID: 3266001
-- Client ID: 2091277 (ANTHONY WILLIAM PERSINGER) - 52038051-fd99-4a44-b95f-c784e65292d8
-- Conserved Account ID: 1832943, 1832944, 1832945, 1832946, 1832947 & 1832948 - $841.00
-- Provider ID: 5095514	(Shared Horizon, Inc) 
-- Srevice: Disabled Children (Paid) for Period 05/01/2022 To 05/31/2022 - $841.00

-- Category/ Module: Service Log/Purchase Authorization (Case Management) 
-- Root cause: User error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To Soft Delete the Duplucate Service Purchase Authorizations
select service_log_id, start_dt, end_dt, delete_sw, update_ts, update_user_id 
	from tb_service_purchase_authorization 
where authorization_id 
		in ( 1832943, 1832944, 1832945, 1832946, 1832947, 1832948 )
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;

update tb_service_purchase_authorization 	
set delete_sw = 'Y',
	update_ts = now(), 
	update_user_id = 'CDM-22996'
where authorization_id 
		in ( 1832943, 1832944, 1832945, 1832946, 1832947, 1832948 )
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;