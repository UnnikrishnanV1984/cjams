/*
-- CDM-21613- 

-- Issue Description: 
 Unable to set end date on program assignments
  
-- Customer Email ID: lindaj.luallen@maryland.gov

-- Root cause: Data fix to re-open the service case
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update personprogramarea set enddate = '2020-09-10 00:00:00', updatedon = now() 
where personprogramid = '51c44f1f-58f5-4825-bb2b-a62b7a1406fb';