 /*
   Issue Description: CDM-33450
   Category/ Module  : service plan
   Root cause: Removal of Service Plan  
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
update serviceplan set activeflag=0,updatedby='CDM-33450',updatedon=now() where serviceplanid='0eb578f1-db95-49f3-8a69-9c14ef513b3e';