-- CDM-39877 - OVERPAYMENT ALERT
/*
-- Issue Description: 
   User error, Data fix to change back the subsidy rate amount from $0 to $203.98. 

-- Adoption Case ID: 3242760 
-- Adoption ID: 41201 - 2014-08-21 To 2024-04-01 -  4ad047a2-19b9-42b6-9067-f85047853b04
-- Client ID: 3696856 (MIRACLE EMILY GREENE) - 6a2a4cfe-8c74-4749-bc4d-f062c83d323c
-- Rate ID: 8199de06-bcbd-4088-aa77-6f87aaa1e49b
-- 2023-08-21 To 2024-04-01 - $0.00 update as $203.98
   
-- Category/ Module: Adoption Subsidy (Finance Management) 
-- Root cause: User error, adoption rate was updated to $0.00 from $203.98 
-- Fix Provided: Datafix has been promoted to revert the Adoption Case rate back to $203.98 for fiscal adjustments. 
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To update the rate (CDM-39877)
update adoptioncaseagreementrate
set paymentamout = 203.98,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-39877'
where adoptionagreementid = 'a66c8ae0-be8f-4ee1-8712-bb3032c5e18c'
	and adoptionagreementrateid = '8199de06-bcbd-4088-aa77-6f87aaa1e49b'
	and activeflag = 1 ;

update adoptioncaserevision
set paymentamout = 203.98,
	updatedon = now(), 
	updatedby = 'CDM-39877'
where adoptionagreementid = 'a66c8ae0-be8f-4ee1-8712-bb3032c5e18c'
	and adoptionagreementrateid = '8199de06-bcbd-4088-aa77-6f87aaa1e49b'
	and activeflag = 1
	and paymentamout = 0 ;	
	