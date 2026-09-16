/*
-- CDM-25144- 

-- Issue Description: courtney.wunderlich@maryland.gov
 Approvals not deleting from case pending approval inbox
  
-- Customer Email ID:raymond.brown2@maryland.gov

-- Root cause: Data fix updated the activeflag to 0
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update routing set activeflag =0, updatedby = 'CDM-25144', updatedon = now() where routingid = '8b091250-56c4-4b19-bfc3-28e4952c5cc0';