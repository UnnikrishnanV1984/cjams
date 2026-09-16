/*
Issue Description: CJAMS-63551
Category/Module: Delete referrals
Root cause: User requested to remove the intake referrals I251013370747, I251013414463
Fix provided: Data fix has been promoted to remove the intake referrals I251013370747, I251013414463
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: Data fix 
*/


UPDATE intakedastaging  SET activeflag=0, updatedby='CJAMS-63551', updatedon=now()
 where intakenumber in ('I251013370747','I251013414463')
 and activeflag=1;

UPDATE intakedastatus SET activeflag=0, updatedby='CJAMS-63551', updatedon=now() 
where intakenumber in ('I251013370747','I251013414463')
and activeflag=1; 
