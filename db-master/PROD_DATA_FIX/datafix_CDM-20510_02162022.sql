-- CDM-20510 - Provider Name Change
/*
-- Issue Description: 
	The provider's name Michelle Renee Lee-King has been successfully changed in the provider profile 
	but did not change in the provider search. 
   
-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: Provider Module Data Issue
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Provider ID: 5048323	(Michelle L Lee-King) - Local Department Home
-- Old Name: Michelle King

select provider_nm, provider_first_nm, provider_middle_nm, provider_last_nm, update_ts, update_user_id
	from prov.tb_provider 
where provider_id = 5048323
	and delete_sw = 'N' ;

Update prov.tb_provider 
set provider_nm = '',
	update_ts = now(),
	update_user_id = 'CDM-20510'
where provider_id = 5048323
	and delete_sw  = 'N' ;
