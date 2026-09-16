/*
   Issue Description: CDM-18615
   Category/ Module  : Persons tab
   Root cause: user asked to delet the person 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 

*/


update cjams.actor 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-18615'
	where actorid = '26ba16bf-d474-4e7d-8c99-371029a51df9';

	update cjams.intakeservicerequestactor
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-18615'
	where intakeservicerequestactorid in ('3467361c-5dee-4d21-ab48-2408ce9b2152', '82b096fa-f2dd-491b-ae16-56a1e1260512');

	update cjams.personrole p  
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-18615'
	where personroleid = 'c711659c-1d79-4c8c-815f-59ee441e75db';

	update cjams.actorrelationship a2 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-18615'
	where intakeservicerequestactorid in ('3467361c-5dee-4d21-ab48-2408ce9b2152', '82b096fa-f2dd-491b-ae16-56a1e1260512');


