/*
  Issue Description:  CDM-41141
   Category/ Module  :  Child Removal
   Root cause: User request to Data fix remove the case from pending dashboard
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update routing set activeflag = 0, updatedby = 'CDM-41141', updatedon = now()
where  objectid = 'b8300f00-9c51-4a1b-b178-d282d47975a7' and activeflag = 1 and routingid = 'd31b6942-6f73-46cc-aa4a-6afcf2d3dbeb' ;