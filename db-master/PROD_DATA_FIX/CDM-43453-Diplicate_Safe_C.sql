/*
   Issue Description: CDM-43453
   Category/ Module  : Assessment
   Root cause: User requested to update safe-c approval date 
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  User error.
   
*/


update assessment 
set submissiondata = replace(submissiondata::text, '"safetyassessmentapprovaldate": "2024-10-30T10:43",' , '"safetyassessmentapprovaldate": "2024-10-30T11:00",')::json, 
updatedon = now(),updatedby = 'fb24ba8b-94e5-44a4-84ab-de57fa3ecb26' where assessmentid = 'ce3cb1e9-2cd9-4ce1-b43c-fbf16237e4b2';