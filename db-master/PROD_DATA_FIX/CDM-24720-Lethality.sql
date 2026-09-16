/*
   Issue Description:CDM-24720
   Category/ Module  : Assessments 
   Root cause: exiting error code fix already done 
   Reason why no related code fix: web fix already raised 
*/


update assessment set submissiondata = jsonb_set(submissiondata::jsonb, '{IfvictimisHigh-Dangerdidthepractitionermakeacalltothehotline}', '"1"'), updatedby ='CDM-24720', updatedon = now()
where submissionid ='6307d0d6c840a4001b4494d2' and assessmentid ='cd47246e-b67b-4895-8e3c-71dc91250d72';