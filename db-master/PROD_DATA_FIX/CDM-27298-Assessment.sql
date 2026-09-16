/*
   Issue Description:CDM-27298
   Category/ Module  : Assessments 
   Root cause: exiting error code fix already done 
   Reason why no related code fix: web fix already raised 
*/
update assessment set submissiondata = jsonb_set(submissiondata::jsonb, '{panel2740773786278622Columns2Whatworriesyou}', '"1"')
where submissionid ='6392596c6d9818001bb10ed9' and assessmentid ='4bd3969e-76ad-4d07-b7f2-8a6fcfda8098';

