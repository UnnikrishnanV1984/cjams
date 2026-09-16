/*
-- CDM-22391- 

-- Issue Description: 
 Unable to remove review record
  
-- Customer Email ID: wanda.nolt@maryland.gov

-- Root cause: Data fix to remove the review record
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update routing set activeflag = 0, updatedby = 'CDM-22391', updatedon = now()  where routingid = '7bb7eb59-619f-4b93-b25f-62ead802e422';