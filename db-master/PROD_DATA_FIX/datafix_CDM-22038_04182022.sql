-- CDM-22038 - Child still showing in prior placement
/*
-- Issue Description: 
	Provider # 5005277 vacancy issue 	
	
-- Category/ Module: Placement (Case Management) 
-- Root cause: TBD
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Provider ID: 5005277	(SUSAN LINDAUERE) - Local Department Home
-- Before
select pr.provider_id, pr.vacancy_no, pr.update_user_id, pr.update_ts
	, (	select pa.approved_beds_no
			from prov.tb_provider_approval pa
		where pa.provider_id = pr.provider_id
			and pa.delete_sw = 'N'
		order by pa.provider_approval_id desc
		limit 1
	) as approved_beds
	, ( select count(*)
			from cjams.tb_placement pl  
		where pl.delete_sw = 'N'
			and pl.entry_dt is not null
			and pl.exit_dt is null
			and coalesce(pl.void_sw, 'N') <> 'Y' 
			and pl.approval_status_cd = '3047'
			and pl.provider_id = pr.provider_id
	) as active_placement
from prov.tb_provider pr
where pr.provider_id = 5005277
	and pr.delete_sw = 'N' ;

-- Update
update prov.tb_provider pr
set pr.update_ts = now(),
	pr.update_user_id = 'CDM-22038',
	pr.vacancy_no = (
					(	select pa.approved_beds_no
							from prov.tb_provider_approval pa
						where pa.provider_id = pr.provider_id
							and pa.delete_sw = 'N'
						order by pa.provider_approval_id desc
						limit 1
					)
					-
					( select count(*)
							from cjams.tb_placement pl  
					  where pl.delete_sw = 'N'
						and pl.entry_dt is not null
						and pl.exit_dt is null
						and coalesce(pl.void_sw, 'N') <> 'Y' 
						and pl.approval_status_cd = '3047'
						and pl.provider_id = pr.provider_id
					)
				 )
where pr.provider_id = 5005277
	and pr.delete_sw = 'N' ;

-- After
select pr.provider_id, pr.vacancy_no, pr.update_user_id, pr.update_ts
	from prov.tb_provider pr
where pr.provider_id = 5005277
	and pr.delete_sw = 'N' ;