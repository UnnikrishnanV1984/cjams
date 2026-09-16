/*
   Issue Description: CJAMS-59784 Override approving supervisor
   Category/ Module  : Service log
   Root cause: System error, After the supervisor override the intake, 
   system was overriding the all the routing records with the latest updated user.
   Fix Provided: Data fix to update the updated by user with correct user.
*/

update routing 
set updatedby = '47dc653d-9089-4b47-b40e-0168ef6c2321',
	updatedon = now()
where routingid = '8b0c0266-7f9c-4ee4-9345-a044c5e36f83' 
and fromsecurityusersid = '1896c89c-3894-44b7-aefc-b1c2a5daf596';