-- CDM-26164 - Provider ID missng
/*
-- Issue Description: 
   To update Provider Info on the Adoption Case
      
-- Adoption Case ID: 3086372
-- Client ID: 1486195 (TYREESE JOEL SAVAGE) - 1e6c98e9-8eb7-470f-b623-834a9e8434b4
-- Provider ID: 5008139 (Joann Savage) - Local Department Home
-- Adoption ID: 7163 - 2006-04-06 To 2023-10-14 - 30e4466b-4c85-4ce0-a0b1-98bcce23980f

-- Category/ Module: Adoption (Case Management) 
-- Root cause: Provider record is migarted data and having no info on Home Approval  
-- Fix Provided: Datafix has been promoted to update the provider info on Adoption Agreement & Rate screen 
-- 				 and to trigger the under/over batch for generating the missing Oct & Nov 2022 payments.  
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update Provider ID: 5008139 (Joann Savage) - Local Department Home
select providerid, parent1providerid, parent1providername, parent2providerid, parent2providername, 
	issingleparent, updatedby, updatedon 
from adoptioncaseagreement 
where adoptioncaseid = '30e4466b-4c85-4ce0-a0b1-98bcce23980f'
	and activeflag  = 1 ;

update adoptioncaseagreement 
set providerid = 5008139, 
	parent1providerid = 5008139, 
	parent1providername = 'Joann Savage', 
	-- parent2providerid = NULL,  
	-- parent2providername = NULL, 
	-- issingleparent = NULL,
	updatedby = 'CDM-26164',
	updatedon = now()
where adoptioncaseid = '30e4466b-4c85-4ce0-a0b1-98bcce23980f'
	and activeflag  = 1 ;
	
-- Update Provider ID as 5008139
select provider_id, startdate, enddate, approvaldate, paymentamout, updatedby, updatedon
	from adoptioncaseagreementrate
where adoptionagreementid = '7417f881-4962-4305-b658-d1b0f72d1e2a'
	and adoptionagreementrateid = '2ac7ec65-ba55-4df3-a4ee-0205e4536f27'
	and activeflag = 1 ;

update adoptioncaseagreementrate
set provider_id = 5008139,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-26164'
where adoptionagreementid = '7417f881-4962-4305-b658-d1b0f72d1e2a'
	and adoptionagreementrateid = '2ac7ec65-ba55-4df3-a4ee-0205e4536f27'
	and activeflag = 1 ;

select adoptionrevisionid, provider_id, startdate, enddate, approvaldate, 
		paymentamout, updatedby, updatedon 
	from adoptioncaserevision
where adoptionagreementid = '7417f881-4962-4305-b658-d1b0f72d1e2a'
	and adoptionagreementrateid = '2ac7ec65-ba55-4df3-a4ee-0205e4536f27';

update adoptioncaserevision
set provider_id = 5008139,
	updatedon = now(), 
	updatedby = 'CDM-26164'
where adoptionagreementid = '7417f881-4962-4305-b658-d1b0f72d1e2a'
	and adoptionagreementrateid = '2ac7ec65-ba55-4df3-a4ee-0205e4536f27';

update adoptioncaserevision
set provider_id = 5008139,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-26164'
where adoptionagreementid = '7417f881-4962-4305-b658-d1b0f72d1e2a'
	and adoptionagreementrateid = '2ac7ec65-ba55-4df3-a4ee-0205e4536f27'
	and approvaldate is not null
	and activeflag = 1 ;
