/*
-- CDM-19741- 

-- Issue Description: 
 Unable to remove the items from case approval dashboard
  
-- Customer Email ID: melissa.difranco@maryland.gov

-- Root cause: Data fix to set the activeflag to zero
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update routing set activeflag = 0, updatedby = 'CDM-19741', updatedon = now()
where routingid in ('c5958b0e-b85a-4f8e-8ea2-44daad46322e','5671f0de-30c4-44bb-992f-5ad763280323') and activeflag = 1;