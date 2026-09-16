/*
   Issue Description: CJAMS-66703
   Category/ Module:  I261013985547 - Intake Delete
   Root Cause: User requested to delete the intake as referral timed out and did not show on the dashboard. User created and completed a new referral for the same family and when user sent that referral for approval, the other referral that was lost was appeared which is no longer required.
   Fix provided: Data fix has been done by deleting the intake referral as requested by user
*/

update intakedastaging 
set activeflag =0, updatedby ='CJAMS-66703', updatedon =now()
where intakenumber ='I261013985547' and activeflag =1;

update intakedastatus  
set activeflag =0, updatedby ='CJAMS-66703', updatedon =now()
where intakenumber ='I261013985547' and activeflag =1;