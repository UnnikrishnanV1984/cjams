-- CDM-15166 - Provider not found
/*
-- Issue Description: 
	CJAMS GAP providxer search is not displying Provider ID: 6001570 (TOBEY L FAMOLARO)
	   
-- Category/ Module: GAP Application (Case Management)
-- Root cause: Provider Home Approval Data issue
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Before
-- Kinship Home Approval
select provider_approval_id, effective_dt, effective_end_dt, active_sw, update_ts, update_user_id 
	from prov.tb_provider_approval 
where provider_id = 6001570
	and provider_approval_id = 102718
	and delete_sw = 'N' ;
	
update prov.tb_provider_approval 
set active_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-15166'
where provider_id = 6001570
	and provider_approval_id = 102718
	and delete_sw = 'N' ;
	
	