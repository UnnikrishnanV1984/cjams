/*
   Issue Description: CDM-18619
   Category/ Module  : duplicate persons
   Root cause: user asked to remove the duplicate persons
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update cjams.actor 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-18619'
	where actorid = 'eea13aa9-e973-4ef5-94e2-ff3343528322';

	update cjams.intakeservicerequestactor
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-18619'
	where intakeservicerequestactorid = 'c504b7b6-7a05-4655-9f7f-0979ec14b0bb';

	update cjams.personrole p  
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-18619'
	where personroleid = '928e2a47-9e33-4510-8a33-6cf3cd1f5292';

	update cjams.actorrelationship a2 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-18619'
	where intakeservicerequestactorid = 'c504b7b6-7a05-4655-9f7f-0979ec14b0bb';