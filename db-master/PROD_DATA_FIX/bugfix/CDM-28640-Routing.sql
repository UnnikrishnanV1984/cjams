

/*
   Issue Description: CDM-28640
   Category/ Module  :Routing 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update cjams.routing set activeflag =0, updatedby ='CDM-28640', updatedon = now()

where routingid ='8ac5fae6-4cbc-4a85-a617-a267f60ae254';