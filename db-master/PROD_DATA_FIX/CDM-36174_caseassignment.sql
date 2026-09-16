-- CDM-36174 - Workload
/*
-- Issue Description: 
   Workload Dashboard: Inactive user is showing up as theres is an active caseassignment but the case is inactive
-- Category/ Module: Workload
-- Root cause: Data issue
-- Fix Provided: Datafix has been promoted to fix the case assignment data.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

UPDATE cjams.caseassignment
SET  updatedby='CDM-36174',updatedon=now(), activeflag=0
WHERE caseassignmentid='16924c82-1dea-4e9f-8bfa-fabbb4067392' and objectid='eb707687-e68d-4417-bc3e-a98d7e65da4d';
