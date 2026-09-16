/*
   Issue Description: CDM-30676
   Category/ Module  : approval inbox
   Root cause:  Still appearing in user's inbox.

   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Data fix: Updating activeflag to 0 in the routing table for the servicerequest
*/



	
update routing
set activeflag=0, updatedon =now(), updatedby = 'CDM-30676'
where routingid='574eb7ed-2d79-401a-9b6f-39c66e6a6aeb';
