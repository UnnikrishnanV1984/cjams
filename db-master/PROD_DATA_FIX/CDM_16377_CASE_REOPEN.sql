/*
   Issue Description: CDM-16377
   Category/ Module  :  case reopen
   Root cause: user asked to reope the service case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

/*
		No OOH Program area for the case			
		Service Case ID : '9ee339e2-c60d-44b9-a69a-a2bb62504245';
		Previsous statustypekey : 'Closed'
		Service Disposition ID: 'b1fb2aa2-1ac0-4a2c-b8db-001f34d862fd';
	*/

	UPDATE servicecase 
	SET statustypekey ='Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-16377',updatedon = now() 
	WHERE servicecaseid = '9ee339e2-c60d-44b9-a69a-a2bb62504245';

	update servicecasedisposition 
	set activeflag = 0, updatedby = 'CDM-16377',updatedon = now() 
	where servicecasedispositionid = 'b1fb2aa2-1ac0-4a2c-b8db-001f34d862fd';