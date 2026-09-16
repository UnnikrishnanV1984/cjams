-- CDM-33045 - Correction Needed -End Rate
/*
--	Issue Description: 
	User reuest to updare the Adoption Rate end date as 08/20/2024.
    
-- Adoption Case ID: 202102005506
-- Client ID: 200308316 (VERNINA ANN Mendoza) - d495d533-51a4-4c1b-b738-f0fb8086df70
-- Adoption ID: 1051023 - 2020-08-21 To 2024-09-25 - 8fc1e09c-a31d-46d1-8e2e-1f76177153c3
-- Rate ID: 427ac91d-4dcc-40b4-bf9f-98da1b0795d9 - 2023-08-21 To 2024-08-21 - $902

-- Category/ Module: Adoption Subsidy (Case Management) 
-- Root cause: CJAMS is allowing the user to create Adoption rate slab for more than 365 days.
-- 			   The CLONE ticket CDM-33049 was created for the code fix. 
-- Fix Provided: Datafix has been promoted to update Adoption Rate End date as 08/20/2024
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To Fix the Adoption Rate End date (CDM-33045)
-- Rate ID: 427ac91d-4dcc-40b4-bf9f-98da1b0795d9 - 2023-08-21 To 2024-08-21 - $902
select provider_id, startdate, enddate, updatedby, updatedon, activeflag
	from adoptioncaseagreementrate
where adoptionagreementrateid = '427ac91d-4dcc-40b4-bf9f-98da1b0795d9' ;

update adoptioncaseagreementrate
set enddate = '2024-08-20 00:00:00',
	updatedby = 'CDM-33045',
	updatedon = now()
where adoptionagreementrateid = '427ac91d-4dcc-40b4-bf9f-98da1b0795d9' ;

-- update provider id as 6055015 and end date as '2021-05-31 04:00:00'
select provider_id, startdate, enddate, updatedby, updatedon, activeflag
	from adoptioncaserevision
where adoptionagreementrateid = '427ac91d-4dcc-40b4-bf9f-98da1b0795d9' ;

update adoptioncaserevision
set enddate = '2024-08-20 00:00:00',
	updatedby = 'CDM-33045',
	updatedon = now()
where adoptionagreementrateid = '427ac91d-4dcc-40b4-bf9f-98da1b0795d9' ;

