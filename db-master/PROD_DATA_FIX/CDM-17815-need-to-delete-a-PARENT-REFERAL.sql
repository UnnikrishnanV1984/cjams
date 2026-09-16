/*
   Issue Description: CDM-17815
      Category/ Module  :  need to delete parent referal 
   Root cause: USER ASKED TO REMOVE 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update cjams.actor 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-17815'
	where actorid = '25568f5a-4e78-4b23-af12-360df0e51438';

	update cjams.intakeservicerequestactor
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-17815'
	where intakeservicerequestactorid = '655b497e-cdca-4c24-9d28-4edc048a5ab9';

	update cjams.personrole p  
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-17815'
	where personroleid = '8970acbb-2cea-49da-9df8-4d01cad3860f';

	update cjams.actorrelationship a2 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-17815'
	where actorrelationshipid = '430c8d8a-fb30-485a-b3fe-68093d61d733';