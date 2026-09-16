-- CDM-30069 - Insufficient Funds
/*
-- Issue Description: 
   Duplicate purchase authorizations blocking the Child Account Funds 
   
-- Case ID: 3302797
-- Client ID: 4297624 (ANGELA MELISSA HILL) - 21c20bb8-df6c-4b1b-91bb-78527697fcd4
-- Conserved Account ID: 1018547 - C564619 - Total Balance $3308.08

	5074189	Drive Time Student Driving School	
	Consumer Education (Paid) 
	1949957	2023-02-13	2023-02-27	$399.00

	5028858	Worcester County Department of Social Services	
	Family (Paid) 
	1964664	2023-02-08	2023-02-08	$109.94
	2021539	2023-03-03	2023-03-03	$148.18
	2021540	2023-03-03	2023-03-03	$148.18
	2027418	2023-03-10	2023-03-10	$146.18
	2077538	2023-04-03	2023-04-03	$29.50
	2077539	2023-04-03	2023-04-03	$29.50

-- Category/ Module: Service Log/Purchase Authorization (Case Management) 
-- Root cause: TDB (mostly multiple clicks on submit button)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


-- To Soft Delete the Duplucate Service Purchase Authorizations
select service_log_id, start_dt, end_dt, delete_sw, update_ts, update_user_id 
	from tb_service_purchase_authorization 
where authorization_id in ( 1949957, 1964664, 2021539, 2021540, 2027418, 2077538, 2077539 )
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;

update tb_service_purchase_authorization 	
set delete_sw = 'Y',
	update_ts = now(), 
	update_user_id = 'CDM-30069'
where authorization_id in ( 1949957, 1964664, 2021539, 2021540, 2027418, 2077538, 2077539 )
	and delete_sw = 'N'
	and sprvsr_approval_status_cd is null
	and ads_approval_status_cd is null
	and funding_approval_status_cd is null
	and payment_approval_status_cd is null ;

