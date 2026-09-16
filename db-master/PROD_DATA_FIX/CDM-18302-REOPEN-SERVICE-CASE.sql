/*
   Issue Description: CDM-18302
   Category/ Module  :  Reopen service case
   Root cause: user asked to reopen service case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE servicecase 
	SET statustypekey ='Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-18302',updatedon = now() 
	WHERE servicecaseid = '1e69544a-8e67-4870-88da-6becaeff9811';

	update servicecasedisposition 
	set activeflag = 0, updatedby = 'CDM-18302',updatedon = now() 
	where servicecasedispositionid = '4ee76678-d569-44eb-b92f-7aa1a75d5d2b';

	update personprogramarea set enddate = null, updatedby = 'CDM-18302', updatedon = now() 
	where personprogramid in ('2c54457b-e22c-4e91-aa1a-7e5840c3aff1', '8947bb1b-c1c7-4026-8234-4c2956ae880a');