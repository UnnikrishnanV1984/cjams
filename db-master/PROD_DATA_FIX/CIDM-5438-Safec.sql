/*
   Issue Description:CDM-24057
   Category/ Module  : Assessments 
   Root cause: might be client enter manually 
   Reason why no related code fix: web fix already raised 
*/


update assessment set updatedby ='CDM-24057', updatedon =now(), submissiondata = jsonb_set(submissiondata::jsonb, '{caseid}', '"3273193"')
where submissionid ='6269f79dc5455c001bc1e2ab'and assessmentid ='794e85da-ce6f-438d-9f25-74a06e8b216c';