/*
-- CDM-22066- 

-- Issue Description: 
 Unable to update permanency plan establish date
  
-- Customer Email ID: caitlyn.wilson@maryland.gov

-- Root cause: Data fix to update the permanency plan establish date
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update permanencyplan set establisheddate = '2021-09-20 04:00:00.000', updatedon = now() where permanencyplanid = 'c5ad62c8-e003-4d22-8862-41478a23e47f';