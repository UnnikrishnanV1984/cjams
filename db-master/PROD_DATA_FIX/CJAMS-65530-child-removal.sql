/*
   Issue Description: CJAMS-65530
   Category/ Module  : person
   Root cause: User requested to remove CJAMS PID # 204780151 (Greyson Belote) from the case 261023632419 as it was added by user in mistake
   Fix Privided: Did data fix to remove the CJAMS PID # 204780151 (Greyson Belote) from the case 261023632419
*/

update cjams.actor 
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CJAMS-65530'
where actorid ='a350c67e-59eb-48e9-9fef-ea5cb273fd05'
and intakeserviceid='58d73ba7-6858-4d3b-b4ab-4913c3ecdd2b';

-- select * from intakeservicerequestactor where actorid='a350c67e-59eb-48e9-9fef-ea5cb273fd05' and intakeservicerequestactorid='42957d72-2ca7-4f5b-843f-7fc5e89edab1';

update cjams.intakeservicerequestactor  
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CJAMS-65530'
where intakeservicerequestactorid = '42957d72-2ca7-4f5b-843f-7fc5e89edab1';

-- select * from personrole where personid='e22d3f75-85ae-4a0a-b5b2-a481747d808d' and intakeserviceid='58d73ba7-6858-4d3b-b4ab-4913c3ecdd2b';

update cjams.personrole   
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CJAMS-65530'
where personroleid  = 'd546e8ba-ae39-4301-ab93-1fff9d6d08e8';

-- select * from actorrelationship where intakeservicerequestactorid='42957d72-2ca7-4f5b-843f-7fc5e89edab1';

update actorrelationship
SET activeflag = 0, 
	updatedon = now(), 
	updatedby = 'CJAMS-65530'
where intakeservicerequestactorid='42957d72-2ca7-4f5b-843f-7fc5e89edab1'
and intakeserviceid = '58d73ba7-6858-4d3b-b4ab-4913c3ecdd2b'
and activeflag = 1;

-- select * from investigationmaltreatmentactor where intakeservicerequestactorid='42957d72-2ca7-4f5b-843f-7fc5e89edab1';

-- select * from personprogramarea where personid='e22d3f75-85ae-4a0a-b5b2-a481747d808d' and objectid='58d73ba7-6858-4d3b-b4ab-4913c3ecdd2b';

update personprogramarea 
SET activeflag = 0, 
	updatedon = now(), 
	updatedby = 'CJAMS-65530' 
where personprogramid = '560ac16b-5041-4ed7-a2bf-24d0d50ead25';

-- select * from personroletype where personroleid  = 'd546e8ba-ae39-4301-ab93-1fff9d6d08e8';;

update personroletype 
SET activeflag = 0, 
	updatedon = now(), 
	updatedby = 'CJAMS-65530' 
where personroletypeid = '111ab5a9-b261-48f6-81d8-3a622cecf5bd';