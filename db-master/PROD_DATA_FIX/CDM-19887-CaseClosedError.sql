/*
   Issue Description: CDM-19887
   Category/ Module  : Case closed in error.
   Root cause: user wants open case closed in error 
   Pull request# for code fix: 4695
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
UPDATE servicecase 
SET statustypekey = 'Open', 
	dispositioncode = 'Open', 
	enddate = null, 
	updatedby = 'CDM-19887',
	updatedon = now() 
WHERE servicecaseid = 'b9ae833a-b3dd-40eb-9b20-c66d691b28b4';

UPDATE servicecasedisposition 
SET activeflag = 0, 
	updatedby = 'CDM-19887',
	updatedon = now() 
WHERE servicecasedispositionid = '5c7c5d4f-9739-4b87-ab24-ce7cd3adb730';

UPDATE caseassignment 
SET enddate = null, 
	updatedby = 'CDM-19887', 
	updatedon = now() 
WHERE caseassignmentid in ('6317b089-9c5a-4caf-8613-4cfda466111c', 'ac5b8f2c-e285-47f1-a5dc-cdde52b87e1b');