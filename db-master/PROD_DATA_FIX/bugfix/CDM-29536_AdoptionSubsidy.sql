 -- CDM-29536 - Adoption Subsidy
/*
-- Issue Description: 
   To update Provider Info on the Adoption Case and generate the missign payments

-- Adoption Case ID: 3291200
-- Client ID: 4268346 (TAILIYAH KAISER) - dfa9a10f-fb63-4ff5-864d-08de57677fbe
-- Provider ID: 5030707 (Jennifer Harless-smith) - Local Department Home
-- Adoption ID: 37288 - 2013-06-28 To 2025-09-28 - d5f04840-51fb-4d56-8b78-0da22269a680

-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: Data issue on the Provider mudule side, No Home apporval with Active Switch 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update -- Provider ID: 5030707 (Ryan  Kaiser) - Local Department Home
-- 240080	3610		Ryan  Kaiser - Applicant
-- 240081	3611		Lauren  Kaiser  - Co-Applicant

select providerid, parent1providerid, parent1providername, parent2providerid, parent2providername, 
	issingleparent, updatedby, updatedon 
from adoptioncaseagreement 
where adoptioncaseid = 'd5f04840-51fb-4d56-8b78-0da22269a680' and adoptionagreementid = 'de077406-2295-4a84-a3db-872ea2a8eb99'
	and activeflag  = 1 ;

update adoptioncaseagreement 
set providerid = 5030707, 
	parent1providerid = 5030707, 
	parent1providername = 'Ryan  Kaiser', 
	parent2providerid = 5030707,  
	parent2providername = 'Lauren  Kaiser', 
	-- issingleparent = NULL,
	updatedby = 'CDM-29536',
	updatedon = now()
where adoptioncaseid = 'd5f04840-51fb-4d56-8b78-0da22269a680' and adoptionagreementid = 'de077406-2295-4a84-a3db-872ea2a8eb99'
	and activeflag  = 1 ;
	

select provider_id, startdate, enddate, approvaldate, paymentamout, updatedby, updatedon
	from adoptioncaseagreementrate
where adoptionagreementid = 'de077406-2295-4a84-a3db-872ea2a8eb99'
	and adoptionagreementrateid 
		in ('f6d3948e-ac2c-47de-a396-2d6e1c81a1cd', '0e9786c2-5007-4f54-ac4b-b348c1a4fb63')
	and activeflag = 1 ;

update adoptioncaseagreementrate
set provider_id = 5030707,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-29536'
where adoptionagreementid = 'de077406-2295-4a84-a3db-872ea2a8eb99'
	and adoptionagreementrateid 
		in ('70c39413-920d-4942-b444-3820f9ca6cf1')
	and activeflag = 1 ;

-- Trigger Under/Over
select adoptionrevisionid, provider_id, startdate, enddate, approvaldate, 
		paymentamout, updatedby, updatedon 
	from adoptioncaserevision
where adoptionagreementid = 'de077406-2295-4a84-a3db-872ea2a8eb99'
 	and adoptionagreementrateid 
		in ('70c39413-920d-4942-b444-3820f9ca6cf1')
	and approvaldate is not null
	and activeflag = 1 ;

update adoptioncaserevision
set provider_id = 5030707,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-29536'
where adoptionagreementid = 'de077406-2295-4a84-a3db-872ea2a8eb99'
 	and adoptionagreementrateid 
		in ('70c39413-920d-4942-b444-3820f9ca6cf1')
	and approvaldate is not null
	and activeflag = 1 ;

-- Update the active_sw  = 'Y' for the most recent Home Approval
select pa.provider_approval_id, pa.active_sw, pa.update_ts, pa.update_user_id
	from prov.tb_provider_approval pa
where pa.provider_id = 5030707
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
	update_user_id = 'CDM-29536'
where pa2.provider_approval_id 
	in (	select pa.provider_approval_id
				from prov.tb_provider_approval pa
			where pa.provider_id = 5030707
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
