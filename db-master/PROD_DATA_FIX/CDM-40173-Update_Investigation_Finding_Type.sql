/*
 Issue Description: CDM-40173
-- Category/ Module: Investigation Findings
-- Root cause: User wants to change the investigation finding type from ruledout to Indicated
-- Fix Provided: Datafix has been promoted to update finding type.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update investigationfinding 
set investigationfindingtypekey = 'ID', updatedon = now(), updatedby = 'CDM-40173'
where investigationfindingid = 'b32bbd35-328c-43e1-b46d-f12e749edf25'