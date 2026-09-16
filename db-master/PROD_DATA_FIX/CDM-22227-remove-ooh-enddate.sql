/*
-- CDM-22227 - 

-- Issue Description: 
 Unable to remove end date on Out of Home
  
-- Customer Email ID: christopher.snow@maryland.gov

-- Root cause: Data fix to set the end date to null
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- 2020-11-06 13:51:53
update personprogramarea set enddate = null, updatedon = now() where personprogramid = '75d421b0-9a6a-40f5-8085-90d8b23e7124';