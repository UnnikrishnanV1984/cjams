/* Issue Description: 3157982:This purchase authorization is pending Director approval and needs to be denied so provider 5003668 Lori Geis can be closed. Purchase Authorizations: This provider cannot be closed until all outstanding Purchase Authorizations (( Case ID: 3157982, Client ID: 1165335, Vendor ID: 5003668, Actual Begin Date: 2009-01-28, Auth ID: 51036 )) have been end-dated. 
   Category/ Module  :  Purchase authorization
   Root cause: User request, user requested to reroute the authorization approval to Charles Wood (charles.wood3@maryland.gov) from Tom Haina)
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
update routing 
set tosecurityusersid = '6454375e-959e-4345-89af-086697652393', --2d16f382-202c-4707-b1ac-c657341b5799
	updatedby = 'CJAMS-63221',
	updatedon = now()
where routingid = 'e96a7a86-7fa7-40ac-861b-dd49a3ff0907'
	and activeflag =1;