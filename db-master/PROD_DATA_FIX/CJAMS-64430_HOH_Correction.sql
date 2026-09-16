/*
   Issue Description: CJAMS-64430
   Category/ Module  : Persons
   Root cause: Wrong Head of household for a closed screenout intake
   Fix provided: Datafix to correct the HOH as requested by user
   Pull request# for code fix: NA
   Reason why no related code fix: Data issue
   Status of the code fix if already submitted and expected prod fix date: NA
*/

update cjams.intakeservicerequestactor 
	set isheadofhousehold = false,
		updatedby = 'CJAMS-64430',
		updatedon = now() 
	where  intakeservicerequestactorid in ('00198d8d-3eed-495b-a4e6-92356be1deeb', '13bbdd62-bc94-4dc7-917c-dccb7eeb6eef');
	

update cjams.intakeservicerequestactor 
	set isheadofhousehold = true,
		updatedby = 'CJAMS-64430',
		updatedon = now() 
	where  intakeservicerequestactorid in ('a62ee773-a589-48dd-a1c7-d6c689a3179b');