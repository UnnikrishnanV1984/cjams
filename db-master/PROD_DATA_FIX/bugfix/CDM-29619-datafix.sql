/*
-- Issue Description: 
	Safe-C OHP assessments data fix to update the correct Client IDs

-- Category/ Module: Assessments (Case Management) 
-- Root cause: 
-- Fix Provided: Data fix has been promoted to updated all impacted Safe-C OHP assessments to correct Client IDs
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

UPDATE assessment SET submissiondata = replace(submissiondata::text, '"clientid": "200023538"', '"clientid": "200023555"')::json WHERE assessmentid = 'ad9a9a24-d55f-4b7d-98af-f4fc9ac4881a' AND activeflag = 1;
