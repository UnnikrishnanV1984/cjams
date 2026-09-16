/*
   Issue Description:CDM-26792
   Category/ Module  : Assessments 
   Root cause: user enter wrong selection and it was closed case
   Reason why no related code fix: web fix already raised 
*/

-- Case is closed that's why approved this assessment 

update assessment set submissiondata = jsonb_set(submissiondata::jsonb, '{IfvictimisHigh-Dangerdidthepractitionermakeacalltothehotline}', '"1"')
where submissionid ='637c23466d9818001bb10a6a' and assessmentid='e72e250d-32a7-42a8-a9ef-6a0f4e330615';


update assessment set assessmentstatustypekey ='Accepted'
where submissionid ='637c23466d9818001bb10a6a' and assessmentid='e72e250d-32a7-42a8-a9ef-6a0f4e330615';