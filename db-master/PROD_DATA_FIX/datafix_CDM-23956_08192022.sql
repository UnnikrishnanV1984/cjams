-- CDM-23956 - Missing Provider
/*
-- Issue Description: 
   To update Provider Info on the Adoption Case
      
-- Case ID: 3261028
-- Client ID: 3883827 (BOBBY L HOWE) - ed64fc54-0e22-4b4e-b030-cb5da08c17e1
-- Adoption ID: 44781 - 2015-11-19 To 2025-08-23 - 61b90c97-1f4a-459c-abc7-9da9ab471602
-- Provider ID: 5069275 (Stacey Howe)

-- Category/ Module: Adoption (Case Management) 
-- Root cause: TDB 
-- Pull request# TBD 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- Update -- Provider ID: 5069275 (Stacey Howe) - Local Department Home
-- 3610		Stacey	Lee		Howe (235078)
-- 3611		Bryce	Eric	Howe (235079)

select providerid, parent1providerid, parent1providername, parent2providerid, parent2providername, 
	issingleparent, updatedby, updatedon 
from adoptioncaseagreement 
where adoptioncaseid = '61b90c97-1f4a-459c-abc7-9da9ab471602'
	and activeflag  = 1 ;

update adoptioncaseagreement 
set providerid = 5069275, 
	parent1providerid = 5069275, 
	parent1providername = 'Stacey Lee Howe', 
	parent2providerid = 5069275,  
	parent2providername = 'Bryce Eric Howe', 
	issingleparent = 0,
	updatedby = 'CDM-23956',
	updatedon = now()
where adoptioncaseid = '61b90c97-1f4a-459c-abc7-9da9ab471602'
	and activeflag  = 1 ;
	
-- Update Provider ID as 5069275
select provider_id, startdate, enddate, approvaldate, paymentamout, updatedby, updatedon
	from adoptioncaseagreementrate
where adoptionagreementid = 'efe228e7-77fe-4edc-8741-66c636796e3f'
	and adoptionagreementrateid = 'acdc7ba8-c7bd-43ce-81ba-043bd7b99024'
	and activeflag = 1 ;

update adoptioncaseagreementrate
set provider_id = 5069275,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-23956'
where adoptionagreementid = 'efe228e7-77fe-4edc-8741-66c636796e3f'
	and adoptionagreementrateid = 'acdc7ba8-c7bd-43ce-81ba-043bd7b99024'
	and activeflag = 1 ;

select adoptionrevisionid, provider_id, startdate, enddate, approvaldate, 
		paymentamout, updatedby, updatedon 
	from adoptioncaserevision
where adoptionagreementid = 'efe228e7-77fe-4edc-8741-66c636796e3f'
	and adoptionagreementrateid = 'acdc7ba8-c7bd-43ce-81ba-043bd7b99024' ;

update adoptioncaserevision
set provider_id = 5069275,
	updatedon = now(), 
	updatedby = 'CDM-23956'
where adoptionagreementid = 'efe228e7-77fe-4edc-8741-66c636796e3f'
	and adoptionagreementrateid = 'acdc7ba8-c7bd-43ce-81ba-043bd7b99024' ;

update adoptioncaserevision
set provider_id = 5069275,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-23956'
where adoptionagreementid = 'efe228e7-77fe-4edc-8741-66c636796e3f'
	and adoptionagreementrateid = 'acdc7ba8-c7bd-43ce-81ba-043bd7b99024'
	and approvaldate is not null
	and activeflag = 1 ;


-- Update the active_sw  = 'Y' for the most recent Home Approval
select pa.provider_approval_id, pa.active_sw, pa	.update_ts, pa.update_user_id
	from prov.tb_provider_approval pa
where pa.provider_id = 5069275
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
	pa2.update_user_id = 'CDM-23956'
where pa2.provider_approval_id 
	in (	select pa.provider_approval_id
				from prov.tb_provider_approval pa
			where pa.provider_id = 5069275
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
