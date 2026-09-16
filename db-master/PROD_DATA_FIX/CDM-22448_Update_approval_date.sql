/*
   Issue Description: CDM-22448
   Category/ Module  : Updated the approval date
   Root cause: The safe-c does not show an approval date even though when you look at it from the assessments tab it shows that it was approved.
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/





update assessment 
set submissiondata = replace(submissiondata::text, '"safetyassessmentapprovaldate": "",' , '"safetyassessmentapprovaldate": "2022-03-15T20:20:00.000Z",')::json, 
updatedon = now(),updatedby = 'CDM-22448' where assessmentid = '8b2b6743-1145-4d25-a508-89951c66adc1';