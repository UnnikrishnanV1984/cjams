-- CDM-23097 - Provider not Populating
/*
-- Issue Description: 
	Linda Wilkerson #5013138 is not populating under the Application to open up a GAP under the permanency plan. 

-- Case ID: 3230006
-- Client ID: 3738912 (SEBASTIAN ALCUARD JONES) - 4bf5ab19-a258-44b4-bdb1-213d374f4b87
-- Provider ID: 5013138	(Linda Wilkerson) - Local Department Home
	   
-- Category/ Module: GAP Application (Case Management)
-- Root cause: Provider Home Approval Data issue
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update the active_sw  = 'Y' for the most recent Home Approval
select pa.provider_approval_id, pa.active_sw, pa	.update_ts, pa.update_user_id
	from prov.tb_provider_approval pa
where pa.provider_id = 5013138
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
	pa2.update_user_id = 'CDM-23097'
where pa2.provider_approval_id 
	in (	select pa.provider_approval_id
				from prov.tb_provider_approval pa
			where pa.provider_id = 5013138
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
