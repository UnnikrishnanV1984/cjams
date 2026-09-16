/*
   Issue Description: CDM-18713
   Category/ Module  : persons screen
   Root cause: user asked to remove
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update cjams.actor 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-18713'
	where actorid = '9b96dd1f-3b59-4670-9ad2-9de9126af919';

	update cjams.intakeservicerequestactor
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-18713'
	where intakeservicerequestactorid = '913741f2-50cd-4676-8a66-3f832336174e';

	update cjams.personrole p  
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-18713'
	where personroleid = '17a17266-bd63-4623-9da0-3599e21e1df0';

	update cjams.actorrelationship a2 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-18713'
	where intakeservicerequestactorid = '945997a4-8099-44de-8fc2-4d4fc0000813';