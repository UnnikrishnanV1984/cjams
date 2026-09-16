/*
-- CDM-21554- 

-- Issue Description: 
 Re-open Service Case
  
-- Customer Email ID:raymond.brown2@maryland.gov

-- Root cause: Data fix to re-open the service case
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

--Closed        Closed        2022-03-08 17:46:19
UPDATE servicecase 
SET statustypekey ='Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-21554',updatedon = now() 
WHERE servicecaseid = '6be7d3c0-b496-4fce-976e-0607b453139a';

update servicecasedisposition 
set activeflag = 0, updatedby = 'CDM-21554',updatedon = now() 
where servicecasedispositionid = '1eae6715-99f4-4e60-a9f6-309e7d94296a';