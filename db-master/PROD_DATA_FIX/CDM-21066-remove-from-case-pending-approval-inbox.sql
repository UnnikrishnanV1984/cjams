/*
-- CDM-21066- 

-- Issue Description: 
 Approvals not deleting from case pending approval inbox
  
-- Customer Email ID:raymond.brown2@maryland.gov

-- Root cause: Data fix updated the activeflag to 0
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update routing set activeflag =0, updatedby = 'CDM-21066', updatedon = now() where routingid = '7686cfe6-5660-486a-a600-d95c75de8661';