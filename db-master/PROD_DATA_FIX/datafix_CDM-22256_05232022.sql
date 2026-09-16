-- CDM-22256 - Unable to place child in formal kinship care
/*
-- Issue Description: 
	Cannot complete placement because provider could not be found while doing a placement search.
	-- Provider ID: 6004758	(Robin Chapman) -- Local Department Home
	   
-- Category/ Module: GAP Application (Case Management)
-- Root cause: Provider Home Approval Data issue
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update the active_sw  = 'Y' for the most recent Home Approval
select pa.provider_id, pa.active_sw, pa.update_ts, pa.update_user_id, *
	from prov.tb_provider_approval pa
where pa.provider_approval_id = 108419
	and pa.delete_sw = 'N'
	and (select count(*)
			from prov.tb_provider_approval pa1
		 where pa1.provider_id = pa.provider_id
			and pa1.delete_sw = 'N'
			and pa1.active_sw = 'Y'
		 ) = 0 ;	
	 
update prov.tb_provider_approval pa
set pa.active_sw = 'Y',
	pa.update_ts = now(),
	pa.update_user_id = 'CDM-22256'
where pa.provider_approval_id = 108419
	and pa.delete_sw = 'N'
	and (select count(*)
			from prov.tb_provider_approval pa1
		 where pa1.provider_id = pa.provider_id
			and pa1.delete_sw = 'N'
			and pa1.active_sw = 'Y'
		 ) = 0 ;	
