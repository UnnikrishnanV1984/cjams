/*
   Issue Description: CDM-30623
   Category/ Module  : Persons missing in persons tab (Intake)
   Root cause: user wants to add persons (children) 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/

update 	intakeservicerequestactor
set 	isprimary = true,
		updatedby = 'CDM-30623', 
		updatedon = now()
where 	actorid = 'f9afa412-059b-4838-942a-1ca696073895' 
		and intakeservicerequestactorid ='da930c3f-595d-4e82-8e62-6971783d0744';
