-- CIDM-8939 - Adoption Subsidy Rate Adjustment
/*
-- Issue Description: 
   Adoption subsidy rate dates need adjusting

-- Case ID: 3225346 - brad.wofford@montgomerycountymd.gov - nathaniel.parks@montgomerycountymd.gov
-- Adoption ID: 37228 - 06/26/2013 To 04/23/2029 - f0ef9631-d992-49aa-9ff8-2b5b2734f7a2
-- Client ID: 3537928 (BAUTISTA TRIGO NAVARRO) - e9ef9d54-308c-44ce-be1e-8b509496806a
-- New  Provider ID: 6114248 (Alberto Trigo)
-- Old Provider ID: 5038235	(Ana Navarro) 
   
-- Category/ Module: Adoption Subsidy (Finance Management) 
-- Root cause: User error 
-- Fix Provided: Datafix has been promoted to fix the Adoption Case Data for fiscal adjustments. 
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To update Adoption Case Data for fiscal adjustments (CIDM-8939) 
-- 7. Once the AR generated, provider ID in the subsidy agreement need to be changed to the new provider
update adoptioncaseagreement 
set providerid = NULL, 
	parent1providerid = 6114248,
	parent1providername = 'Alberto Trigo',
	-- parent2providerid = NULL,  
	-- parent2providername = NULL, 
	-- issingleparent = NULL,
	updatedby = 'CIDM-8939',
	updatedon = now()
where adoptioncaseid = 'f0ef9631-d992-49aa-9ff8-2b5b2734f7a2'
	and activeflag  = 1 ;


-- 8. the current subsidy rate slab need to be changed to the new provider ID
-- 6114248	2024-04-01	2024-06-30	37228	17742251-83a2-497b-a0cc-b93117efcfe5
-- New start date  02/01/2024

update adoptioncaseagreementrate
set provider_id = 6114248,
	-- startdate = '2024-02-01 04:00:00.000',
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-39135'
where adoptionagreementid = 'fa4b8c9c-e7f8-493f-8055-706acfece986'
	and adoptionagreementrateid = '17742251-83a2-497b-a0cc-b93117efcfe5'
	and activeflag = 1 ;

update adoptioncaserevision
set provider_id = 6114248,
	-- startdate = '2024-02-01 04:00:00.000',
	updatedon = now(), 
	updatedby = 'CDM-39135'
where adoptionagreementid = 'fa4b8c9c-e7f8-493f-8055-706acfece986'
	and adoptionagreementrateid = '17742251-83a2-497b-a0cc-b93117efcfe5' ;
	
	
-- 9. Remove/delete the suspension
delete from cjams.routing where routingid = 'bf9c8c11-be1e-4744-8593-7c5062dab5a5';
delete from cjams.routing where routingid = '3d2f7a12-c482-4055-ac0c-fdce491f41bd';
delete from cjams.routing where routingid = 'c160c1a9-4245-43f7-a7f6-395c5ea7462c' ;

delete from cjams.adoptioncasesuspensionrevision where adoptionsuspensionrevisionid = '15d62f2c-c021-4650-930e-687d84fe23dc';
delete from cjams.adoptioncasesuspensionrevision where adoptionsuspensionrevisionid = 'fd8e7c54-8c9b-4129-964a-b4de2d5a6032';

delete from cjams.adoptioncasesuspension where adoptionsuspensionid = '9be6e7fd-be89-46de-b671-a735740561a7';
delete from cjams.adoptioncasesuspension where adoptionsuspensionid = '71a9a29f-552d-4f52-9705-ad39e42d5edf';


