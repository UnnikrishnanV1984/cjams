/*
Issue: CJAMS-64602 Incorrect Supervisor
Category/Module: User Profile
Root cause: Towanda Thomas is assigned in Sailpoint to breeana.wagner@maryland.gov but in CJAMS it is breeana.radke@maryland.gov.
Fix provided:  Data fix has been done to update the supervisor id as requested
Data/Code fix ticket#: CJAMS-64602
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data entry error.
*/


update cjams.userprofile 
	set supervisorid = 'f7934bba-5c29-4d09-acfd-20467818c8cf',
		updatedon = now(),
		updatedby = 'CJAMS-64602'
	where securityusersid = '478a8489-f46c-4dc5-a7c0-b6a960a7ba9e'
		and activeflag = 1;