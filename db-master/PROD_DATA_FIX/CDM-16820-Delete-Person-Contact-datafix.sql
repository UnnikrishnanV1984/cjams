-- CDM-16820 - Delete other contacts
/*
-- Issue Description: 
	3294246:please delete the persons listed on contact: Kimberly Bailey and Sabrina Curtis.
	
-- Category/ Module:  Person
-- Root cause: User Request

-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

--Delete from actor
select 	activeflag, * from actor
where 	activeflag = 1 and actorid = 'f8340b8d-6721-4dde-b3b5-a2bdbd7bc6c3';

update 	cjams.actor 
set 	activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-16820'
where 	activeflag = 1 and actorid = 'f8340b8d-6721-4dde-b3b5-a2bdbd7bc6c3';

--delete from intakeservicerequestactor
select 	activeflag, * 
from 	intakeservicerequestactor 
where 	intakeservicerequestactorid = '4902466f-0de3-4b73-b19b-9ed1f33a9a6d';

update 	intakeservicerequestactor 
set 	activeflag = 0,
		updatedby = 'CDM-16820',
		updatedon = now()
where 	activeflag = 1 and intakeservicerequestactorid = '4902466f-0de3-4b73-b19b-9ed1f33a9a6d';

--Delete from Personrole
select 	* 
from 	personrole 
where 	activeflag = 1 and personroleid = 'f704cdd0-bdf5-4646-b407-2f670db3f4d6';

update 	cjams.personrole  
set 	activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-16820'
where 	activeflag = 1 and personroleid = 'f704cdd0-bdf5-4646-b407-2f670db3f4d6';

--Delete from actorrelationship
select 	activeflag, * 
from 	actorrelationship 
where 	activeflag = 1 and actorrelationshipid = 'e5e2a83f-c232-4d2d-992b-8cedb1c2f62d';

update 	cjams.actorrelationship 
set 	activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-16820'
where 	activeflag = 1 and actorrelationshipid = 'e5e2a83f-c232-4d2d-992b-8cedb1c2f62d';