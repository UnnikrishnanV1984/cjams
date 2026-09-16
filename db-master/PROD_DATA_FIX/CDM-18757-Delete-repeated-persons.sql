/*
   Issue Description: CDM-18757
   Category/ Module  :PERSONS
   Root cause: user asked to remove
      Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update cjams.actor 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-18757'
	where actorid in ('f29c1c4a-e5d6-4776-8c3d-10b5f9e5e518', '258c40fd-d340-44cd-ba16-19d950c6fca0');

	update cjams.intakeservicerequestactor
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-18757'
	where intakeservicerequestactorid in ('bfd07652-ae8c-414e-8323-e1cae1f824e3', '5acf1be6-2cc4-4166-af63-ec4177a8fccf');

	update cjams.personrole p  
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-18757'
	where personroleid in ('3f6adeaa-0e64-46ee-9ee4-5d5a61c4c137', 'c4db738f-8a21-46fb-b965-dd3bdb6ad13b');

	update cjams.actorrelationship a2 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-18757'
	where intakeservicerequestactorid in ('bfd07652-ae8c-414e-8323-e1cae1f824e3', '5acf1be6-2cc4-4166-af63-ec4177a8fccf');
