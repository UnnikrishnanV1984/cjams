/*
   Issue Description: CDM-21547
   Customer Email ID: shellyl.neal-edwards@maryland.gov
   Category/ Module  : wrong county in pending approvals
   Root cause: user wants to remove pending approvals
   explanantion: comments say it was a re-opneded ticket which can be closed now and also in wrong county
*/

update routing  set activeflag = 0 , updatedby ='CDM-21547',updatedon = now() 
	where routingid in ('33e13436-4d0c-4cb7-bc0a-2403f9a786d8');