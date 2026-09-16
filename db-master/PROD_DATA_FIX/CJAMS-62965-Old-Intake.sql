/*
Issue Description: A referral from 2018 reappeared in my pending intake referrals. Please delete.
Root cause: User requested to delete intake from the supervisor intake approval dashboard 
Fix provided: update into routing,intakedastatus,intakedastaging,intakesnapshot table
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A 
Reason why no related code fix: User Error.
*/


update intakedastaging
set status = 'Complete',updatedby='CJAMS-62965',updatedon=now()
where intakenumber = 'CW10079252' and activeflag = 1;