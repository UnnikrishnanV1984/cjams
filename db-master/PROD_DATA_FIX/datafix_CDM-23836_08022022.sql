-- CDM-23836 - Subsidy payment missing
/*
-- Issue Description: 
   To update Provider Info on the Adoption Case
      
-- Adoption Case ID: 3143807 - brad.wofford@montgomerycountymd.gov
-- Client ID: 1820856 (PATRICK MARKS) - 4c046342-45f4-4e5f-9002-1dca1d243aef
-- Adoption ID: 14357 - 2007-07-01 To 2025-07-14 - 5271dc45-2ae9-4ab8-b56c-aeac6dd81669
-- Provider ID: 5008753	(Patricia Marks)

-- Category/ Module: Adoption (Case Management) 
-- Root cause: TDB 
-- Pull request# TBD 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- Update -- Provider ID: 5008753	(Patricia Marks) - Local Department Home
select providerid, parent1providerid, parent1providername, parent2providerid, parent2providername, 
	issingleparent, updatedby, updatedon 
from adoptioncaseagreement 
where adoptioncaseid = '5271dc45-2ae9-4ab8-b56c-aeac6dd81669'
	and activeflag  = 1 ;

update adoptioncaseagreement 
set providerid = 5008753, 
	parent1providerid = 5008753, 
	parent1providername = 'Patricia Marks', 
	-- parent2providerid = NULL,  
	-- parent2providername = NULL, 
	-- issingleparent = NULL,
	updatedby = 'CDM-23836',
	updatedon = now()
where adoptioncaseid = '5271dc45-2ae9-4ab8-b56c-aeac6dd81669'
	and activeflag  = 1 ;
	
-- Update Provider ID as 5008753
select provider_id, startdate, enddate, approvaldate, paymentamout, updatedby, updatedon
	from adoptioncaseagreementrate
where adoptionagreementid = 'bbacf86e-654e-4f24-8d8f-55c5d16b726a'
	and adoptionagreementrateid = '38150ebf-74bb-4abe-9025-12a689aa4acf'
	and activeflag = 1 ;

update adoptioncaseagreementrate
set provider_id = 5008753,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-23836'
where adoptionagreementid = 'bbacf86e-654e-4f24-8d8f-55c5d16b726a'
	and adoptionagreementrateid = '38150ebf-74bb-4abe-9025-12a689aa4acf'
	and activeflag = 1 ;

select adoptionrevisionid, provider_id, startdate, enddate, approvaldate, 
		paymentamout, updatedby, updatedon 
	from adoptioncaserevision
where adoptionagreementid = 'bbacf86e-654e-4f24-8d8f-55c5d16b726a'
	and adoptionagreementrateid = '38150ebf-74bb-4abe-9025-12a689aa4acf' ;

update adoptioncaserevision
set provider_id = 5008753,
	updatedon = now(), 
	updatedby = 'CDM-23836'
where adoptionagreementid = 'bbacf86e-654e-4f24-8d8f-55c5d16b726a'
	and adoptionagreementrateid = '38150ebf-74bb-4abe-9025-12a689aa4acf' ;

update adoptioncaserevision
set provider_id = 5008753,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-23836'
where adoptionagreementid = 'bbacf86e-654e-4f24-8d8f-55c5d16b726a'
	and adoptionagreementrateid = '38150ebf-74bb-4abe-9025-12a689aa4acf'
	and approvaldate is not null
	and activeflag = 1 ;
