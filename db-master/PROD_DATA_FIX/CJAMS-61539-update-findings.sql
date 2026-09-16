/*
Issue: CJAMS-61539 Incorrect Finding. 251023040684:The change in finding did not save and needs to be changed to "Unsubstantiated
Category/Module: Investigation Findings
Root cause: Findings was saved incorrectly and data fix needs to done to update from Ruled out to Unsubtantiated.
Fix provided: Data fix has been done to update the Findings from Ruled out to unsubtantiated.
Data/Code fix ticket#: CJAMS-61539
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: We got SSA approval and we are working on updating the Findings
*/
--update Ruled out to Unsubstantiated investigationfinding
 update
	investigationfinding
set
	updatedby = 'CJAMS-61539',
	updatedon = now(),
	investigationfindingtypekey = 'UD'
where
	investigationallegationid in ('ce7255e6-99ef-4798-b4d1-bf512033a761')
	and activeflag = 1;