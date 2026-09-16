/* 
    Issue Description: CDM-34300
   Category/ Module  : pending approval dashboard
   Root cause: user wants to remove the approval routing from the supervisor (Elizabeth Lee) dashboard and rejected subsidy rate slab.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
update adoptioncaserevision set activeflag =0, updatedby = 'CDM-34300', updatedon = now() 
where adoptionagreementrateid = 'b840e8e2-8fdb-425e-bdf5-a064c34da014' and activeflag =1;

update routing set activeflag =0, updatedby = 'CDM-34300', updatedon = now() 
where routingid = '7b8cc3e7-aa4c-4f16-8e9d-9443580bc680'; 