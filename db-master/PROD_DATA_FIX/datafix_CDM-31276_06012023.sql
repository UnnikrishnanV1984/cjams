-- CDM-31276 - Switching Adoption Subsidy payee
/*
-- Issue Description: 
	To fix the provider Home approval data (keep the most recent Home Approval with active_sw = 'Y' 
	
-- Provider ID: 6046792	(Bonnie Clauss) - 	Local Department Home	   
-- Category/ Module: GAP Application (Case Management)
-- Root cause: Provider Home Approval Data issue (Nultiple Home Apporvals are marked as Active)
-- Fix Provided: Datafix has been promoted to update Provider's most recent Home Approval as Active.
-- Note: CJAMS Provider team is aware of this issue and they will be doing the code fix.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update the active_sw  = 'Y' for the most recent Home Approval
select provider_approval_id, active_sw, update_ts, update_user_id, approval_type_cd
	from prov.tb_provider_approval 
where provider_id = 6046792
	and delete_sw = 'N'
	and provider_approval_id <> 142770 ;

	 
update prov.tb_provider_approval 
set active_sw = 'N',
	update_ts = now(),
	update_user_id = 'CDM-31276'
where provider_id = 6046792
	and delete_sw = 'N'
	and provider_approval_id <> 142770 ;
