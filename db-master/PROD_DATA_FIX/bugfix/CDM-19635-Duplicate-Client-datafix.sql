-- CDM-19635 - Delete other contacts
/*
-- Issue Description: 
	Case #3306733: delete the persons listed on other contact: Anthony Wrong Cephas
	
-- Category/ Module:  Person
-- Root cause: User Request

-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

--Delete from actor
select 	activeflag, * from actor
where 	activeflag = 1 and actorid = '10f74ef4-3cf0-479c-b7a0-1ac2151cf3d4';

update 	cjams.actor 
set 	activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-19635'
where 	activeflag = 1 and actorid = '10f74ef4-3cf0-479c-b7a0-1ac2151cf3d4';

--delete from intakeservicerequestactor
select 	activeflag, * 
from 	intakeservicerequestactor 
where 	intakeservicerequestactorid = '24f809f1-038a-4d31-806a-06d5da3e0a1e';

update 	intakeservicerequestactor 
set 	activeflag = 0,
		updatedby = 'CDM-19635',
		updatedon = now()
where 	activeflag = 1 and intakeservicerequestactorid = '24f809f1-038a-4d31-806a-06d5da3e0a1e';

--Delete from Personrole
select 	* 
from 	personrole 
where 	activeflag = 1 and personroleid = '476993d7-af47-4737-8ba2-f470ea77bc67';

update 	cjams.personrole  
set 	activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-19635'
where 	activeflag = 1 and personroleid = '476993d7-af47-4737-8ba2-f470ea77bc67';

--Delete from Personprogramarea
select  programkey,activeflag, * from personprogramarea 
where 	personprogramid = 'ba681d09-072b-4336-a401-a1ea0ce59887';

update 	personprogramarea
set 	activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-19635'
where 	personprogramid = 'ba681d09-072b-4336-a401-a1ea0ce59887';