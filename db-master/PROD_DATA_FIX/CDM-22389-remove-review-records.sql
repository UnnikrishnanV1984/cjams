/*
-- CDM-22389- 

-- Issue Description: 
 Unable to remove review records
  
-- Customer Email ID: wanda.nolt@maryland.gov

-- Root cause: Data fix to remove the review records
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update routing set activeflag = 0, updatedby = 'CDM-22389', updatedon = now()  where routingid in ('837c021a-3145-4ac9-ba61-9ce60792df99','794cb72a-dd6f-415d-a385-7733ad6c9d52');