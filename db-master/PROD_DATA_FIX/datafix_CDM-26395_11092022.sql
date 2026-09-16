-- CDM-26395 - Flex fund request issue
/*
-- Issue Description: 
   Duplicate purchase authorizations blocking the Child Account Funds 
   
-- Case ID: 3279123 - christal.remy@maryland.gov
-- Client ID: 1698831 (AMAYA Y SUTTON) - c02fedea-c09d-4c08-984c-bde401e67173
-- Conserved Account ID: 1017182 (C602150) - $1674.20

-- Provider ID: 5036607 (Baltimore City Department of Social Services)
-- Authorizations:
-- 1815884	2022-01-26	2022-01-26	147.84 - Child Development (Paid) 
-- 1815956	2022-01-26	2022-01-26	174.77 - Clothing Purchase (Paid) 
-- 1816142	2022-01-27	2022-01-27	185.91 - Clothing Purchase (Paid) 
-- 1816143	2022-01-27	2022-01-27	185.91 - Clothing Purchase (Paid) 
-- 1816144	2022-01-27	2022-01-27	185.91 - Clothing Purchase (Paid) 
-- 1823492	2022-03-16	2022-03-23	388.00 - Furniture, Equipment (Paid) 
 
-- Category/ Module: Service Log/Purchase Authorization (Case Management) 
-- Root cause: TDB (mostly multiple clicks on submit button)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To Soft Delete the Duplucate Service Purchase Authorizations
select service_log_id, start_dt, end_dt, delete_sw, update_ts, update_user_id 
	from tb_service_purchase_authorization 
where authorization_id in ( 1815884, 1815956, 1816142, 1816143, 1816144, 1823492 )
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;

update tb_service_purchase_authorization 	
set delete_sw = 'Y',
	update_ts = now(), 
	update_user_id = 'CDM-26395'
where authorization_id in ( 1815884, 1815956, 1816142, 1816143, 1816144, 1823492 )
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;
