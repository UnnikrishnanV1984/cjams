/*
   Issue Description: CDM-30470
   Category/ Module  : Approval Inbox
   Root cause:  Still appearing in user's inbox.

   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Data fix: Updating activeflag to 0 in the routing table for the servicerequest
*/


   
       update 	routing 
set 	activeflag = 0,
		updatedby = 'CDM-30470',
		updatedon = now()
where 	routingid = '0ba9cfd5-c834-405b-9b6e-a121f18cd25b';