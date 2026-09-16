/*
   Issue Description: CJAMS-66237
   Category/ Module  : Persons
   Root cause: User not able to change HOH flag for clients (Jacqueline Johns / PID# 203109854 & Jan Johns /1485464). There is an issue in code which to assign HOH flag 
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
		updatedby = 'CJAMS-66237',
		updatedon = now() 
	where  intakeservicerequestactorid in ('b82560f6-c1bb-4d12-bc16-4c2986ef5274');

-- Add HOH
update cjams.intakeservicerequestactor 
	set isheadofhousehold = true,
		updatedby = 'CJAMS-66237',
		updatedon = now() 
	where  intakeservicerequestactorid in ('25c0b0c8-c825-4406-b054-58bd50d583d0');