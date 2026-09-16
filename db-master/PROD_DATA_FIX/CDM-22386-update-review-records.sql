/*
-- CDM-22386- 

-- Issue Description: 
 Unable to remove review records
  
-- Customer Email ID: wanda.nolt@maryland.gov

-- Root cause: Data fix to remove the review records
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update routing set activeflag = 0, updatedby = 'CDM-22386', updatedon = now()
where routingid in ('dd389205-198b-4b61-8aa9-78c9fefb6dea',
'bbdc8051-feed-4e5b-9733-0ce6d1160abe',
'fa9526dc-52f8-420d-b502-d63b3cd82e0d',
'bd9b64b0-95e1-48d9-bb84-f60437e0c2c8',
'a4575156-0e66-474b-88e3-77ed1a26e824') and activeflag = 1;