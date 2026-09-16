/*
   Issue Description: CDM-19099
   Category/ Module  : Open service case
   Root cause: user wants open case and assign to supervisor and delete the record.
   Pull request# for code fix: 4740
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/

UPDATE servicecase 
SET statustypekey = 'Open', 
	dispositioncode = 'Open', 
	enddate = null, 
	updatedby = 'CDM-20064',
	updatedon = now() 
WHERE servicecaseid = '1ff67964-e01a-41ba-aa80-4f07d3782fc6';

UPDATE servicecasedisposition 
SET activeflag = 0, 
	updatedby = 'CDM-20064',
	updatedon = now() 
WHERE servicecasedispositionid = 'c6a7ddc8-287b-4db6-afbf-77a1bd2f3aad';