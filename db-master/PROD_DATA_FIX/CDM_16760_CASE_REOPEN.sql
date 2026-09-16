UPDATE servicecase 
	SET statustypekey = 'Open', 
		dispositioncode = 'Open', 
		enddate = null, 
		updatedby = 'CDM-16760',
		updatedon = now() 
	WHERE servicecaseid = '1e17c8a3-1d7d-4f2a-8589-c7f93060732e';

	UPDATE servicecasedisposition 
	SET activeflag = 0, 
		updatedby = 'CDM-16760',
		updatedon = now() 
	WHERE servicecasedispositionid = '2dd2b181-5be8-4854-b2cc-fe3349773f9c';