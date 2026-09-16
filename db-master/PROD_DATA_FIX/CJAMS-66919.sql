/*
Issue Description: CJAMS-66919
Category/Module: Delete referral
Root cause: User requested to remove the intake referrals I261013998130, as user had created by error
Fix provided: Data fix has been promoted to remove the intake referral I261013998130
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: Data fix 
*/



update intakedastatus 
set activeflag=0,updatedon=now(),updatedby='CJAMS-66919'
where intakenumber ='I261013998130' and activeflag=1;

update intakedastaging 
set activeflag=0,updatedon=now(),updatedby='CJAMS-66919'
where intakenumber ='I261013998130' and activeflag=1;
