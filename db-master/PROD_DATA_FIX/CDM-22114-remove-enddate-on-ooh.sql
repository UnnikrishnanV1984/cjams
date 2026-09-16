/*
-- CDM-22114- 

-- Issue Description: 
 Unable to update enddate on OOH
  
-- Customer Email ID: sarah.hughes@maryland.gov

-- Root cause: Data fix to to update the enddate on OOH
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

--2021-11-30 12:22:22
--2021-11-30 12:22:22
--2021-11-30 12:22:22
update personprogramarea set enddate = null, updatedby = 'CDM-22114', updatedon = now() 
where personprogramid in ('92a124b5-d1d9-4e66-bb62-83932f37b1f0','d4ec7f80-a862-4bb1-b1b5-ba639112165c','6005e069-616f-4062-9bdb-80a65e010ea6');