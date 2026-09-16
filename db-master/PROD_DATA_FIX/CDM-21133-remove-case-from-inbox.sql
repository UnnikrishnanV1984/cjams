/*
-- CDM-21133 - 

-- Issue Description: 
 Remove from case pending approval inbox
  
-- Customer Email ID:scunningham@maryland.gov

-- Root cause: Data fix updated the activeflag to 0
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update routing set activeflag =0, updatedby = 'CDM-21133', updatedon = now() where routingid = '7ee1c001-cd21-489b-bdd6-1896e582ea99' and activeflag = 1