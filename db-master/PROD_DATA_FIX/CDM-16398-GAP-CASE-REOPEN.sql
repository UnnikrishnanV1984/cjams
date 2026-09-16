/*
   Issue Description: CDM-16398
   Category/ Module  :  case reopen
   Root cause: user asked to reope the service case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

/*      backup
		No OOH Program area for the case			
		Service Case ID : '8147e621-d1fa-4e7e-90df-9a068887dfa7';
		Previsous statustypekey : 'Closed'
		Service Disposition ID: '9d8b6a42-3620-40af-914f-6977127b880c';
	*/

	UPDATE servicecase 
	SET statustypekey ='Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-16398',updatedon = now() 
	WHERE servicecaseid = '8147e621-d1fa-4e7e-90df-9a068887dfa7';

	update servicecasedisposition 
	set activeflag = 0, updatedby = 'CDM-16398',updatedon = now() 
	where servicecasedispositionid = '9d8b6a42-3620-40af-914f-6977127b880c';