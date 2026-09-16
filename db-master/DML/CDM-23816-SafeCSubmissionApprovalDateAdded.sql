/*
   Issue Description: CDM-23816
   Category/ Module  :  Modified Submission approval Date in Submission data
   Root cause:  Modified Submission approval Date in Submission data
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update assessment 
set submissiondata = replace(submissiondata::text, '"safetyassessmentapprovaldate": "",' , '"safetyassessmentapprovaldate": "2022-06-24T14:00:00.000Z",')::json, 
updatedon = now(),updatedby = 'CDM-23816' where assessmentid = 'cb32872b-d9d3-4c14-a054-7e167664ccb7';