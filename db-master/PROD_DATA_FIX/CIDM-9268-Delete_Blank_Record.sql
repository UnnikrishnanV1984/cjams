/*
 Issue Description: CIDM-9268
-- Category/ Module: Release Notes
-- Root cause: Updates and Informed Consent (f/u to B-180173) is not deployed in production but got added in the the release notes. 
-- Fix Provided: Datafix has been promoted to update active flag.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update defecttracking.releasenotes 
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CIDM-9268'
where releasedate ::date = '2024-07-16'::date 
and releasenotesid  = '9fbcf8fa-8241-46c0-bd78-7dea674f2883'
and activeflag = 1;