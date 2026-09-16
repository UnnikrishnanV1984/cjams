/*
-- CDM-22383- 

-- Issue Description: 
 Unable to remove review records
  
-- Customer Email ID: wanda.nolt@maryland.gov

-- Root cause: Data fix to remove the review records
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update routing set activeflag = 0, updatedby = 'CDM-22383', updatedon = now()  where routingid = '2a0526c0-73cc-41b3-b567-47c83228d842' and activeflag =1;