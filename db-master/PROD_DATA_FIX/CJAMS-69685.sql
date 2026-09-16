/*
   Issue Description: CJAMS-69685
   Category/ Module  :  Requested to  remove the case from Approval Inbox of Rebecca Glotfelty
   Root Cause: There is an active routing record  still in a pending-review status for this case's "Case Connect Review" event — it was never deactivated or moved to a completed routing status when the review/approval finished. 
   Fix provided: Data fix has been done to remove case from case pending dashboard
   Is code fix required: N
   Pull request for code fix: 
   Reason why no related code fix: Issue is not replicable, it might be because the case is closed before the case connect is approved so the review request is stuck in the supervisor approval inbox  
   
*/


update routing set activeflag =0, updatedby = 'CJAMS-69685',
updatedon = now() where routingid  ='e628dc8a-6414-4753-a487-9c545821fce5' and eventcode ='SCCR';