-- CDM-40356 - Provider switched too soon
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
-- Regression Impacts: N/A
-- Is Code fix Required?: No
--    Code fix ticket#: N/A
--    Reason why no related code fix: This was a user error and can be avoided in the future by doing the provider switch in CJAMS with correct dates.
--    Pull request# N/A 
*/

-- To update Adoption Case Data for fiscal adjustments (CDM-40356) 

-- Subsidy agreement need to revert to old provider

-- Update provider id as Old Provider ID: 5083354 (Joshua Cleary)
-- Adoption ID: 48157 - 2024-07-01 To 2034-08-31 - 02d4a371-d0bf-492e-9c30-e97c9b9f7607

update adoptioncaseagreement 
set providerid = 5083354, -- NULL
	parent1providerid = 5083354, -- 6145512
	parent1providername = 'Joshua Cleary', -- 'Bradley Cleary'
	parent2providerid = NULL, -- '6145512' 
	parent2providername = NULL, -- 'Joshua Cleary'
	-- issingleparent = NULL,
	updatedby = 'CDM-40356', -- '47194b3d-bf52-416c-a53b-82888c49d6a2'
	updatedon = now() -- '2024-07-18 15:50:12'
where adoptioncaseid = '02d4a371-d0bf-492e-9c30-e97c9b9f7607'
	and activeflag  = 1 ;
	
-- Delete rate slab 
-- 6145512	2024-07-01	2024-11-13 - f3351402-4e0b-46b5-90fa-45171b760ced
update adoptioncaseagreementrate
set activeflag = 0,
 	updatedon = now(), 
	updatedby = 'CDM-40356'
where adoptionagreementid = 'cddb67a1-4930-4225-b9b4-02787fcf99c6'
	and adoptionagreementrateid = 'f3351402-4e0b-46b5-90fa-45171b760ced'
	and activeflag = 1 ;


update adoptioncaserevision
set activeflag = 0,
 	updatedon = now(), 
	updatedby = 'CDM-40356'
where adoptionagreementid = 'cddb67a1-4930-4225-b9b4-02787fcf99c6'
	and adoptionagreementrateid = 'f3351402-4e0b-46b5-90fa-45171b760ced'
	and activeflag = 1 ;


-- update provider id  as 5083354 and Trigger under over
-- 6145512	2023-11-14	2024-06-30 - cd6f14f4-abb3-4c60-ab01-39d4a08bd335
update adoptioncaseagreementrate
set provider_id = 5083354, -- 6145512
	approvaldate = now(), -- To Trigger under/over
	updatedon = now(), 
	updatedby = 'CDM-40356'
where adoptionagreementid = 'cddb67a1-4930-4225-b9b4-02787fcf99c6'
	and adoptionagreementrateid = 'cd6f14f4-abb3-4c60-ab01-39d4a08bd335'
	and activeflag = 1 ;

update adoptioncaserevision
set provider_id = 5083354,
	updatedon = now(), 
	updatedby = 'CDM-40356'
where adoptionagreementid = 'fa4b8c9c-e7f8-493f-8055-706acfece986'
	and adoptionagreementrateid = '17742251-83a2-497b-a0cc-b93117efcfe5' 
	and provider_id <> 5083354;
	

-- Delete all suspnesions
/*
d1588979-b06c-4689-a066-cbda7e04ab40	2024-06-01 04:00:00	2024-06-01 04:00:00
b30e48a5-9321-487a-a85b-34f18fb9c5b9	2024-06-30 04:00:00	2024-06-30 04:00:00
5f1893dc-cdac-4fab-a757-779fd74f0eeb	2024-06-01 04:00:00	 
*/
update cjams.adoptioncasesuspension
set	activeflag = 0,
 	updatedon = now(), 
	updatedby = 'CDM-40356'
where adoptionsuspensionid 
	in (	'd1588979-b06c-4689-a066-cbda7e04ab40',
			'b30e48a5-9321-487a-a85b-34f18fb9c5b9',
			'5f1893dc-cdac-4fab-a757-779fd74f0eeb'
		)
	and activeflag = 1;


update  cjams.adoptioncasesuspensionrevision
set	activeflag = 0,
 	updatedon = now(), 
	updatedby = 'CDM-40356'
where adoptionsuspensionid 
	in (	'd1588979-b06c-4689-a066-cbda7e04ab40',
			'b30e48a5-9321-487a-a85b-34f18fb9c5b9',
			'5f1893dc-cdac-4fab-a757-779fd74f0eeb'
		)
	and activeflag = 1;
	
update cjams.routing
set	activeflag = 0,
 	updatedon = now(), 
	updatedby = 'CDM-40356'
where eventcode = 'ADSR'
	and objectid 
	in (	'd1588979-b06c-4689-a066-cbda7e04ab40',
			'b30e48a5-9321-487a-a85b-34f18fb9c5b9',
			'5f1893dc-cdac-4fab-a757-779fd74f0eeb'
		)
	and activeflag = 1;
	