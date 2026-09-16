-- CDM-16796 - Incorrect last names
/*
-- Issue Description: 
	211020130922:The date of last Safety Plan is not populated
	
-- Category/ Module:  Assessments
-- Root cause: User Request

-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/
update  assessment 
set     submissiondata = jsonb_set(submissiondata::jsonb, '{dateoflastsafetyplan}', '"2021-08-16T20:32:39.000Z"')
where   submissionid ='6138e3bccfadd0001a5a2b6d';