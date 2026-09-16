/*
-- CDM-23170 - 

-- Issue Description: 
 Unable to remove the items from case approval dashboard
  
-- Customer Email ID: raymond.brown2@maryland.gov

-- Root cause: Data fix to set the activeflag to zero
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update routing set activeflag =0, updatedby = 'CDM-23170', updatedon = now() 
where routingid = 'f9c4d233-cefe-4670-a683-3e8c935f32f7';