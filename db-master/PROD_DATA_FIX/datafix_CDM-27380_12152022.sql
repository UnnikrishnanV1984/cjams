-- CDM-27380 - Cannot complete a placement
/*
-- Issue Description: 
	The provider is not appear in the placement search.
	
-- Case ID: 3229728 
-- Client ID: 3581071 (EVAN BITTINGER) - e0ba8a75-28ef-4623-8935-1aa7bba5d938
-- Provider ID: 6002922	(KATRINA Dawn YODER) - Local Department Home
	   
-- Category/ Module: GAP Application (Case Management)
-- Root cause: Provider Home Approval Data issue (No record is marked as Active)
-- Fix Provided: Datafix has been promoted to update Provider's most recent Home Approval as Active.
-- Note: CJAMS Provider team is aware of this issue and they will be doing the code fix.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update the active_sw  = 'Y' for the most recent Home Approval
select pa.provider_approval_id, pa.active_sw, pa.update_ts, pa.update_user_id
	from prov.tb_provider_approval pa
where pa.provider_id = 6002922
	and pa.delete_sw = 'N'
	and (select count(*)
			from prov.tb_provider_approval pa1
		 where pa1.provider_id = pa.provider_id
			and pa1.delete_sw = 'N'
			and pa1.active_sw = 'Y'
		 ) = 0
order by pa.provider_approval_id desc
limit 1 ;
	 
update prov.tb_provider_approval pa2
set active_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-27380'
where pa2.provider_approval_id 
	in (	select pa.provider_approval_id
				from prov.tb_provider_approval pa
			where pa.provider_id = 6002922
				and pa.delete_sw = 'N'
				and (select count(*)
						from prov.tb_provider_approval pa1
					 where pa1.provider_id = pa.provider_id
						and pa1.delete_sw = 'N'
						and pa1.active_sw = 'Y'
					 ) = 0
			order by pa.provider_approval_id desc
			limit 1 
		) ;
