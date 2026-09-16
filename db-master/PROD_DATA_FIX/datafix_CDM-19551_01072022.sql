-- CDM-19551 - Rochelle Smith 5035431
/*
-- Issue Description: 
	Provider's name was changed to Rochelle Smith in the provider case. 
	The provider search continues to reflect the previous last name, Corner.
	This appears to be a CJAMS issue. 
	Assistance is needed to ensure the name change is reflected throughout CJAMS.
   
-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: Provider Module Data Issue
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Provider ID: 5035431	(Rochelle Corner) - Local Department Home
-- New Name: Rochelle Smith

select provider_nm, provider_first_nm, provider_middle_nm, provider_last_nm, update_ts, update_user_id
	from prov.tb_provider 
where provider_id = 5035431
	and delete_sw = 'N' ;

Update prov.tb_provider 
set provider_nm = '',
	update_ts = now(),
	update_user_id = 'CDM-19551'
where provider_id = 5035431
	and delete_sw  = 'N' ;

