/*
  Issue Description:  CDM-44145
   Category/ Module  :  Assessments: CANS
   Root cause:CANS-OHP Cannot edit draft
   Pull request# for code fix: NA
   Reason why no related code fix: NA
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: NA
*/


UPDATE assessment 
SET submissiondata = jsonb_set(
    submissiondata::jsonb, 
    '{authorizationForm,assessmentstatus}', 
    'null'::jsonb
)
WHERE objectid = '61295b7a-95d9-4aa3-96f2-0045ad232fd6' 
  AND assessmentid = 'eab2f42d-c49b-4400-b37d-e720867e0f66'  
  AND submissionid = 'c41ab018-032a-44e1-975e-a625cec5ee3a'  
  AND activeflag = 1;

