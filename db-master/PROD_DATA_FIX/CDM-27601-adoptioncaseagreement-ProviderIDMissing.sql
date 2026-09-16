-- CDM-27601-Provider ID missing
/*
File Name: CDM-27601-adoptioncaseagreement-ProviderIDMissing
-- Issue Description: 
   For the Case ID: 3085841:Provider ID is 5008122 is missing from most recent Subsidy renewal 
-- Resolution: Updated the providerid in adoptioncaseagreement, adoptioncaseagreementrate adoptioncaseagreementrate table

-- Category/ Module: Adoption (Case Management) 
-- Root cause: Provider record is migarted data and having no info on Home Approval  
-- Fix Provided: Datafix has been promoted to update the provider info on Adoption Agreement & Rate screen 
-- 				 and to trigger the under/over batch for generating the missing Oct & Nov 2022 payments.  
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select
	providerid,
	parent1providerid,
	parent1providername,
	parent2providerid,
	parent2providername,
	issingleparent,
	updatedby,
	updatedon
from
	adoptioncaseagreement
where
	adoptioncaseid = '78c931a0-9dc0-4075-bb8c-9dc0877209b5'
	and activeflag = 1 ;



update
	adoptioncaseagreement
set
	providerid = 5008122,
	parent1providerid = 5008122,
	parent1providername = 'Grace Brockmeyer',
	updatedby = 'CDM-27601',
	updatedon = now()
where
	adoptioncaseid = '78c931a0-9dc0-4075-bb8c-9dc0877209b5'
	and activeflag = 1 ;

update
	adoptioncaseagreementrate
set
	provider_id = 5008122,
	approvaldate = now(),
	updatedon = now(),
	updatedby = 'CDM-27601'
where
	adoptionagreementid = '30c59f22-f8ca-4f49-b466-5ced3ef13dff'
	and adoptionagreementrateid = 'a37c6dbf-5da1-45d4-adae-9c86e7250853'
	and activeflag = 1 ;

update
	adoptioncaserevision
set
	provider_id = 5008122,
	updatedon = now(),
	updatedby = 'CDM-27601'
where
	adoptionagreementid = '30c59f22-f8ca-4f49-b466-5ced3ef13dff'
	and adoptionagreementrateid = 'a37c6dbf-5da1-45d4-adae-9c86e7250853';

update
	adoptioncaserevision
set
	provider_id = 5008122,
	approvaldate = now(),
	updatedon = now(),
	updatedby = 'CDM-27601'
where
	adoptionagreementid = '30c59f22-f8ca-4f49-b466-5ced3ef13dff'
	and adoptionagreementrateid = 'a37c6dbf-5da1-45d4-adae-9c86e7250853'
	and approvaldate is not null
	and activeflag = 1 ;
