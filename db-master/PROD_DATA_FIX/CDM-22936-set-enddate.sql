/*
-- CDM-22936- 

-- Issue Description: 
 Unable to remove the end date on OOH
  
-- Customer Email ID: troy.robinson@maryland.gov

-- Root cause: Data fix to remove the end date on OOH
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- 2020-02-27 00:00:00
update personprogramarea set enddate = null, updatedby = 'CDM-22936',updatedon = now() 
where personprogramid = '1e424858-0f64-40ae-b0e2-ec3dcbf8e04a';