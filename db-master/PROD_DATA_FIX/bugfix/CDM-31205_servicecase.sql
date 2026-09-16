/*
  Issue Description: CDM-31185- Missing service case
  Root cause: Service case is not being populated .
  Fix provided : Upon pasing the required param to the creteservice able to 
  see the service case in jump server
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/

select * from cjams.createservicecase('13fe9baf-e955-4969-8884-cc591b8e9db4','',1,'a238ffca-e9d6-49ef-bf6e-a73eb47ff8e4','ASSGN','CDM-31205');

update servicecase set insertedon ='2023-05-09 10:17:00',updatedby='CDM-31188' ,updatedon=now() where servicecaseid=(select servicecaseid from IntakeServiceRequest where intakenumber='I231010597057');
