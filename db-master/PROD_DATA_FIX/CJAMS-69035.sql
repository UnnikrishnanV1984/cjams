/*
   Issue Description: CJAMS-69035
   Category/ Module  :  Requested to  remove the YTP from Approval Inbox of Veronica Bello
   Root Cause: User Wants to Remove YTP approval request from Approval Inbox of Veronica Bello
   Fix provided: Data fix has been done to remove case from case pending dashboard
   Is code fix required: N 
   Pull request for code fix: 
   Reason why no related code fix: 
   
*/


update routing set activeflag =0, updatedby = 'CJAMS-69035',
updatedon = now() where routingid  ='da350ea4-d3c2-440f-a27f-ee14202e6137' and eventcode ='YTP';