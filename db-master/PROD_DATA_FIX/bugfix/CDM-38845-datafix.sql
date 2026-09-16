/* 
    Issue Description: CDM-38845
  Category/ Module  : Services: Service Plan
  Root cause: remove the  service plan as requested.
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: 
  Backup before update/ delete: 
*/

update serviceplan set activeflag ='0', updatedby ='CDM-38845', updatedon =now() 
where serviceplanid='7f873e10-17c9-4bcb-ab64-320b4141889b';