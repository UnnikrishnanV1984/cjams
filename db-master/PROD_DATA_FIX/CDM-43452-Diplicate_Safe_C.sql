/*
   Issue Description: CDM-43452
   Category/ Module  : Assessment
   Root cause: User requested to update safe-c approval date 
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  User error.
   
*/

update assessment 
set submissiondata = replace(submissiondata::text, '"safetyassessmentapprovaldate": "2024-11-26T22:24",' , '"safetyassessmentapprovaldate": "2024-11-26T22:30",')::json, 
updatedon = now(),updatedby = '3e07111f-f5f9-4e72-92a7-9cd2d0c1791f' where assessmentid = '651e641e-cea7-445b-9ed5-1fa3e313d0b5';
