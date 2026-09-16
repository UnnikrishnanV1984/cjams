/*
-- CDM-23016 --

-- Issue Description: 
 Case Opening Date Needs FIXED
  
-- Customer Email ID: lori.pfeiffer@maryland.gov

-- Root cause: Data fix to set the end date
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


update servicecasedisposition 
set statusdate = '2021-01-19 04:34:00', effectivedate = '2021-01-19 04:34:00', updatedby = 'CDM-23016', updatedon = now() 
where servicecasedispositionid = '6f578be8-b466-4d13-9cf7-d6cc6517accd';
