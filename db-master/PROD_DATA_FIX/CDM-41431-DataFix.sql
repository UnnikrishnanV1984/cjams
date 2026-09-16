/*
  Issue Description:  CDM-41431
   Category/ Module  :  Serviceplan
   Root cause: User had deleted the service Plan
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update serviceplan 
set activeflag =1,updatedby ='CDM-41431', updatedon =now()
where serviceplanid ='1dc49854-c3c3-4189-bb56-26e8d3df0b22'
and activeflag =0;
