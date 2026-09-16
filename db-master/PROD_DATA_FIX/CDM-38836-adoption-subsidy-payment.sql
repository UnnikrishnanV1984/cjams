-- CDM-38836 - Subsidy Rate Issue
/*
-- Issue Description: 
   User request to change the Adoption Subsidy Rate Start Date
   
-- Adoption Case ID: 3277234
-- Client ID: 2965921 (Andria Powell) 
  
-- Category/ Module: Adoption Subsidy (Finance Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update Rate Start date as 4/24/2021. (Old value 04/26/2021)

update adoptioncaseagreementrate
set startdate = '2021-04-24 00:00:00',
	approvaldate = '2024-04-29 00:00:00',
	updatedon = now(), 
	updatedby = 'CDM-38836'
where adoptionagreementid = '632957ce-eb2a-44c4-bfe8-bf8250f7d94a'
	and adoptionagreementrateid = 'f036c12f-da60-4aa8-83da-ed539f73a559';


update adoptioncaserevision
set startdate = '2021-04-24 00:00:00',
	updatedon = now(), 
	updatedby = 'CDM-38836'
where adoptionagreementid = '632957ce-eb2a-44c4-bfe8-bf8250f7d94a'
	and adoptionagreementrateid = 'f036c12f-da60-4aa8-83da-ed539f73a559';

update adoptioncaserevision
set approvaldate = '2024-04-29 00:00:00',
	updatedon = now(), 
	updatedby = 'CDM-38836'
where adoptionagreementid = '632957ce-eb2a-44c4-bfe8-bf8250f7d94a'
	and adoptionagreementrateid = 'f036c12f-da60-4aa8-83da-ed539f73a559'
	and approvaldate is not null ;