/*
   Issue Description: CJAMS-63130
   Category/ Module  : Intake
   Root cause: User requested to remove Intake referrals I241013133205 and I241010263602 from Intake worker's pending dashboard.
   Fix provided: Data fix has been done to remove Intake referrals I241013133205 and I241010263602 from Intake worker's 
   pending dashboard.
   Pull request#
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
 Need to do data fix
*/

update intakedastaging
set status = 'Closed', updatedby = 'CJAMS-63130', updatedon = now()
where intakenumber in ('I241013133205','I241012063602') and activeflag = 1;