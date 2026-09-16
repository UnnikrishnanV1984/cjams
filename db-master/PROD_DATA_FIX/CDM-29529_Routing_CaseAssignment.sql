/*
   Issue Description: CDM-29529
   Category/ Module  : Changing the routing table's fromsecurityusersid, tosecurityusersid
   Root cause: Case needs to be assigned to Cesar Martinez, but this case is not assigned to him or anyone in Charles County.
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/
update
	cjams.routing
set
	fromsecurityusersid = '936d2d5a-5f1c-412c-905a-a30d70a3c330',
	tosecurityusersid = '4b8d30e9-1b01-47cb-9cdf-9308451bf98a',
	updatedon = now() ,
	updatedby = 'CDM-29529'
where
	routingid = 'aea2c47b-5f21-4d4e-930a-7483c9092bfc';