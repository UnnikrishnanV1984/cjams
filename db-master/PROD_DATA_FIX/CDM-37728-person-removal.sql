/*
   Issue Description: CDM-37728
   Category/ Module  : person
   Root cause: User requested to remove Need to remove CJAMS PID # 200934286 (Annaliese Stein) from Person tab and the Investigation finding associated with it.
   Fix Privided: Did data fix to remove the Annaliese Stein from persons and also the investigation findings  
*/

update cjams.actor 
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-37728'
where actorid ='042a3f4e-c0bf-45a4-b04a-0795fa6057a0'
and intakeserviceid='57e3d75e-404f-421f-aa37-b1d598a1eeb5';

update cjams.intakeservicerequestactor  
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-37728'
where intakeservicerequestactorid = '90a2f2a0-4358-47b9-b2ac-e649705d9a9c';

update cjams.personrole   
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-37728'
where personroleid  = '6952dcb6-9523-4088-b361-e62733024acb';

update cjams.actorrelationship 
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-37728'
where actorrelationshipid = '56a1b4ae-4e05-4d0a-929e-1ecf1e8a0a29';

update Investigationmaltreatmentactor 
SET activeflag = 0, 
	updatedon = now(), 
	updatedby = 'CDM-37728' 
where maltreatmentid = '71eb8829-fb6e-4c30-a16a-aa046ff575fb';

update personprogramarea 
SET activeflag = 0, 
	updatedon = now(), 
	updatedby = 'CDM-37728' 
where personprogramid = '1aa193c7-8dfe-4baf-b83f-055210c28bad';

update personroletype 
SET activeflag = 0, 
	updatedon = now(), 
	updatedby = 'CDM-37728' 
where personroletypeid = 'c9d99ed0-ce9a-4a7d-8c0a-dd28f7c16822';