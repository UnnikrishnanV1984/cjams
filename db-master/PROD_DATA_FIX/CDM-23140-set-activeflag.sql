/*
-- CDM-23140 - 

-- Issue Description: 
 Unable to remove the items from case approval dashboard
  
-- Customer Email ID: cheryl.paige@maryland.gov

-- Root cause: Data fix to set the activeflag to zero
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update routing set activeflag =0, updatedby = 'CDM-23140', updatedon = now() 
where routingid = '78da3368-915d-4d5e-9669-d1684bd85484';