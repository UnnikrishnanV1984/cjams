/*
   Issue Description: CDM-17771
   Category/ Module  : Persons
   Root cause: user asked to rupdated
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update cjams.actor 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-17771'
	where actorid in ('eeceb0a0-d280-46fb-b581-de4fe491d9c1','5edded50-c3c1-4927-ab0a-4da72b5b1d74','575366b6-3753-4efa-adb3-2aee6276423d');

	update cjams.intakeservicerequestactor
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-17771'
	where intakeservicerequestactorid in ('29701575-9deb-42d6-9478-9dbc108eb6b4', 'f793f114-132c-4dfb-b5dc-f32dda534da4', '5515aad4-0a54-4290-bd38-4c48039189e2');

	update cjams.personrole p  
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-17771'
	where personroleid in ('eb87b092-5c99-4b2e-8664-c71aa7725309','424ce992-53b8-4c9f-a2ca-34a7c7b04910','4cd1be49-aabf-4c91-9526-fcbe00ca8049');

	update cjams.actorrelationship a2 
	set activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-17771'
	where intakeservicerequestactorid in ('29701575-9deb-42d6-9478-9dbc108eb6b4', 'f793f114-132c-4dfb-b5dc-f32dda534da4', '5515aad4-0a54-4290-bd38-4c48039189e2');
