/*
-- CDM-22872- 

-- Issue Description: 
 Unable to remove the ytp review
  
-- Customer Email ID: jonathan.albright@maryland.gov

-- Root cause: Data fix to remove the ytp review
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update routing set activeflag = 0, updatedby = 'CDM-22872', updatedon = now()
where routingid in (
'e5716fa8-4eb7-4596-8503-2a9b05d9b2e9',
'e0e82988-373d-4195-b952-46a77eefd001',
'6197a1b5-49f5-406e-99da-01509e27935b',
'6f9775bd-0b54-4cfa-a6e1-e6c522c20bf6',
'44e532dc-acef-44a2-a5dd-5224e5265d15'
) and activeflag = 1;