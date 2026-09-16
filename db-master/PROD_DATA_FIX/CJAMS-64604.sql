/*
Issue: CJAMS-64604 Incorrect Supervisor
Category/Module: User Profile
Root cause:  Shauneida Lowe is assigned in Sailpoint to breeana.wagner@maryland.gov but in CJAMS it is different.
Fix provided:  Data fix has been done to update the supervisor id as requested
Data/Code fix ticket#: CJAMS-64604
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data issue.
*/


update cjams.userprofile 
	set supervisorid = 'f7934bba-5c29-4d09-acfd-20467818c8cf',
		updatedon = now(),
		updatedby = 'CJAMS-64604'
	where securityusersid = 'dfcbbce7-da61-4876-b69f-a92e483bbe63'
		and activeflag = 1;