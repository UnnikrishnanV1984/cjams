/*
File Name: CDM-43270 - adoption subsidy/provider change
-- Issue Description: 
   For the Case ID: 3085841:Provider ID is 5008122 is missing from most recent Subsidy renewal 
-- Resolution: Updated the providerid in adoptioncaseagreement, adoptioncaseagreementrate adoptioncaseagreementrate table

-- Category/ Module: Adoption (Case Management) 
-- Root cause:Please proceed with the data fix to switch the adopted parent from provider ID # 5082032 (Timothy Shawyer) to provider ID # 5017646 (Rochele Shawyer) in the adoption agreement.
-- Fix Provided: Datafix has been promoted to update the provider info on Adoption Agreement & Rate screen 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/





update adoptioncaseagreement 
set providerid = 5017646, 
	parent2providerid = null,
	parent1providerid = 5017646, 
	parent1providername = 'Rochele Shawyer', 
	updatedby = 'CDM-43270',
	updatedon = now()
where adoptioncaseid = '0af51ce1-e44e-42a9-8646-7fd01b0d37b3'
	and activeflag  = 1 ;
