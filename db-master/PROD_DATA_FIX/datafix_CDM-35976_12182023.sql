-- CDM-35976 - Provider 6006983 Issue
/*
-- Issue Description: 
   CJAMS provider number 6006983 for payment id 3754331 did not interface to D365.  
   
-- Vendor ID: 6006983 (Alikia Jackson) 
-- Baltimore City user Felicia Atueyi - felicia.atueyi@maryland.gov

--	Payment ID 	Auth ID		Payment Date	Amount		Service Date
--	3223247		1848738		2022-08-25		$600.00		2022-08-18
--	3754331		2624437		2023-10-13		$600.00		2023-10-10

--	There is an issue in vendor address, the city name lenght 37 is an issue.
--	The allowed characters for this field is 30.
--	Current Value: Baltimore City Dept of Social Service
   
-- Category/ Module: D365 Interface (Finance Management) 
-- Root cause: Provider Address Data Issue 
-- Fix Provided: Datafix has been promoted to fix the Provider Address City Name and 
--  			 to update the Payment Status as "Approved" for CJAMS - D365 Interface to process those 2 payments again.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- Fix the Provider Address City Name
select adr_city_nm, update_ts, update_user_id 
	from prov.tb_provider_addresses
where address_id = 121250
	and delete_sw = 'N' ;

update prov.tb_provider_addresses
set adr_city_nm = 'Baltimore City',
	update_ts = now(),
	update_user_id = 'CDM-35976'
where address_id = 121250
	and delete_sw = 'N' ;
	
-- Payment Status updated as "Approved" for CJAMS - D365 Interface to process these payments again.
select payment_id, payment_status_cd, update_ts, update_user_id 
	from tb_payment_status 
where payment_id in ( 3223247, 3754331 )
	and delete_sw  = 'N' ;
	
update tb_payment_status 
set payment_status_cd = '1634', -- Approved
	update_ts = now(),
	update_user_id = 'CDM-35976'
where payment_id in ( 3223247, 3754331 )
	and delete_sw  = 'N' ;
