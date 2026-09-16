/*
  Issue Description: CDM-30571 - Missing service case
  Root cause: Service case is not being populated .
  Fix provided : Upon pasing the required param to the creteservice able to 
  see the service case in jump server
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/

select * from cjams.createservicecase('e2b90db0-2a90-497d-acf8-7d96f3c111e1'::uuid, '', 1, 'fc251376-8745-4381-a750-6a617c748678'::character varying,'ASSGN','CDM-30571');