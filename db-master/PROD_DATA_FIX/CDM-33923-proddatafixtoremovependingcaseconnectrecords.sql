/*
   Issue Description: CDM-33923
   Category/ Module  : Prod data fix to remove the pending record
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update routing set activeflag = 0, updatedby = 'CDM-33923', updatedon = now()
where routingid = 'd53a8dc7-9ae2-401f-aa27-461b0d82c224'; 