-- CDM-18678 - Name Change 5017890
/*
-- Issue Description: 
  Provider's name has been changed which reflects on the provider profile screen (5017890) . 
  The name did not change on the provider information screen. 
  Finance with not release payment until all screens reflect the change. 
   
-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: Provider Module Data Issue
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Provider ID: 5017890	(Brenda Campbell) - Local Department Home
-- New Name: Brenda	S Campbell-Wise

select provider_nm, provider_first_nm, provider_middle_nm, provider_last_nm, update_ts, update_user_id
	from prov.tb_provider 
where provider_id = 5017890
	and delete_sw = 'N' ;

Update prov.tb_provider 
set provider_nm = '',
	update_ts = now(),
	update_user_id = 'CDM-18678'
where provider_id = 5017890
	and delete_sw  = 'N' ;

