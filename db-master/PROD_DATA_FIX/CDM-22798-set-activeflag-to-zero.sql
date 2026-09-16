/*
-- CDM-22798- 

-- Issue Description: 
 Unable to remove review records
  
-- Customer Email ID: kathryn.morton@maryland.gov

-- Root cause: Data fix to remove the review records
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update routing set activeflag = 0, updatedby = 'CDM-22798', updatedon = now()
where routingid in ('50ce3da3-404e-4014-a50d-d846671cd96d','f64fbeae-d51d-4ac9-aeae-d5c30ba58628') and activeflag = 1;