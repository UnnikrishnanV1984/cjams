/*
   Issue Description: CJAMS-68831
   Category/ Module  :  Requested to  remove the YTP from Approval Inbox of Cheryl Hess
   Root Cause: User Wants to Remove YTP approval request from Approval Inbox of Cheryl Hess
   Fix provided: Data fix has been done to remove case from case pending dashboard
   Is code fix required: N 
   Pull request for code fix: 
   Reason why no related code fix: 
   
*/


update routing set activeflag =0, updatedby = 'CJAMS-68831',
updatedon = now() where routingid  ='417dc798-2fe3-40cd-823b-8f2e5cf034be' and eventcode ='YTP';