-- CDM-32155 - Missing kinship provider
/*
-- Issue Description: 
	The provider is not showing in the Placeemnt search
	
-- Case ID: 3224397
-- Client ID: 3517721 (ANIYA LYRIC SCOTT) - 2c97fdbe-767d-4183-a98d-8df00be70edb
-- Provider ID: 6049747	(BRITTANY CHANTAL EDWARDS) - Local Department Home
	   
-- Category/ Module: GAP Application (Case Management)
-- Root cause: Provider Home Approval Data issue (No Home Approval record is marked as Active)
-- Fix Provided: Datafix has been promoted to update Provider's most recent Home Approval as Active.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update the active_sw  = 'Y' for the most recent Home Approval
select pa.provider_approval_id, pa.active_sw, pa.update_ts, pa.update_user_id
	from prov.tb_provider_approval pa
where pa.provider_id = 6049747
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
	update_user_id = 'CDM-32155'
where pa2.provider_approval_id 
	in (	select pa.provider_approval_id
				from prov.tb_provider_approval pa
			where pa.provider_id = 6049747
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
