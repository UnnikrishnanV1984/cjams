/*
Issue: Person record with CJAMS PID: 204217671 could not be added to intake I261013897229
Root Cause: Needed to add the person to the intake request actor table with the correct intake number.
Fix Provided: Data fix has been provided to update the intake number for the person record in the intake request actor table.
Data/Code fix ticket#: CJAMS-65399
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data issue, not a code defect
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/
update intakeservicerequestactor
set intakenumber='I261013897229',
updatedby='CJAMS-65399',
updatedon=now()
where intakeservicerequestactorid='c73a5a40-7c0a-43ec-b46d-7e15f1ed93a7';