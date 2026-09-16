-- CDM-37444 - case error
/*
-- Issue Description: 
   The HOH has been identified under the Household tab but CJAMS displayed an alert that the case does not have a head of household identified.

-- Case ID: 231020523436

-- Category/ Module: Persons: Household
-- Root cause:The HOH has been identified under the Household tab but CJAMS displayed an alert that the case does not have a head of household identified.
-- Fix Provided: Data fix was promoted to add intakeserviceid in intakeservicerequest table
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


select *from intakeservicerequestactor 
where personid='9cf33098-de04-4658-af4f-8d8a78eedefc' 
and intakeservicerequestactorid='17bbccbb-e85d-4e01-b527-be52487aa9d4'
and activeflag=1;


update intakeservicerequestactor 
set intakeserviceid='ea12c607-8928-4cc9-b0df-87657c709965',
    updatedby = 'CDM-37444',
	 updatedon = now() 
where personid='9cf33098-de04-4658-af4f-8d8a78eedefc' 
and intakeservicerequestactorid='17bbccbb-e85d-4e01-b527-be52487aa9d4'
and activeflag=1;