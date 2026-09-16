-- CDM-15114 - Forward to Funding
/*
-- Issue Description: 
   Authorization 1784519 and 1784517, are listed as having been forwarded to funding; 
   however, they are not on Finance's service log to be approved for funding.
   
-- Category/ Module: Service Log/Purchase Authorization (Case Management) 
-- Root cause: Extra space in the Provider Name 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select provider_id, provider_nm, update_ts, update_user_id 
	from prov.tb_provider 
where provider_id = 5071811
	and delete_sw  = 'N' ;


Update prov.tb_provider 
set provider_nm = btrim(provider_nm),
	update_ts = now(),
	update_user_id = 'CDM-15114'
where provider_id = 5071811
	and delete_sw  = 'N' ;

