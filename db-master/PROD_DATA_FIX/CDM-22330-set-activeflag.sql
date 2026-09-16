/*
-- CDM-22330- 

-- Issue Description: 
 Unable to remove review records
  
-- Customer Email ID: wanda.nolt@maryland.gov

-- Root cause: Data fix to remove the review records
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update routing set activeflag = 0, updatedby = 'CDM-22330', updatedon = now()
where routingid in ('10030bf8-460c-4be9-95de-8cf2e1fcf680', '40904f56-6e8e-4e9d-8f8a-a1caecdc1ab6') and activeflag = 1;