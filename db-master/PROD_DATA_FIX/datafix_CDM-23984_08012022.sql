-- CDM-23984 - 5017713 Name change
/*
-- Issue Description: 
	Provider Rhonda Smallwood #5017713 had a name change to Rhonda Robinson. 
	The name was updated in the "provider profile" but 	did migrate nor change in the "search provider" 
	this will cause a payment delay. 

	The names have to match "Rhonda Robinson" in CJAMS.

-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: Provider Module Data Issue
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Provider ID: 5017713	(Rhonda	Robinson) - Local Department Home
-- Old Name: Rhonda Smallwood

select provider_nm, provider_first_nm, provider_middle_nm, provider_last_nm, update_ts, update_user_id
	from prov.tb_provider 
where provider_id = 5017713
	and delete_sw = 'N' ;

Update prov.tb_provider 
set provider_nm = '',
	update_ts = now(),
	update_user_id = 'CDM-23984'
where provider_id = 5017713
	and delete_sw  = 'N' ;
