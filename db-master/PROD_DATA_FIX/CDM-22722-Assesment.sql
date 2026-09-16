/*
   Issue Description:CDM-22722
   Category/ Module  : Assessments 
   Root cause: user enter wrong selection and it was closed case
   Reason why no related code fix: web fix already raised 
*/



update assessment set submissiondata = jsonb_set(submissiondata::jsonb, '{IfvictimisHigh-Dangerdidthepractitionermakeacalltothehotline}', '"1"'), updatedby ='CDM-22722', updatedon =now()
where submissionid ='627d1cc2c840a4001b445545' and assessmentid='daca3a5b-2176-4214-be73-6b2943d577cd';