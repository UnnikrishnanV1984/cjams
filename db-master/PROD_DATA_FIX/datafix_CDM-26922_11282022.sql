-- CDM-26922 - Insufficient funds continuous issue
/*
-- Issue Description: 
   Duplicate purchase authorizations blocking the Child Account Funds 
   
-- Case ID: 3110807 - felicia.atueyi@maryland.gov
-- Client ID: 3988327 (ISAIAH SANDERS) - 8158eb4b-8411-4606-a09d-7be3ec529567
-- Conserved Account ID: 1017340 - C1044667 - $3017.65

-- Authorization IDs
-- 5076921	JCpennys	
-- 1823517	2022-03-16	2022-03-17	$300.00
-- 1823518	2022-03-16	2022-03-17	300.00

-- 6005878	Cy Belmar Inc. 	
-- 1829119	2022-04-22	2022-04-23	$257.00
-- 1829120	2022-04-22	2022-04-23	$257.00
-- 1829121	2022-04-22	2022-04-23	$257.00

-- 5052523	Nordstrom	
-- 1829317	2022-04-25	2022-04-26	$386.00

-- 5037934	Foot Locker	
-- 1832182	2022-05-11	2022-05-12	$400.00

-- Category/ Module: Service Log/Purchase Authorization (Case Management) 
-- Root cause: TDB (mostly multiple clicks on submit button)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To Soft Delete the Duplucate Service Purchase Authorizations
select service_log_id, start_dt, end_dt, delete_sw, update_ts, update_user_id 
	from tb_service_purchase_authorization 
where authorization_id in ( 1823517, 1823518, 1829119, 1829120, 1829121, 1829317, 1832182 )
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;

update tb_service_purchase_authorization 	
set delete_sw = 'Y',
	update_ts = now(), 
	update_user_id = 'CDM-26922'
where authorization_id in ( 1823517, 1823518, 1829119, 1829120, 1829121, 1829317, 1832182 )
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;
