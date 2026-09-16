/*
  Issue Description: CDM-26982 - Missing service case
  Root cause: Service case is not being populated .
  Fix provided : Upon pasing the required param to the creteservice able to 
  see the service case in jump server
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/

select * from createservicecase('2ac11cd3-246a-444b-afea-c117b98ff62b','',1,'7c625704-a34e-4f8a-a20d-e9c206527370','ASSGN','CDM-26982')