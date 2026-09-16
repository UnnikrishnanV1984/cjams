
/*
Issue Description:CJAMS-66975 Screen Out
Category/Module: Case Management
Root cause: Need data fix to delete the intake
Fix provided: Data fix has been promoted to delete the intake from backend
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: Data fix 
*/

update intakedastatus 
set activeflag=0,updatedon=now(),updatedby='CJAMS-66975'
where intakenumber ='I261013663720' and activeflag=1;

update intakedastaging 
set activeflag=0,updatedon=now(),updatedby='CJAMS-66975'
where intakenumber ='I261013663720' and activeflag=1;

/* No data in intakesnapshot
 No data in intakeservicerequest
 No data in routing*/