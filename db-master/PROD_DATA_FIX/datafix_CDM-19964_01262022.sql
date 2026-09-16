-- CDM-19964 - Provider Information
/*
-- Issue Description: 
	The provider's name was corrected in the provider portal from Antionette to Antoinette. 
	The change did not update the provider's name, but did update provider's profile name. 
   
-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: Provider Module Data Issue
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Provider ID: 5041150	(Antoinette Garrett) - Local Department Home
-- Incorrect Name: Antionette Garrett

select provider_nm, provider_first_nm, provider_middle_nm, provider_last_nm, update_ts, update_user_id
	from prov.tb_provider 
where provider_id = 5041150
	and delete_sw = 'N' ;

Update prov.tb_provider 
set provider_nm = '',
	update_ts = now(),
	update_user_id = 'CDM-19964'
where provider_id = 5041150
	and delete_sw  = 'N' ;

