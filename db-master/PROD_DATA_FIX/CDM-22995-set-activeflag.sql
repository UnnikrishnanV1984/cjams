/*
-- CDM-22995- 

-- Issue Description: 
 Unable to set the activeflag
  
-- Customer Email ID: alesha.poore@maryland.gov

-- Root cause: Data fix to set the active flag
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update routing set activeflag = 0, updatedby = 'CDM-22995', updatedon = now() 
where routingid = 'ffc9fcb6-aea4-4cb5-9b4a-3017c43e8798' and activeflag = 1;