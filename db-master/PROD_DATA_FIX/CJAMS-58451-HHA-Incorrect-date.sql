/*
   Issue Description: CJAMS-58451 
   Category/ Module  : User Management
   Root cause: User requested to edit the assessment completed date time from "02/19/2025 12:00 PM" to "03/18/2025 12:00 PM" in the home health assessment. Please do a data fix to update the assessment completed date time in the home health assessment. 
    The User email id is jenniferj.linsey@maryland.gov and the case number is "221030014473".
   User list:  tamara.ogunade@maryland.gov
   Fix Provided: Data fix has been promoted to update the assessment completed date.
   Data/Code fix ticket#: 
   Regression Impacts: N/A
   Is Code fix Required?: No
   Code fix ticket#: N/A
   Reason why no related code fix: Sailpoint issue
   Status of the code fix if already submitted and expected prod fix date:  
*/

UPDATE assessment
SET submissiondata = jsonb_set(submissiondata, '{datetimefield1}', '"2025-03-18T16:00:00.000Z"')
WHERE assessmentid = 'dd48c8e1-e6f5-4bd9-ba5e-05677449883c';

update  cjams.assessment set submissiondata = jsonb_set(submissiondata:: jsonb, '{panel2980372465884724ColumnsSignedDateandTime}', '"2025-03-18T16:00:00.000Z"')
where assessmentid =  'dd48c8e1-e6f5-4bd9-ba5e-05677449883c' and activeflag = 1;
