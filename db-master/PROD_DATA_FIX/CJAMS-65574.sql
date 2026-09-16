/*
   Issue Description: CJAMS-65574
   Category/ Module  : Persons
   Root cause: User not able to assign HOH flag for client (JACKELINE YESENIA ARROYO / PID# 4308183). There is an issue in code which to assign HOH flag 
			   As part of Expungement changes add new column 'isexpunged' to intakeservicerequestactor table. This column need be added to intakeservicerequestactor_history table as well, which is missing in prod and causing issues
   Fix provided: Datafix to correct the HOH as requested by user.
   Regression Impacts: N/A
   Pull request# for code fix: CIDM-11118
   Reason why no related code fix: Code required and raised as part of CIDM-11118
   Status of the code fix if already submitted and expected prod fix date: March 19th
*/

update cjams.intakeservicerequestactor 
	set isheadofhousehold = true,
		updatedby = 'CJAMS-65574',
		updatedon = now() 
	where  intakeservicerequestactorid in ('5649d945-1a1a-4848-9b04-76e1c9ba3294');
	
