/*
  Issue Description:  CDM-39949
   Category/ Module  :  Service plan
   Root cause: user requested to remove draft service plan version
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update serviceplan 
set activeflag = 0, updatedby = 'CDM-39949', updatedon = now()
where serviceplanid ='4862a7fa-eb0a-4c98-96e8-9ca3c5671c60' and activeflag = 1;
