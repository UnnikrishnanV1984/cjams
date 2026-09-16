/*
   Issue Description: CDM-16473
   Category/ Module  :  
   Root cause: Removing pending Records
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

--objectID 1c77094f-e592-4d04-b153-249969ff9411
update routing set activeflag = 0, updatedby = 'CDM-16473', updatedon = now() where routingid = 'f9ae4226-f908-40da-a393-3ba0abdb9ba7';
