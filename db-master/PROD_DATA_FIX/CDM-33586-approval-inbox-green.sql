/*
  Issue Description:  CDM-33586
   Category/ Module  :  Dashboard
   Root cause: Supervisor name not showing in approval inbox
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update  teammember set roletypekey ='CWSP' ,updatedby ='CDM-33586',updatedon  =now()where teammemberid ='e799297c-22a5-4ce8-9897-1cf9bc683d68';