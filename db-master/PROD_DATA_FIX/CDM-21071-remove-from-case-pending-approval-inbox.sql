/*
-- CDM-21071- 

-- Issue Description: 
 Approvals not deleting from case pending approval inbox
  
-- Customer Email ID:raymond.brown2@maryland.gov

-- Root cause: Data fix updated the activeflag to 0
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update routing set activeflag =0, updatedby = 'CDM-21071', updatedon = now() where routingid = 'e0bc9366-4d05-461e-9c1e-e547e48a0b15';