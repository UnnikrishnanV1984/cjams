/*
   Issue Description: CDM-29820
   Category/ Module  : Approval Inbox
   Root cause:Please remove case from my tree, It's accidentally created
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/

update routing set activeflag = 0, updatedby = 'CDM-29820',
 updatedon = now() where routingid in ('507e007a-a5c8-48bb-adc8-1362207b1467'
,'03e5f243-5a2d-4d00-9864-65778fe19824');
