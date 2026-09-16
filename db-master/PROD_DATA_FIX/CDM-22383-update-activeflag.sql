/*
-- CDM-22383- 

-- Issue Description: 
 Unable to remove review record
  
-- Customer Email ID: wanda.nolt@maryland.gov

-- Root cause: Data fix to remove the review record
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update routing set activeflag = 0, updatedby = 'CDM-22383', updatedon = now()  where routingid = '59576c5f-a1bb-41e3-b990-c03a1ecd410c';