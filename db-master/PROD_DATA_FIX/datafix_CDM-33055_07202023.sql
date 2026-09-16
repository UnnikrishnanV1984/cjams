-- CDM-33055 - Error - Subsidy End rate
/*
--	Issue Description: 
	User reuest to update the Adoption Rate end date as 07/31/2024.
    
-- Adoption Case ID: 3190501
-- Client ID: 3122023 (MARC	A COPELAND) - b496dd43-2f07-4ad2-917d-21b04bc2cdb1
-- Adoption ID: 27302 - 2010-08-12 To 2025-07-12 - a44abb2b-ff1d-4760-accb-1128232b6746
-- Rate ID: 2dc2dc6c-9380-49db-9073-94587c88da94 - 2023-08-01 16:00:00 To 2024-08-01 00:00:00 - $835.00 - Review

-- Category/ Module: Adoption Subsidy (Case Management) 
-- Root cause: CJAMS is having glitch when the user editing the Incomplete rate slab and saving the record by clicking the "Update" button, system is automatically adding one day to the rate end date. 
--			   The CLONE ticket CDM-33049 was created for the code fix. 
-- Fix Provided: Datafix has been promoted to update Adoption Rate End date as 08/20/2024
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To Fix the Adoption Rate End date (CDM-33055)
-- Rate ID: 2dc2dc6c-9380-49db-9073-94587c88da94 - 2023-08-01 16:00:00 To 2024-08-01 00:00:00 - $835.00 - Review
select provider_id, startdate, enddate, updatedby, updatedon, activeflag
	from adoptioncaserevision
where adoptionagreementrateid = '2dc2dc6c-9380-49db-9073-94587c88da94' 
	and enddate::date = '2024-08-01'::date ;

update adoptioncaserevision
set enddate = '2024-07-31 20:00:00',
	updatedby = 'CDM-33055',
	updatedon = now()
where adoptionagreementrateid = '2dc2dc6c-9380-49db-9073-94587c88da94' 
	and enddate::date = '2024-08-01'::date ;

-- This update is to cover the scenario of getting the rate approved in CJAMS production before this fix deployment.
select provider_id, startdate, enddate, updatedby, updatedon, activeflag
	from adoptioncaseagreementrate
where adoptionagreementrateid = '2dc2dc6c-9380-49db-9073-94587c88da94' 
	and enddate::date = '2024-08-01'::date ;

update adoptioncaseagreementrate
set enddate = '2024-07-31 20:00:00',
	updatedby = 'CDM-33055',
	updatedon = now()
where adoptionagreementrateid = '2dc2dc6c-9380-49db-9073-94587c88da94' 
	and enddate::date = '2024-08-01'::date ;
