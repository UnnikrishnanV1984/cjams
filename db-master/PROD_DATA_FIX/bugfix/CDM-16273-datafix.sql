/*
   Issue Description: CDM-16273
   Category/ Module  : CW-Court Order
   Root cause: actorids are missing in the court order
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update 	intakeservreqcourtorder
set 	intakeservicerequestactorid = '629ad828-bdfe-46d2-93d2-4648baa467e2', 
		updatedby = 'CDM-16273', 
		updatedon = now()
where 	intakeservicerequesthearingid in ('f0979f1f-8997-489a-ac0b-1bf96d06a555',
		'47b72393-d42f-45d6-8077-1f95ece047a7',
		'cb4467e3-98ad-4dc6-bd3b-bf4c26d7a662',
		'47b72393-d42f-45d6-8077-1f95ece047a7',
		'f3322677-a127-4ccf-aa34-f243d5879134');