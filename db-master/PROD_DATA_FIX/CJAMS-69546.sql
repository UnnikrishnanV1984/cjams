/*
   Issue Description: CJAMS-69546
   Category/ Module  :  Requested to  remove the YTP from Approval Inbox of Rachelle Thomas
   Root Cause:  YTP was approved but it continues to show on my approval dash board Approval Inbox of Rachelle Thomas
   Fix provided: Data fix has been done to remove the YTP was approved but it continues to show on my approval dash board
   Is code fix required: N 
   Pull request for code fix: 
   Reason why no related code fix: 
   
*/


update routing set activeflag =0, updatedby = 'CJAMS-69546',
updatedon = now() where routingid  ='c1ad0503-8c02-4814-88de-a004add0a962' and eventcode ='YTP';