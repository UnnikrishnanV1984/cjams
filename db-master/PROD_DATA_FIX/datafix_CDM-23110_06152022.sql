-- CDM-23110 - No Payments Generated
/*
-- Issue Description: 
	This issue was resloved with CDM-23111 - Adoption Subsidy Payment-Provider
	With this ticket, we are fixing the Home Approval Active Switch issue of the same Adoptive parent provider
	
-- Case ID: 3261944 
-- Adoption ID: 45066 - 2015-11-19 To 2025-04-20 - c073ba98-a053-4ec0-b100-91485e950790
-- Client ID: 3893585 (LILLY LASHAWN MONROE-PARKER) - 73037579-490d-4ccc-8395-854a368967e1
-- Provider ID: 5055808	(Christel Parker)- Local Department Home
   
-- Category/ Module: GAP Application (Case Management)
-- Root cause: Provider Home Approval Data issue
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update the active_sw  = 'Y' for the most recent Home Approval
select pa.provider_approval_id, pa.active_sw, pa	.update_ts, pa.update_user_id
	from prov.tb_provider_approval pa
where pa.provider_id = 5055808
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
set pa2.active_sw = 'Y',
	pa2.update_ts = now(),
	pa2.update_user_id = 'CDM-23110'
where pa2.provider_approval_id 
	in (	select pa.provider_approval_id
				from prov.tb_provider_approval pa
			where pa.provider_id = 5055808
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
