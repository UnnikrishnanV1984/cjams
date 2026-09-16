/*
   Issue Description: CDM-16473
   Category/ Module  :  
   Root cause: removing the Pending Placement
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update routing set activeflag = 0, updatedon = now(), updatedby = 'CDM-16473' where routingid = 'd99352bb-e03b-492a-8fab-9a3f9fefb152';