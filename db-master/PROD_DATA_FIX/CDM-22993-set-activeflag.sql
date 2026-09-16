/*
-- CDM-22993- 

-- Issue Description: 
 Unable to set the end date
  
-- Customer Email ID: heather.ruark1@maryland.gov

-- Root cause: Data fix to set the end date
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update caseassignment set enddate = '2022-06-06 12:45:08', updatedby = 'CDM-22993', updatedon = now() 
where caseassignmentid = 'c8d649e5-368d-48e1-8f69-aecf5428f45d';