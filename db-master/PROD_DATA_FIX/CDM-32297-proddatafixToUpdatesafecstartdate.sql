/*
   Issue Description: CDM-32297
   Category/ Module  : Prod data fix to update inserted user details for contact notes
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/







-- CDM-32297
-- "06/05/2023 10:40 am"
UPDATE assessment set updatedon = now(),
submissiondata = jsonb_set(submissiondata::jsonb, '{dateassessmentinitiated}', '"06/02/2023 10:40 am"')
where assessmentid in ('1b9eb168-3906-4a4a-b9ee-306908467595');
