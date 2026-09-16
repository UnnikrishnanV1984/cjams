/*
   Issue Description:CDM-27703
   Category/ Module  : Assessments 
   Root cause: exiting error code fix already done 
   Reason why no related code fix: web fix already raised 
*/


update assessment set submissiondata = jsonb_set(submissiondata::jsonb, '{IfvictimisHigh-Dangerdidthepractitionermakeacalltothehotline}', '"1"'), updatedby ='CDM-27703', updatedon = now()
where submissionid ='62e403d4c840a4001b448d9c' and assessmentid ='5f5ee714-7c64-4f39-b17c-c12771b2da77';