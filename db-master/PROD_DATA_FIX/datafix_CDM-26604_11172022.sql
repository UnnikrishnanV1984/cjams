-- CDM-26604 - SSI money
/*
-- Issue Description: 
   Duplicate purchase authorizations blocking the Child Account Funds 
   
-- Case ID: 3194625
-- Client ID: 3186997 (MARQUISE	MARCUS CARTER) - 75b23bf4-aaac-4c7a-bcb0-3c6c608acf6a
-- Conserved Account ID: 1017337 - C983649 - $2103.50

-- Authorization IDs
-- 5044354 (JC Penney)
-- 1823521	03/16/2022 To 03/16/2022 - $500.00
-- 1823522	03/16/2022 To 03/16/2022 - $500.00
-- 1823523	03/16/2022 To 03/16/2022 - $500.00

-- 5030782	(Giant Foods)
-- 1829114	04/22/2022 To 04/22/2022 - $300.00
-- 1829115	04/22/2022 To 04/22/2022 - $300.00

-- Category/ Module: Service Log/Purchase Authorization (Case Management) 
-- Root cause: TDB (mostly multiple clicks on submit button)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To Soft Delete the Duplucate Service Purchase Authorizations
select service_log_id, start_dt, end_dt, delete_sw, update_ts, update_user_id 
	from tb_service_purchase_authorization 
where authorization_id in ( 1823521, 1823522, 1823523, 1829114, 1829115 )
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;

update tb_service_purchase_authorization 	
set delete_sw = 'Y',
	update_ts = now(), 
	update_user_id = 'CDM-26604'
where authorization_id in ( 1823521, 1823522, 1823523, 1829114, 1829115 )
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;

