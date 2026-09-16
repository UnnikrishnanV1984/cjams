-- CDM-23406 - Provider Name change
/*
-- Issue Description: 
	Provider #5065621, had a name change from Karen Sampson to Karen Kelly. 
	The name has changed in the provider profile but did update in the search provider. 

-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: Provider Module Data Issue
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Provider ID: 5065621	(Karen Kelly) - Local Department Home
-- Old Name: Karen Sampson 

select provider_nm, provider_first_nm, provider_middle_nm, provider_last_nm, update_ts, update_user_id
	from prov.tb_provider 
where provider_id = 5065621
	and delete_sw = 'N' ;

Update prov.tb_provider 
set provider_nm = '',
	update_ts = now(),
	update_user_id = 'CDM-23406'
where provider_id = 5065621
	and delete_sw  = 'N' ;
