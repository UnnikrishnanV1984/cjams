/*
   Issue Description: CDM-43444
   Category/ Module  : Assessments Safce c 
   Root cause: Approval date and time are prior to completion date
   Pull request# for code fix: 8641
   Reason why no related code fix: 
    requested a data fix and code fix to resolve
*/


update assessment 
set submissiondata = replace(submissiondata::text, '"safetyassessmentapprovaldate": "2024-11-21T15:12"' , 
'"safetyassessmentapprovaldate": "2024-11-21T15:15"')::json, updatedon = now(), updatedby='fb24ba8b-94e5-44a4-84ab-de57fa3ecb26'
where assessmentid = 'ebca1b5e-b853-454b-baa9-056a9fa08896' and activeflag = 1;