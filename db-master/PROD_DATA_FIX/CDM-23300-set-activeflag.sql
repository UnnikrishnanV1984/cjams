/*
-- CDM-23300- 

-- Issue Description: 
 Unable to remove items from case pending approval inbox
  
-- Customer Email ID: susan.loysen@maryland.gov

-- Root cause: Data fix to set the activeflag to zero
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update routing set activeflag = 0,updatedon =  now(), updatedby = 'CDM-23300' where routingid = 'd95444ba-eff8-4d5d-8c8a-b5d81a7cd896';