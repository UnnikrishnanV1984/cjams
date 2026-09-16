-- CDM-40194 - MONIES WILL NOT POPULATE
/*
-- Issue Description: 
	GAP subsidy was opened but did not generate payment. 
	
-- Case ID: 3269382
-- Client ID: 4185350 (KAYLYNN I COLEMAN) - fd69bf2f-648f-4416-9e39-279297571c1a
-- GAP ID: 1021580 - 2024-04-26 To 2035-09-27	- 4ab51d91-cc85-4f96-af8b-a2ae2d56e770
-- Provier ID: 6126290	(Nekisha  Walker)
   
-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: Data issue, Inactive actor id in the permanencyplan table. 
-- Fix Provided: Datafix has been promoted to resolve the data discrepancy (update active intakeservicerequestactorid in permanencyplan table)
--				 and trigger finance under/over batch.	
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- permanencyplanid : 7f0b8dc1-a3c1-41e4-80fa-9bef28bb05f8
-- intakeservicerequestactorid:
-- Current 2d4f71b9-30e5-424e-a2ef-10b05362bfc1 - LG - Inactive
-- Update 72df5565-71c1-4374-96ea-48ed8d464534 - CHILD

-- To update permanencyplan table intakeservicerequestactorid (CDM-40194)
update cjams.permanencyplan 
set intakeservicerequestactorid = '72df5565-71c1-4374-96ea-48ed8d464534',
	updatedby = 'CDM-40194',
	updatedon = now()
where permanencyplanid = '7f0b8dc1-a3c1-41e4-80fa-9bef28bb05f8'
	and activeflag  = 1 ;
	
-- To Trigger Under Over 
update cjams.gapratesrevision
set approvaldate = now(),
	updatedby = 'CDM-40194',
	updatedon = now()
where gaprateid = '94f4dbaf-858a-45db-b18a-7cc77a2b447b' ;
