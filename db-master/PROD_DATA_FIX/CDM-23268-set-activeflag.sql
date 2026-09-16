/*
-- CDM-23268- 

-- Issue Description: 
 Unable to remove items from case pending approval inbox
  
-- Customer Email ID: shawnae.lowery@maryland.gov

-- Root cause: Data fix to set the activeflag to zero
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update routing set activeflag = 0 , updatedby = 'CDM-23268', updatedon = now()
where routingid = 'bd5f20f9-4bae-4dcc-affa-915be9cd4302';