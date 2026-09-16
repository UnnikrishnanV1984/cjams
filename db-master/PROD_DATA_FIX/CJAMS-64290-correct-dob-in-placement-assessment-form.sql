/*
Issue: CJAMS-64290 Placement A
Category/Module: Placement A Assessment 
Root cause: client DOB was changed from 01/26/2019 to 07/14/2011 on 12/16/2025, and the Placement A Assessment is approved on 12/18/2025.
            This is a snapshot data and it was created before the assessment request got created before the date of birth is changed.
Fix provided: Data fix has been done to correct the client dob in the assessment snapshot record. 
Data/Code fix ticket#: CJAMS-64290
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data saved in assessment is a snapshot and data fix needed to correct it.
*/

--We are not updating the audit columns as it is impacting the Assessment approval record

UPDATE assessment
SET submissiondata = jsonb_set(
    submissiondata,
    '{youthinformation,Youthdob}',
    '"07/14/2011"',   
    true
)
WHERE assessmentid = '00eb925a-69cd-4129-886f-bbca9ca4f3e4'
and activeflag =1;