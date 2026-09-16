/*
   Issue Description: CIDM-10325
   Category/ Module  : User Management
   Root cause:For the old submitted Home Health Asst the name not populating because the Value of the caregiver was missing. 
   Fix Provided: Data fix has been promoted to update the value of the caregiver.
   Data/Code fix ticket#: 
   Regression Impacts: N/A
   Is Code fix Required?: No
   Code fix ticket#: N/A
   Reason why no related code fix: Sailpoint issue
   Status of the code fix if already submitted and expected prod fix date:  
*/

UPDATE assessment
SET submissiondata = jsonb_set(submissiondata, '{nameofcaretaker2}', '"NATASHA  LONG"')
WHERE submissionid = '66f3151de8ef16001bfd482e' and activeflag = 1;

