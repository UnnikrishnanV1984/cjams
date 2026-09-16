/*
   Issue Description: CIDM-10301
   Category/ Module  : User Management
   Root cause:For the name not populating because the Value of the caregiver was missing. 
    Also, the assessment completed date was populating becuase of the maximum date limit added in the formbuilder
   Fix Provided: Data fix has been promoted to update the value of the caregiver and the completion date and time.
   Data/Code fix ticket#: 
   Regression Impacts: N/A
   Is Code fix Required?: No
   Code fix ticket#: N/A
   Reason why no related code fix: Sailpoint issue
   Status of the code fix if already submitted and expected prod fix date:  
*/
UPDATE assessment
SET submissiondata = jsonb_set(submissiondata, '{datetimefield1}', '"2025-03-14T13:00:00.000Z"')
WHERE assessmentid = 'f956db28-a4a7-4992-9ce5-ed5a0dba2ee3';

UPDATE assessment
SET submissiondata = jsonb_set(submissiondata, '{nameofcaretaker2}', '"KRISTEN L COHEE"')
WHERE assessmentid = 'f956db28-a4a7-4992-9ce5-ed5a0dba2ee3' and activeflag = 1;