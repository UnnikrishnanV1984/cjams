/*
   Issue Description: CDM-16367
   Category/ Module  :  service case
   Root cause: user wants to remove duplicate service case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   */


update servicecase 
	set activeflag = 0, updatedon = now(), updatedby = 'CDM-16367' 
	where servicecaseid = '457a6d81-3fee-402b-b916-a5ebed3f8a54';