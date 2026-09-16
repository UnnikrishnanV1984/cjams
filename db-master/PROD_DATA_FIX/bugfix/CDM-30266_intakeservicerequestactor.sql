/*
-- Issue Description: 
	CDM-30266-person missing in case
-- Category/ Module: 
-- Root cause: User Request
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

UPDATE cjams.intakeservicerequestactor
SET updatedby='CDM-30266', updatedon=now(), isprimary=true
WHERE intakeservicerequestactorid='73c961be-145c-4e62-8e7d-b4105a8cd194' and personid='2d4a6505-4ed5-4baf-b0e9-2b71620e53f3';
