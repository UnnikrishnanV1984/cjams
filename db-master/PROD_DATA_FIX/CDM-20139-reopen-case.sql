/*
   Issue Description: CDM-20139
   Category/ Module  :  Reopen service case
   Root cause: user asked to reopen service case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE servicecase 
	SET statustypekey = 'Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-20139',updatedon = now() 
	WHERE servicecaseid = '70b83e89-770b-45a9-b33c-e2c5893dd6c1';

	update servicecasedisposition 
	set activeflag = 0, updatedby = 'CDM-20139',updatedon = now() 
	where servicecasedispositionid = 'd635282f-1028-4875-bbf6-c11650311518';

	update personprogramarea set enddate = null, updatedby = 'CDM-20139', updatedon = now() 
	where personprogramid = 'abd9af50-6557-4982-9c80-fc1df9fc69c3' and activeflag =1;