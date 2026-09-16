/*
   Issue Description: CDM-15467
   Category/ Module  : case closure
   Root cause: user wants to close
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   backup data: 
		UPDATE servicecase 
		SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2021-07-19 00:00:00', updatedby = 'CDM-15467',updatedon = now() 
		WHERE servicecaseid = 'e07639c9-0add-48d2-b111-6e592b6441ab';

		update servicecasedisposition set activeflag = 1	where servicecasedispositionid = 'fc71b526-b15e-409e-9e9d-eed592cb6e74';
*/



	UPDATE servicecase 
	SET statustypekey ='Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-15467',updatedon = now() 
	WHERE servicecaseid = 'e07639c9-0add-48d2-b111-6e592b6441ab';

	update servicecasedisposition 
	set activeflag = 0, updatedby = 'CDM-15467',updatedon = now() 
	where servicecasedispositionid = 'fc71b526-b15e-409e-9e9d-eed592cb6e74';