/*
   Issue Description: CDM-17635
   Category/ Module  :  reopen case
   Root cause: User asked to reopen 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


UPDATE servicecase 
	SET statustypekey ='Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-17635',updatedon = now() 
	WHERE servicecaseid = '9f0b9b8c-4a9b-4762-8572-db84d175a10a';

	update servicecasedisposition 
	set activeflag = 0, updatedby = 'CDM-17635',updatedon = now() 
	where servicecasedispositionid = '1d951849-99bb-4959-926c-8ba197a3a421';
