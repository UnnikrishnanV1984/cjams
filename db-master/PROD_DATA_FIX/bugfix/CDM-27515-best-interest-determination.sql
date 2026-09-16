-- CDM-27515-best-interest-determination
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
set submissiondata = replace(submissiondata::text, '"currentschool": "Thurmont Middle School",' , '"currentschool": "Plum Point Elementary School",')::json ,
updatedon = now(),
updatedby = 'CDM-27515' 
where objectid = 'fd23ed4e-bafd-4d47-ae03-2f78d5618176' and assessmentid = 'cd85a4fb-0fee-4891-bfd3-1910039efe81';

update assessment 
set submissiondata = replace(submissiondata::text, '"previousschool": "Northern Middle School",' , '"previousschool": "Huntingtown Elementary School",')::json,
updatedon = now(),
updatedby = 'CDM-27515' 
where objectid = 'fd23ed4e-bafd-4d47-ae03-2f78d5618176' and assessmentid = 'cd85a4fb-0fee-4891-bfd3-1910039efe81';

update assessment 
set submissiondata = replace(submissiondata::text, 'Grade 6' , 'Grade 1')::json,
updatedon = now(),
updatedby = 'CDM-27515'
where objectid = 'fd23ed4e-bafd-4d47-ae03-2f78d5618176' and assessmentid = 'cd85a4fb-0fee-4891-bfd3-1910039efe81';