/*
   Issue Description: CDM-18337
   Category/ Module  :  deuplicate perm plan
   Root cause: user asked to remove dup perm plan
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE permanencyplan
	set activeflag = 0, updatedby = 'CDM-18337', updatedon = now()
	WHERE permanencyplanid = '0bb71968-b2e1-4c44-bb8e-cad212b36de4';