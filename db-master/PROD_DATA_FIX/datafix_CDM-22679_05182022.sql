-- CDM-22679 - Provider issue
/*
-- Issue Description: 
	Provider 5007227 is not populate for placement. 
	We can find them when we do a provider search but not in the placement screen
	   
-- Category/ Module: GAP Application (Case Management)
-- Root cause: Provider Home Approval Data issue
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Provider ID: 5007227 (Gina Burkett) - Local Department Home
-- Update the active_sw  = 'Y' for the most recent Home Approval
select pa.provider_id, pa.active_sw, pa.update_ts, pa.update_user_id, *
	from prov.tb_provider_approval pa
where pa.provider_approval_id = 108182
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
	pa.update_user_id = 'CDM-22679'
where pa.provider_approval_id = 108182
	and pa.delete_sw = 'N'
	and (select count(*)
			from prov.tb_provider_approval pa1
		 where pa1.provider_id = pa.provider_id
			and pa1.delete_sw = 'N'
			and pa1.active_sw = 'Y'
		 ) = 0 ;	
