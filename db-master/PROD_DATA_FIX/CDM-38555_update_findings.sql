/*
-- Issue Description: Data entry error on Physical Abuse finding. Entered as unsubstantiated, should be indicated. We need to re-enter the 181 information and change the finding.
-- Category/ Module: Intake Referral (Intake Management)
-- Root cause: Data entry error, the Intake was screen-in and connected to the service case
-- Fix Provided: Updated the appropriate columns inside a investigationfinding to ID.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


update investigationfinding
set investigationfindingtypekey = 'ID', updatedby = 'CDM-38555', updatedon = now()
where investigationfindingid = '17dbb0aa-3919-4673-86de-ec7b82188dd0';