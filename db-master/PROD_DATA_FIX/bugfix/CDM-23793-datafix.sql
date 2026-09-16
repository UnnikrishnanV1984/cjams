/*
   Issue Description: CDM-23793
   Category/ Module  : Approval Inbox
   
   Root cause: Items approved that keep showing up under pending approval.
*/

update 	routing 
set 	activeflag = 0,
		updatedby = 'CDM-23793', 
		updatedon = now()
where 	fromsecurityusersid = '8f5877b5-0601-44c4-b350-f885b5bd8789' and 
		routingid in ('d24b7695-1a60-460a-a508-f8bf5f3c5ae3');	
