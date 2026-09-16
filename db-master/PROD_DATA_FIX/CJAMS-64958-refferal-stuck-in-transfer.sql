/*
Issue:CJAMS-64958 Referrals stuck in transfer phase
Root Cause:User request to delete the intake from  Assign Transfer dashboard.
           CPS Referral IDs I261013822729 and I261013658581 are both sitting in my Assign Transfer Inbox. Both have been closed/completed. 
           Referral I261013822729 was transferred back to Carroll County due to a glitch in the transfer
Fix Provided:Data fix was done remove the pending records from the transfer tables
Data/Code fix ticket#: CJAMS-64958
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Requested for data fix.
*/

update  intaketransfers 
set activeflag=0,updatedby='CJAMS-64958', updatedon= now()
where intaketransferid in ('ba3062a6-70c1-4c89-ba6b-c30fc7aad719','a096c19b-6820-426f-a5a6-9f612f461e1b') and activeflag=1;