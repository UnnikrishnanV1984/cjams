/*
-- CDM-21553- 

-- Issue Description: 
 Re-open Service Case
  
-- Customer Email ID:raymond.brown2@maryland.gov

-- Root cause: Data fix to re-open the service case
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

--Closed        Closed        2022-03-08 17:18:45
UPDATE servicecase 
SET statustypekey ='Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-21553',updatedon = now() 
WHERE servicecaseid = '420ab76c-2ae4-412a-b642-1c597ef6a76d';

update servicecasedisposition 
set activeflag = 0, updatedby = 'CDM-21553',updatedon = now() 
where servicecasedispositionid = 'c1ee3449-e842-4d1a-9f2c-75cdb7a866d9';