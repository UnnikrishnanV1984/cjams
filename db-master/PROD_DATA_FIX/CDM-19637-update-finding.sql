/*
-- CDM-19637- 

-- Issue Description: 
 Unable to remove the ytp review
  
-- Customer Email ID: jonathan.albright@maryland.gov

-- Root cause: Data fix to remove the ytp review
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- bf0e9639-cbd6-4fd1-bca0-9489c3d65176
update investigationfinding set investigationallegationid = '3937d591-b8c2-4d3c-a1f8-1f5fc29ca9fd',
updatedby = 'CDM-19637', updatedon = now() where investigationfindingid = 'f9f66b15-1eba-4d6d-bf43-84ff56eb1ac1';
