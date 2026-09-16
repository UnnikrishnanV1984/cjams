/*
   Issue Description: CDM-43443
   Category/ Module  : Assessment
   Root cause: User requested to update safe-c approval date 
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  User error.
   
*/


update assessment 
set submissiondata = replace(submissiondata::text, '"safetyassessmentapprovaldate": "2024-11-07T14:49",' , '"safetyassessmentapprovaldate": "2024-11-07T15:00",')::json, 
updatedon = now(),updatedby = 'fb24ba8b-94e5-44a4-84ab-de57fa3ecb26' where assessmentid = '454fba18-b8d8-463f-bca1-959f922c76b1';

update assessment 
set submissiondata = replace(submissiondata::text, '"safetyassessmentapprovaldate": "2024-11-07T14:49",' , '"safetyassessmentapprovaldate": "2024-11-07T15:15",')::json, 
updatedon = now(),updatedby = 'fb24ba8b-94e5-44a4-84ab-de57fa3ecb26' where assessmentid = 'cff481c8-eed0-45b5-bb63-fc595a935b65';