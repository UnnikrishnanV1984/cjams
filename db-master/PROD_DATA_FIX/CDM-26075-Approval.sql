
/*
   Issue Description: CDM-26075
   Category/ Module  : Approval Inbox  
   Root cause: user requested 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update cjams.routing set activeflag =0, updatedby ='CDM-26075', updatedon = now ()

where routingid ='172406db-457f-4a25-9312-ab3deafa62b3';