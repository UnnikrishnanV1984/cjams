/*
   Issue Description: CJAMS-68736
   Category/ Module  :  Requested to  remove the case from Approval Inbox of amanda.bates2@maryland.gov
   Root Cause:  case is closed before the case connect is approved so the review request is stuck in the supervisor approval inbox,Removed case from  approval request from Approval Inbox of amanda.bates2@maryland.gov
   Fix provided: Data fix has been done to remove case from case pending dashboard
   Is code fix required: N
   Pull request for code fix: 
   Reason why no related code fix: 
   
*/


update routing set activeflag =0, updatedby = 'CJAMS-68736',
updatedon = now() where routingid  ='895439e3-6dfb-4ed9-a384-a462a01bee0e' and eventcode ='SCCR';