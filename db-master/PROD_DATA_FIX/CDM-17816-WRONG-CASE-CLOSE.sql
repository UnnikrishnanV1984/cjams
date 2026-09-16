/*
   Issue Description: CDM-17816
   Category/ Module  :  wrong case close
   Root cause: USER ASKED TO REMOVE 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE servicecase 
	SET statustypekey = 'Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-17816',updatedon = now() 
	WHERE servicecaseid = '55b4c3a5-2d1d-4e38-8ab9-dba66c05b584';

	update servicecasedisposition 
	set activeflag = 0, updatedby = 'CDM-17816',updatedon = now() 
	where servicecasedispositionid = 'f0650f8b-7295-4a7c-8252-123c9898cb51';

	update personprogramarea set enddate = null, updatedby = 'CDM-17816', updatedon = now() 
	where personprogramid = '24915ffc-6eb1-4407-88aa-9b6e2ec99728';
