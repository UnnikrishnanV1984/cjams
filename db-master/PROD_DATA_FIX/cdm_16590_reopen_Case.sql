/*
   Issue Description: CDM-16590
   Category/ Module  :  re open case
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix: 
   
*/

UPDATE servicecase 
	SET statustypekey = 'Open', 
		dispositioncode = 'Open', 
		enddate = null, 
		updatedby = 'CDM-16590',
		updatedon = now() 
	WHERE servicecaseid = '7365d7a0-cdc2-4a04-9cb6-81e7fe13d37e';

	UPDATE servicecasedisposition 
	SET activeflag = 0, 
		updatedby = 'CDM-16590',
		updatedon = now() 
	WHERE servicecasedispositionid = '9d9fe58a-f53f-428b-95f2-37ed78619274';