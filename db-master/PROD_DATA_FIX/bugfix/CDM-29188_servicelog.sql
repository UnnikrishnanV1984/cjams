-- CDM-29188 - Flex fund request issue
/*
-- Issue Description: 
   Duplicate purchase authorizations blocking the Child Account Funds 
   
-- Case ID: 3293387 - christal.remy@maryland.gov
-- Client ID: 3964668 (KEITH SMITH) - c02fedea-c09d-4c08-984c-bde401e67173

-- Provider ID: 5036607 (Baltimore City Department of Social Services)
-- Authorizations:
-- 1817327	Child Account Conserved(7502)	Clothing Purchase (Paid)	02/03/2022	02/04/2022	$111.21
-- 1817326	Child Account Conserved(7502)	Clothing Purchase (Paid)	02/03/2022	02/04/2022	$111.21
 
-- Category/ Module: Service Log/Purchase Authorization (Case Management) 
-- Root cause: TDB (mostly multiple clicks on submit button)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To Soft Delete the Duplucate Service Purchase Authorizations
select service_log_id, start_dt, end_dt, delete_sw, update_ts, update_user_id 
	from tb_service_purchase_authorization 
where authorization_id in (1817326, 1817327)
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;

update tb_service_purchase_authorization 	
set delete_sw = 'Y',
	update_ts = now(), 
	update_user_id = 'CDM-29188'
where authorization_id in (1817326, 1817327)
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;
