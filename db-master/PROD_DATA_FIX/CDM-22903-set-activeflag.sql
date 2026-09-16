/*
-- CDM-22903- 

-- Issue Description: 
 Unable to remove from approval inbox dashboard
  
-- Customer Email ID: jonathan.albright@maryland.gov

-- Root cause: Data fix to set the activeflag
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update routing set activeflag = 0, updatedby = 'CDM-22903', updatedon = now()
where routingid = '900a60e5-1070-40cc-8a25-28b9cf043806' and activeflag = 1;