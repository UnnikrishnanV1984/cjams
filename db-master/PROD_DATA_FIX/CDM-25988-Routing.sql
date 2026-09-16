/*
  Issue Description:  CDM-25988
   Category/ Module  :  Approval inbox 
   Root cause: wrongly created
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
   
*/
update routing set activeflag =0, updatedby ='CDM-25988', updatedon =now()

where routingid ='9de786dd-acd0-4b50-9df0-80afcdc5a21f';



