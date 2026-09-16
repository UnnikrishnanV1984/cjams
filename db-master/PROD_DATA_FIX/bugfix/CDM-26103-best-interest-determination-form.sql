-- CDM-26103-best-interest-determination
/*
   File Name: CDM-19024-best-interest-rate-determination
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
set submissiondata = replace(submissiondata::text, 'Grade 10', 'Grade 1')::json,
updatedon = now(),
updatedby = 'CDM-19024'
where objectid = 'bc951c86-f954-44dc-bb27-4fc625e9686d' and assessmentid = 'd33fb11c-1fc7-431b-899c-db4f3a746657';

update assessment 
set submissiondata = replace(submissiondata::text, '"currentschool": "Elkton High School",' , '"currentschool": "CHARLESTOWN ELEMENTARY SCHOOL",')::json,
updatedon = now(),
updatedby = 'CDM-19024'
where objectid = 'bc951c86-f954-44dc-bb27-4fc625e9686d' and assessmentid = 'd33fb11c-1fc7-431b-899c-db4f3a746657';

update assessment 
set submissiondata = replace(submissiondata::text, '"previousschool": "Boonsboro High School",' , '"previousschool": "CHADWICK ELEMENTARY SCHOOL",')::json,
updatedon = now(),
updatedby = 'CDM-19024' 
where objectid = 'bc951c86-f954-44dc-bb27-4fc625e9686d' and assessmentid = 'd33fb11c-1fc7-431b-899c-db4f3a746657';
