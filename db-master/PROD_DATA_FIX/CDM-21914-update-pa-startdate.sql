/*
-- CDM-21914 - 

-- Issue Description: 
 Unable to update the gap start date
  
-- Customer Email ID: michelle.forney@montgomerycountymd.gov

-- Root cause: Data fix to update the gap start date
-- Pull request#: N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update personprogramarea set startdate = '2022-03-22 04:00:00', updatedby = 'CDM-21914', updatedon = now() where personprogramid = '389a4e34-45a5-4488-8c01-6892ccecb798';

