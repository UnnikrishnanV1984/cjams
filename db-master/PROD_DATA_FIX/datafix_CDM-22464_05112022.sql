-- CDM-22464 - Placement cannot be completed
/*
-- Issue Description: 
	Cannot complete placement because provider could not be found while doing a placement search. 
	The provider is Liana Ponce- #5089054 
	   
-- Category/ Module: GAP Application (Case Management)
-- Root cause: Provider Home Approval Data issue
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update the active_sw  = 'Y' for the most recent Home Approval
select pa.provider_id, pa.active_sw, pa.update_ts, pa.update_user_id, *
	from prov.tb_provider_approval pa
where pa.provider_approval_id = 109998
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
	pa.update_user_id = 'CDM-22464'
where pa.provider_approval_id = 109998
	and pa.delete_sw = 'N'
	and (select count(*)
			from prov.tb_provider_approval pa1
		 where pa1.provider_id = pa.provider_id
			and pa1.delete_sw = 'N'
			and pa1.active_sw = 'Y'
		 ) = 0 ;	
