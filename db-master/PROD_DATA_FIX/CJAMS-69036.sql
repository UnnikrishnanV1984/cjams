/*
   Issue Description: CJAMS-69036
   Category/ Module  :  Requested to  remove the case from Approval Inbox of georgina.atueyi@maryland.gov
   Root Cause: There is an active routing record  still in a pending-review status for this case's "Case Connect Review" event — it was never deactivated or moved to a completed routing status when the review/approval finished. 
   Fix provided: Data fix has been done to remove case from case pending dashboard
   Is code fix required: N
   Pull request for code fix: 
   Reason why no related code fix: Issue is not replicable, it might be because the case is closed before the case connect is approved so the review request is stuck in the supervisor approval inbox  
   
*/


update routing set activeflag =0, updatedby = 'CJAMS-69036',
updatedon = now() where routingid  ='a91ac4c0-710e-4212-a4da-ec2d46308259' and eventcode ='SCCR';