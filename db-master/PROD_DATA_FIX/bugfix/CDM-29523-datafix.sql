/*
-- Issue Description: 
   Adoption Case - 
-- Category/ Module: Adoption  (Adoption Case Management) 
-- Root cause: Data Issue 
-- Pull request# N/A
-- Reason why no related code fix: N/A
*/


UPDATE cjams.routing
SET activeflag=0, updatedon=now()
WHERE routingid='f9a3b6cb-5746-4769-bb4b-1de86c85a347' and objectid='005b0419-ac13-4c31-8b12-28f095ff87eb';
