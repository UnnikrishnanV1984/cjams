/*
   Issue Description: CDM-16061
   Category/ Module  : case removal
   Root cause: user wants to remove 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   user is asking to reopen the service case and remove the end date for OOH program assignment  */


   UPDATE servicecase 
	SET statustypekey ='Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-16061',updatedon = now() 
	WHERE servicecaseid = 'c3bdb45f-77ee-4326-9b51-7d86f3239546';

	update servicecasedisposition 
	set activeflag = 0, updatedby = 'CDM-16061',updatedon = now() 
	where servicecasedispositionid in ('c57aa151-a626-4806-bbda-42cca8c53329', 'd673f31c-05d7-4955-9db4-72345c6bf91d');

	update personprogramarea 
	set enddate = null, updatedby = 'CDM-16061', updatedon = now() 
	where personprogramid = 'e9d3443e-f18a-43d5-be56-dc07b77ddb71';