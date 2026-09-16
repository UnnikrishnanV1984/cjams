/*
   Issue Description: CDM-30032
   Category/ Module  : Assessments Safce c 
   Root cause: Approval date and time are prior to completion date
   Pull request# for code fix: 8641
   Reason why no related code fix: 
    requested a data fix and code fix to resolve
*/
update assessment 
set submissiondata = replace(submissiondata::text, '"safetyassessmentapprovaldate": "2023-02-22T20:28",' , 
'"safetyassessmentapprovaldate": "2023-02-23T10:28",')::json, 
updatedon = now(),updatedby = 'CDM-30032' where assessmentid = '77a178f2-6718-447a-abfa-95c1472f5fae';
