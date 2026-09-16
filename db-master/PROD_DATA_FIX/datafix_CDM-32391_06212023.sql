-- CDM-32391 - Remove GAP end date
/*
-- Issue Description: 
	 User reuest to re-open the Permanency Plan

-- Case ID: 3277242 - 10801b7c-ec64-445f-afca-49ca4c9b3690
-- Client ID: 3660491 (OLIVIA N	JONES) - eb353c61-1d39-4d30-ad02-1f70ad981fc7
-- Permanency Plan: Guardianship by relative / APPLA  - 04/13/2023	To 04/13/2023 - ffa16c0f-75d9-4df8-943b-84ab614ec6b3
  
-- Category/ Module: Permanency Plan(Case Management)
-- Root cause: User Error.
-- Fix Provided: Datafix has been promoted to re-open the requested Guardianship by relative / APPLA Permanency Plan
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To re-open the Permanency Plan (CDM-32391)
select establisheddate, enddate, primarypermanencytype, concurrentpermanencytype, updatedby, updatedon
	from cjams.permanencyplan
where permanencyplanid = 'ffa16c0f-75d9-4df8-943b-84ab614ec6b3'
	and activeflag = 1 ;

update cjams.permanencyplan 
set enddate = NULL,
	updatedby = 'CDM-32391',
	updatedon = now()
where permanencyplanid = 'ffa16c0f-75d9-4df8-943b-84ab614ec6b3'
	and activeflag = 1 ;
