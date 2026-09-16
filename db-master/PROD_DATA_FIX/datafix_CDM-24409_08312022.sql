-- CDM-24409 - Adoption Subsidy case with no provider name
/*
-- Issue Description: 
   To update Provider Info on the Adoption Case
      
-- Case ID: 3086438
-- Client ID: 1492251 (SYDNIE CLAIRE SAUMENIG) - 194edae7-2c12-4705-a87d-2e7a33432b93
-- Provider ID: 5007609 (Pamela Saumenig)
-- Adoption ID: 7229 - 2005-10-27 To 2025-07-18 - ff9bb4b9-1833-4255-a4fa-4d183f4b3efa

-- Category/ Module: Adoption (Case Management) 
-- Root cause: TDB 
-- Pull request# TBD 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- Update Provider ID: 5007609 (Pamela Saumenig)- Local Department Home
select providerid, parent1providerid, parent1providername, parent2providerid, parent2providername, 
	issingleparent, updatedby, updatedon 
from adoptioncaseagreement 
where adoptioncaseid = 'ff9bb4b9-1833-4255-a4fa-4d183f4b3efa'
	and activeflag  = 1 ;

update adoptioncaseagreement 
set providerid = 5007609, 
	parent1providerid = 5007609, 
	parent1providername = 'Pamela Saumenig', 
	-- parent2providerid = NULL,  
	-- parent2providername = NULL, 
	-- issingleparent = NULL,
	updatedby = 'CDM-24409',
	updatedon = now()
where adoptioncaseid = 'ff9bb4b9-1833-4255-a4fa-4d183f4b3efa'
	and activeflag  = 1 ;
	
-- Update Provider ID as 5007609
select provider_id, startdate, enddate, approvaldate, paymentamout, updatedby, updatedon
	from adoptioncaseagreementrate
where adoptionagreementid = 'cda93437-9604-4392-b5fb-8112acd6e9be'
	and adoptionagreementrateid = '63d00e44-2100-4332-a6d6-d273a0934632'
	and activeflag = 1 ;

update adoptioncaseagreementrate
set provider_id = 5007609,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-24409'
where adoptionagreementid = 'cda93437-9604-4392-b5fb-8112acd6e9be'
	and adoptionagreementrateid = '63d00e44-2100-4332-a6d6-d273a0934632'
	and activeflag = 1 ;

select adoptionrevisionid, provider_id, startdate, enddate, approvaldate, 
		paymentamout, updatedby, updatedon 
	from adoptioncaserevision
where adoptionagreementid = 'cda93437-9604-4392-b5fb-8112acd6e9be'
	and adoptionagreementrateid = '63d00e44-2100-4332-a6d6-d273a0934632' ;

update adoptioncaserevision
set provider_id = 5007609,
	updatedon = now(), 
	updatedby = 'CDM-24409'
where adoptionagreementid = 'cda93437-9604-4392-b5fb-8112acd6e9be'
	and adoptionagreementrateid = '63d00e44-2100-4332-a6d6-d273a0934632' ;

update adoptioncaserevision
set provider_id = 5007609,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-24409'
where adoptionagreementid = 'cda93437-9604-4392-b5fb-8112acd6e9be'
	and adoptionagreementrateid = '63d00e44-2100-4332-a6d6-d273a0934632'
	and approvaldate is not null
	and activeflag = 1 ;
