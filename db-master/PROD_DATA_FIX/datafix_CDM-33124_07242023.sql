-- CDM-33124 - Subsidy payment
/*
--	Issue Description: 
	User reuest to delete the duplicate Adoption subsidy rate slab
    
-- Adoption Case ID: 3278879
-- Client ID: 4116117 (FINALE LEE BOWMAN) - 19407f43-428f-43ad-964c-c3ebe6f026ad
-- provider ID: 5085346	(Ernestine Bowman)
-- Adoption ID: 47544 - 2017-07-07 To 2027-08-21 - 2470fb0f-869a-4037-a8ab-891df55c128f
-- Rates
-- Delete - 229b4184-1d36-4cf7-9f98-3f0a4d9f3957	2022-07-07	2023-07-06	1521.00

-- Category/ Module: Adoption Subsidy (Case Management) 
-- Root cause: User error 
--			   Code fix was done with the Clone ticket # CDM-33137 to prevent the duplicate rate slab creation.
-- Fix Provided: Datafix has been promoted to delete the duplicate Adoption subsidy rate slab.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To delete the duplicate Adoption subsidy rate slab (CDM-33124)
-- Rate ID: - 229b4184-1d36-4cf7-9f98-3f0a4d9f3957	2022-07-07	2023-07-06	1521.00

select provider_id, startdate, enddate, paymentamout, updatedby, updatedon, activeflag
	from adoptioncaserevision
where adoptionagreementrateid = '229b4184-1d36-4cf7-9f98-3f0a4d9f3957'
	and activeflag = 1 ;

update adoptioncaserevision
set activeflag = 0,
	updatedby = 'CDM-33124',
	updatedon = now()
where adoptionagreementrateid = '229b4184-1d36-4cf7-9f98-3f0a4d9f3957' 
	and activeflag = 1 ;

select provider_id, startdate, enddate, paymentamout, updatedby, updatedon, activeflag
	from adoptioncaseagreementrate
where adoptionagreementrateid = '229b4184-1d36-4cf7-9f98-3f0a4d9f3957'
	and activeflag = 1;

update adoptioncaseagreementrate
set activeflag = 0,
	updatedby = 'CDM-33124',
	updatedon = now()
where adoptionagreementrateid = '229b4184-1d36-4cf7-9f98-3f0a4d9f3957'
	and activeflag = 1;

select routingid, eventcode, routingstatustypeid, activeflag, updatedby, updatedon
	from routing
where objectid = '229b4184-1d36-4cf7-9f98-3f0a4d9f3957'
	and eventcode = 'AARR' -- Adoption Agreement Rate Review
	and activeflag = 1 ;

update routing
set activeflag = 0,
	updatedby = 'CDM-33124',
	updatedon = now()
where objectid = '229b4184-1d36-4cf7-9f98-3f0a4d9f3957'
	and eventcode = 'AARR' -- Adoption Agreement Rate Review
	and activeflag = 1 ;

-- To Trigger Under Over batch 
-- 04c14eaf-f5f2-4567-b8f7-502c0cd30c95	2023-07-07	2024-07-06	1521.48
-- 58ce97ad-9e9b-41aa-91c6-f3b314f25f6b	2022-07-07	2023-07-06	1521.48

select startdate, enddate, paymentamout, status, updatedby, updatedon
	from adoptioncaseagreementrate
where adoptionagreementrateid  in ( '04c14eaf-f5f2-4567-b8f7-502c0cd30c95', '58ce97ad-9e9b-41aa-91c6-f3b314f25f6b' )
  and activeflag = 1 ;

update adoptioncaseagreementrate
set updatedon = now(), 
	updatedby = 'CDM-33124'
where adoptionagreementrateid  in ( '04c14eaf-f5f2-4567-b8f7-502c0cd30c95', '58ce97ad-9e9b-41aa-91c6-f3b314f25f6b' )
  and activeflag = 1 ;
