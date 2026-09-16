/*
   Issue Description: CJAMS-66284
   Category/ Module  :  Requested to  remove the YTP from Approval Inbox of christineb.whitworth@maryland.gov
   Root Cause: User Wants to Remove YTP approval request from Approval Inbox of anne.martin1@maryland.gov
   Fix provided: Data fix has been done to remove case from case pending dashboard
   Pull request for code fix: 
   Reason why no related code fix: 
   
*/


update routing set activeflag =0, updatedby = 'CJAMS-66284',
 updatedon = now() where routingid  ='5c615565-6b45-449e-a66a-c0b5dfbe1f68' and eventcode ='YTP';