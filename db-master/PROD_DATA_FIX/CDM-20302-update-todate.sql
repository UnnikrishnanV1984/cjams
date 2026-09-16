/*
-- CDM-20302 - 

-- Issue Description: 
 Update todate
  
-- Customer Email ID: amanda.kerstetter@maryland.gov

-- Root cause: Data fix to update todate
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update snapshothist set todate = '2022-02-08', updatedon = now(), updatedby = '63ec2281-6903-4191-848b-e53d89ef63bc' where id = '748f3ff2-c002-41e8-ad73-8622841925a6';