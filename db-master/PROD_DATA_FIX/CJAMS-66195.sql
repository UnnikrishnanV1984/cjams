/*
   Issue Description: CJAMS-66195
   Category/ Module  :  Requested to  remove the YTP from Approval Inbox of anne.martin1@maryland.gov
   Root Cause: User Wants to Remove YTP approval request from Approval Inbox of anne.martin1@maryland.gov
   Pull request for code fix: 
   Reason why no related code fix: 
   
*/


update routing set activeflag =0, updatedby = 'CJAMS-66195',
updatedon = now() where routingid  in ('d65d145d-eb9d-403e-91b9-00ef10bf9fbb','6f460457-7491-4a9e-8ad5-d97e8fbd38ab','cc2d1e72-b8c5-4ec5-a99a-a6c33ae2f7b3') and eventcode ='YTP';
