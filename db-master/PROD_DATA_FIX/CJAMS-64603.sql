/*
Issue: CJAMS-64603 Incorrect Supervisor
Category/Module: User Profile
Root cause:  Tacara Brown is assigned in Sailpoint to breeana.wagner@maryland.gov but in CJAMS it is different.
Fix provided:  Data fix has been done to update the supervisor id as requested
Data/Code fix ticket#: CJAMS-64603
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data issue.
*/


update cjams.userprofile 
	set supervisorid = 'f7934bba-5c29-4d09-acfd-20467818c8cf',
		updatedon = now(),
		updatedby = 'CJAMS-64603'
	where securityusersid = '9f542812-29f1-4fdb-885d-54f14640415b'
		and activeflag = 1;