/*
-- CDM-21961- 

-- Issue Description: 
 Unable to update service agreement date
  
-- Customer Email ID:raymond.brown2@maryland.gov

-- Root cause: Data fix to update the service agreement date
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- 2022-03-17 00:00:00
update serviceagreement set agreementdate = '2022-03-16 00:00:00', updatedon = now(), updatedby = 'CDM-21961' where agreementid = 'f5a52946-7d5b-4196-9a5b-ec62b70b3db1';