/*
Issue Description:CJAMS-66096 
Category/Module: Person Profile
Root cause: user not able to change role for client (Araeyah Love / PID# 200916252). There is an issue in code which is blocking to change role 
Fix provided: Data fix has been done to change the role from Other Child to Child and delete relative role for the client (Araeyah Love / PID# 200916252)
Regression Impacts: N/A
Is Code fix Required?: Yes. As part of Expungement changes add new column 'isexpunged' to intakeservicerequestactor table. This column need be added to intakeservicerequestactor_history table as well
Code fix ticket#: CIDM-11118
Reason why no related code fix: NA
*/

update cjams.intakeservicerequestactor 
	set intakeservicerequestpersontypekey  = 'CHILD',
		updatedby = 'CJAMS-66096',
		updatedon = now()
	where intakeservicerequestactorid = '1c0bce37-5ed4-4820-8b2b-620c6175e495';
	
update cjams.intakeservicerequestactor 
	set activeflag  = 0,
		updatedby = 'CJAMS-66096',
		updatedon = now()
	where intakeservicerequestactorid = '9bd74a4b-3312-463a-ad8e-767baadf5d5c';