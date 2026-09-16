-- CDM-20986 - Provider name change 5012616
/*
-- Issue Description: 
	Provider #5012616 The name's was changed from Maria Heggie to married name Maria Dyson in provider case 
	The name did not change on the provider information screen. 
	Finance will not issue payment until the provider information screen is corrected. 
   
-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: Provider Module Data Issue
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Provider ID: 5012616	(Maria V Dyson) - Local Department Home
-- Old Name: Maria Heggie

select provider_nm, provider_first_nm, provider_middle_nm, provider_last_nm, update_ts, update_user_id
	from prov.tb_provider 
where provider_id = 5012616
	and delete_sw = 'N' ;

Update prov.tb_provider 
set provider_nm = '',
	update_ts = now(),
	update_user_id = 'CDM-20986'
where provider_id = 5012616
	and delete_sw  = 'N' ;
