-- CIDM-9189 - CDM-40356 - Provider switched too soon
/*
-- Issue Description: 
   Adoption subsidy rate dates need adjusting

-- Adoption Case ID: 3283395
-- Adoption ID: 48157 - 2024-07-01 To 2034-08-31 - 02d4a371-d0bf-492e-9c30-e97c9b9f7607
-- Client ID: 4177058 (WILLOW EVERLYKAYE CLEARY	) - b4c93566-0f60-4917-aed1-ed5e1c573303
-- New Provider ID: 6145512	( Bradley David-lee Cleary)
-- Old Provider ID: 5083354	(Joshua Cleary)
  
-- Category/ Module: Adoption Subsidy (Finance Management) 
-- Root cause: User error, provider switch was done on the adoption case in CJAMs with wrong start date. 
-- Fix Provided: Datafix has been promoted to fix the Adoption Case Data for fiscal adjustments. 
	             Switch the adoption agreement to the New Provider and get the latest rate slab back in CJAMS.
-- Regression Impacts: N/A
-- Is Code fix Required?: No
--    Code fix ticket#: N/A
--    Reason why no related code fix: This was a user error and can be avoided in the future by doing the provider switch in CJAMS with correct dates.
--    Pull request# N/A 
*/

-- To update Adoption Case with New provider (CIDM-9189) 

-- Switch the adoption agreement to the New Provider ID 6145512 (Bradley David-lee Cleary) 
-- update the switch effective date from 06/01/2024 to 06/30/2024.

update adoptioncaseagreement 
set providerid = 6145512, 
	parent1providerid = 6145512, 
	parent1providername = 'Bradley Cleary',
	parent2providerid = 6145512, 
	parent2providername = 'Joshua Cleary',
	-- issingleparent = NULL,
	effectiveswitchdate  = '2024-06-30 04:00:00',
	updatedby = 'CIDM-9189',
	updatedon = now() 
where adoptioncaseid = '02d4a371-d0bf-492e-9c30-e97c9b9f7607'
	and activeflag  = 1 ;
	
-- Bring back rate slab 
-- 6145512	2024-07-01	2024-11-13 - f3351402-4e0b-46b5-90fa-45171b760ced
update adoptioncaseagreementrate
set activeflag = 1,
 	updatedon = now(), 
	updatedby = 'CIDM-9189'
where adoptionagreementid = 'cddb67a1-4930-4225-b9b4-02787fcf99c6'
	and adoptionagreementrateid = 'f3351402-4e0b-46b5-90fa-45171b760ced'
	and updatedby = 'CDM-40356'
	and activeflag = 0 ;

update adoptioncaserevision
set activeflag = 1,
 	updatedon = now(), 
	updatedby = 'CIDM-9189'
where adoptionagreementid = 'cddb67a1-4930-4225-b9b4-02787fcf99c6'
	and adoptionagreementrateid = 'f3351402-4e0b-46b5-90fa-45171b760ced'
	and updatedby = 'CDM-40356'
	and activeflag = 0 ;


