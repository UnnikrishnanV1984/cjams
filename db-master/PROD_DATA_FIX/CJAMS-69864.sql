/*

Issue : ERROR
Root Cause : The guardianship application was rejected first, then corrected and
approved on the same day. The old rejection was never closed and is still live, so
the application carries two statuses at once - Rejected and Approved. The Subsidy
Rate screen reads only one of them and picks up the old Rejected, so it thinks the
application is not done and keeps asking the user to complete it.
Fix Provided  : Close the old rejection so only the current Approved status stays
live. The screen then sees the application as approved and lets the user continue.
Datafix/Code fix ticket : CJAMS-69864
Regression impacts: N 
Is code fix required: N
Why no code fix is required: we have already made a code fix for this, but this is existing record so proceed with the data fix     
 */



UPDATE routing
   SET activeflag = 0,
       updatedby  = 'CJAMS-69864'
 WHERE routingid = '0b767545-7fea-4452-815c-7aba19f7355d'
   AND activeflag = 1;


