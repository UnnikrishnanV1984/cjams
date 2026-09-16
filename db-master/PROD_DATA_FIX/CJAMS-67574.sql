
/*
Issue Description: CJAMS-67574
Category/Module: Delete referral
Root cause: Duplicate Intake created; needs to be deleted. 
Fix provided: Data fix has been promoted to remove the intake referral I251013566487
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: Data fix 
*/

update intakedastatus 
set activeflag=0,updatedon=now(),updatedby='CJAMS-67574'
where intakenumber ='I251013566487' and activeflag=1;

update intakedastaging 
set activeflag=0,updatedon=now(),updatedby='CJAMS-67574'
where intakenumber ='I251013566487' and activeflag=1;