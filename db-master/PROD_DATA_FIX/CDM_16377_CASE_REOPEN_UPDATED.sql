
	/*
		No OOH Program area for the case			
		Service Case ID : '9ee339e2-c60d-44b9-a69a-a2bb62504245', 'b6ac15bc-4d25-4805-aea1-639e0e20c3b2';
		Previsous statustypekey : 'Closed'
		Service Disposition ID: 'b1fb2aa2-1ac0-4a2c-b8db-001f34d862fd', '8b07cf44-2a1e-49b8-9cc6-278f30e6a965';
	*/

	UPDATE servicecase 
	SET statustypekey ='Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-16377',updatedon = now() 
	WHERE servicecaseid = '9ee339e2-c60d-44b9-a69a-a2bb62504245';

	update servicecasedisposition 
	set activeflag = 0, updatedby = 'CDM-16377',updatedon = now() 
	where servicecasedispositionid = 'b1fb2aa2-1ac0-4a2c-b8db-001f34d862fd';


	UPDATE servicecase 
	SET statustypekey ='Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-16377',updatedon = now() 
	WHERE servicecaseid = 'b6ac15bc-4d25-4805-aea1-639e0e20c3b2';

	update servicecasedisposition 
	set activeflag = 0, updatedby = 'CDM-16377',updatedon = now() 
	where servicecasedispositionid = '8b07cf44-2a1e-49b8-9cc6-278f30e6a965';