-- CDM-26183 - Cannot use code 7502 for service log
/*
-- Issue Description: 
   Duplicate purchase authorizations blocking the Child Account Funds 
   
-- Case ID: 3262828 - georgettee.sliger@maryland.gov
-- Client ID: 3132330 (DREZDEN SHAINE MOORE) - a9b429ac-7010-4205-9e11-cae5841cdd35
-- Conserved Account: 1017541 - $2091.56
-- Provider ID: 5002447	Garrett Co Dept Of Social Services - Furniture, Equipment (Paid)		
-- Auth ID: 1859122	2022-10-05	2022-10-05	507.44
-- Auth ID: 1859123	2022-10-05	2022-10-05	507.44

-- Category/ Module: Service Log/Purchase Authorization (Case Management) 
-- Root cause: TDB (mostly multiple clicks on submit button)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To Soft Delete the Duplucate Service Purchase Authorizations
select service_log_id, start_dt, end_dt, delete_sw, update_ts, update_user_id 
	from tb_service_purchase_authorization 
where authorization_id in ( 1859122, 1859123 )
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;

update tb_service_purchase_authorization 	
set delete_sw = 'Y',
	update_ts = now(), 
	update_user_id = 'CDM-26183'
where authorization_id in ( 1859122, 1859123 )
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;

