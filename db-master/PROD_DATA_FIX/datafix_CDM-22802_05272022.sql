-- CDM-22802 - Provider #5014283 Name change
/*
-- Issue Description: 
	The provider's name was updated in the provider profile, to Maddox (from Stagg-Maddox). 
	The name did not update in the provider search. Please assist.
   
-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: Provider Module Data Issue
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Provider ID: 5014283 (Kimberly Maddox) - Local Department Home
-- Old Name: Kimberly Stagg-maddox 

select provider_nm, provider_first_nm, provider_middle_nm, provider_last_nm, update_ts, update_user_id
	from prov.tb_provider 
where provider_id = 5014283
	and delete_sw = 'N' ;

Update prov.tb_provider 
set provider_nm = '',
	update_ts = now(),
	update_user_id = 'CDM-22802'
where provider_id = 5014283
	and delete_sw  = 'N' ;

