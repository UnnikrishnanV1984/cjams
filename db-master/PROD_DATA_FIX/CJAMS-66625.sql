/*
   Issue Description: CJAMS-66625
   Category/ Module  :  Requested to  remove the YTP from Approval Inbox of sherrie.simmons@maryland.gov
   Root Cause: User Wants to Remove YTP approval request from Approval Inbox of sherrie.simmons@maryland.gov
   Fix provided: Data fix has been done to remove case from case pending dashboard
   Pull request for code fix: 
   Reason why no related code fix: 
   
*/


update routing set activeflag =0, updatedby = 'CJAMS-66625',
 updatedon = now() where routingid  ='d308ea5e-9bf7-49cc-8ba2-66b2a4050f90' and eventcode ='YTP';