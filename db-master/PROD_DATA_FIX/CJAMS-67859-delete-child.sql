/*
   Issue Description: CJAMS-67859
   Category/ Module  : person
   Root cause: User requested to remove CJAMS PID # 3687486  (Tremaine Wilkens) from the case 261023730443 as it was added by user in mistake
   Fix Privided: Did data fix to remove the CJAMS PID # 3687486  (Tremaine Wilkens) from the case 261023730443
*/

--select * from person where cjamspid='3687486 ';

--select * from actor where personid='6084cb62-03b7-4784-bbd6-eae76d377db7' and activeflag=1;

update cjams.actor 
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CJAMS-67859'
where actorid ='e463a979-ff99-4588-a6cf-018e4914e6f1'
and intakeserviceid='5a1a2e8e-8813-4c3b-bbb5-a7e0089cc3ff';

-- select * from intakeservicerequestactor where actorid='e463a979-ff99-4588-a6cf-018e4914e6f1' and intakeservicerequestactorid='a8a4d78f-4af6-4e61-a216-63ddeed47a3c';

update cjams.intakeservicerequestactor  
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CJAMS-67859'
where intakeservicerequestactorid = 'a8a4d78f-4af6-4e61-a216-63ddeed47a3c';

-- select * from personrole where personid='6084cb62-03b7-4784-bbd6-eae76d377db7' and intakeserviceid='5a1a2e8e-8813-4c3b-bbb5-a7e0089cc3ff';

update cjams.personrole   
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CJAMS-67859'
where personroleid  = '94730ae2-56fd-4627-a393-0df687feebfa';

-- select * from actorrelationship where intakeservicerequestactorid='a8a4d78f-4af6-4e61-a216-63ddeed47a3c';

update actorrelationship
SET activeflag = 0, 
	updatedon = now(), 
	updatedby = 'CJAMS-67859'
where actorrelationshipid='d96b184f-3d4e-45a3-b9d6-9bcf243cad5f'
and intakeservicerequestactorid='a8a4d78f-4af6-4e61-a216-63ddeed47a3c'
and intakeserviceid = '5a1a2e8e-8813-4c3b-bbb5-a7e0089cc3ff'
and activeflag = 1;

-- select * from investigationmaltreatmentactor where intakeservicerequestactorid='a8a4d78f-4af6-4e61-a216-63ddeed47a3c';

-- select * from personprogramarea where personid='6084cb62-03b7-4784-bbd6-eae76d377db7' and objectid='5a1a2e8e-8813-4c3b-bbb5-a7e0089cc3ff';

update personprogramarea 
SET activeflag = 0, 
	updatedon = now(), 
	updatedby = 'CJAMS-67859' 
where personprogramid = 'a4198201-5524-4cb0-b0bf-083d5d772078';

-- select * from personroletype where personroleid  = '94730ae2-56fd-4627-a393-0df687feebfa';

update personroletype 
SET activeflag = 0, 
	updatedon = now(), 
	updatedby = 'CJAMS-67859' 
where personroletypeid = 'eb71d362-eacc-46b3-ab14-64fc857a478c';