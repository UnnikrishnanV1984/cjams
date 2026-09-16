/*
   Issue Description: CDM-25626
   Category/ Module  : Approval Inbox
   
   Root cause: Items approved that keep showing up under pending approval.
*/

update 	routing 
set 	activeflag = 0,
		updatedby = 'CDM-25626',
		updatedon  = now()
where 	routingid  = 'ba7478eb-d9b5-436d-a490-bd54d217447e';