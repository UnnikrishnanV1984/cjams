/*
   Issue Description: CJAMS-67904
   Category/ Module  :  Requested to  remove the YTP from Approval Inbox of shari.zouhairi@montgomerycountymd.gov
   Root Cause: User Wants to Remove YTP approval request from Approval Inbox of shari.zouhairi@montgomerycountymd.gov
   Fix provided: Data fix has been done to remove case from case pending dashboard
   Pull request for code fix: 
   Reason why no related code fix: 
   
*/


update routing set activeflag =0, updatedby = 'CJAMS-679044',
 updatedon = now() where routingid  ='37b116bc-900d-41ca-a778-d9f44f001760' and eventcode ='YTP';