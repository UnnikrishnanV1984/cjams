-- CDM-25340 - Provider Name Change
/*
-- Issue Description: 
	Provider name was updated in the "provider profile" 
	but did migrate nor change in the "search provider" this will cause a payment delay. 

-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: Provider Module Data Issue
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Provider ID: 5008038 (Donna Levine-Burleson) - Local Department Home
-- Old Name: Donna Levine

-- Provider ID: 5026591 (Taita Yates) - Local Department Home
-- Old Name: Taita Yates-farr

select provider_nm, provider_first_nm, provider_middle_nm, provider_last_nm, update_ts, update_user_id
	from prov.tb_provider 
where provider_id in ( 5008038, 5026591 ) 
	and delete_sw = 'N' ;

Update prov.tb_provider 
set provider_nm = '',
	update_ts = now(),
	update_user_id = 'CDM-25340'
where provider_id in ( 5008038, 5026591 ) 
	and delete_sw  = 'N' ;


