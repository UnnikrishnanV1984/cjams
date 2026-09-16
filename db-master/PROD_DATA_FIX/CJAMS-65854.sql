/*
   Issue Description: CJAMS-65854
   Category/ Module  : Persons
   Root cause: User not able to change HOH flag for clients (Jasmine Herrera (PID 3795699) & Michael Hamlin's (PID 200670989). There is an issue in code which to assign HOH flag 
			   As part of Expungement changes add new column 'isexpunged' to intakeservicerequestactor table. This column need be added to intakeservicerequestactor_history table as well, which is missing in prod and causing issues
   Fix provided: Datafix to correct the HOH as requested by user.
   Regression Impacts: N/A
   Pull request# for code fix: CIDM-11118
   Reason why no related code fix: Code required and raised as part of CIDM-11118
   Status of the code fix if already submitted and expected prod fix date: March 19th
*/
-- Remove HOH
update cjams.intakeservicerequestactor 
	set isheadofhousehold = false,
		intakeservicerequestpersontypekey = 'OtherADULT',
		updatedby = 'CJAMS-65854',
		updatedon = now() 
	where  intakeservicerequestactorid in ('20a000e0-a593-4005-99b6-730442593056');

-- Add HOH
update cjams.intakeservicerequestactor 
	set isheadofhousehold = true,
		updatedby = 'CJAMS-65854',
		updatedon = now() 
	where  intakeservicerequestactorid in ('c036ce07-66c4-463d-97e9-67e3713a48b9');