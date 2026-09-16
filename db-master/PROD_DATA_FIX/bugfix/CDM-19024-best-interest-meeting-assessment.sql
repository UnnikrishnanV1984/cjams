-- CDM-19024-best-interest-rate
/*
   File Name: CDM-19024-best-interest-rate
-- Issue Description: 
    Not able to get the most latest school and previous school
  
-- Resolution: Updated the startdate in the servicecase and caseassignment for the Intake number I211010178089

-- Category/ Module: CW
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*/

update assessment 
set submissiondata = replace(submissiondata::text, '"currentschool": "Federalsburg Elementary School",' , '"currentschool": "Logan Elementary School",')::json,
updatedon = now(),
updatedby = 'CDM-19024' 
where objectid = '10bfc752-b2d8-4237-b0bc-43abb54e3886' and assessmentid = 'd3f2e527-03b7-4727-a265-1ded48e48acf';

update assessment 
set submissiondata = replace(submissiondata::text, '"previousschool": "Easton Elementary School",' , '"previousschool": "Federalsburg Elementary School",')::json,
updatedon = now(),
updatedby = 'CDM-19024' 
where objectid = '10bfc752-b2d8-4237-b0bc-43abb54e3886' and assessmentid = 'd3f2e527-03b7-4727-a265-1ded48e48acf';