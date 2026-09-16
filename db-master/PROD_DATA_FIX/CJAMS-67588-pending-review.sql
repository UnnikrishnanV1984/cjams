/*
   Issue Description: CJAMS-67588
   Root cause: User requested to show Intake in in-progress on pending review dashboard
   Fix Provided : Data fix is done to show Intake in in-progress on pending review dashboard
   Pull request# for code fix:  N/A
*/

update intakedastaging 
set status='pending', updatedby ='CJAMS-67588', updatedon =now()
where intakenumber ='I261013947397' and activeflag =1;