/*
-- CDM-23167- 

-- Issue Description: 
 Unable to remove items from case pending approval inbox
  
-- Customer Email ID: lynette.venson@maryland.gov

-- Root cause: Data fix to set the activeflag to zero
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update routing set activeflag = 0,updatedon =  now(), updatedby = 'CDM-23167' where routingid = 'ac5fec38-2d5f-4419-a340-91a0dbd88230';