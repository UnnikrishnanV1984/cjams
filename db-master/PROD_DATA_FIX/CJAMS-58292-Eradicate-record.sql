/*
   Issue Description: CJAMS-58292,urgently remove:KNOX LOS DOB 2/23/25Cjams PID 204091726CIS 523072246from Cjams database. 
   Category/ Module  : person
   Root cause: User requested to remove Need to urgently remove:KNOX LOS DOB 2/23/25Cjams PID 204091726CIS 523072246from Cjams database.
   Fix Privided: Did data fix to remove:KNOX LOS DOB 2/23/25Cjams PID 204091726CIS 523072246from Cjams database. 
*/

UPDATE person
SET activeflag = 0,
	updatedby = 'CJAMS-58292',
	updatedon = now()
where cjamspid = '204091726'
	AND activeflag = 1;
	
update cjams.actor 
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CJAMS-58292'
where personid ='7311b79a-9688-4c52-9e88-984da66af96a'
and activeflag =1;

update cjams.intakeservicerequestactor  
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CJAMS-58292'
where personid ='7311b79a-9688-4c52-9e88-984da66af96a'
and activeflag =1;

update cjams.personrole   
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CJAMS-58292'
where personid ='7311b79a-9688-4c52-9e88-984da66af96a'
and activeflag =1;

update cjams.actorrelationship 
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CJAMS-58292'
where intakeservicerequestactorid in
('05ee64d4-2412-429c-8e7b-aaadf261bd8b',
'42d96651-c83e-466b-bc6c-2b2425d8efbe',
'cfa53c81-c074-4459-b441-d86b95709dab') 
and activeflag=1;

update personprogramarea 
SET activeflag = 0, 
	updatedon = now(), 
	updatedby = 'CJAMS-58292' 
where personid = '7311b79a-9688-4c52-9e88-984da66af96a'
and activeflag=1;

update personroletype 
SET activeflag = 0, 
	updatedon = now(), 
	updatedby = 'CJAMS-58292' 
where personroleid in ('73ba9d82-602c-474e-a398-2a42ac16178f',
'7ed6a120-d38a-4369-8e3d-a72a8b3d813e',
'2a52a54f-eef5-4ee7-be4c-52112c1158ec')
and activeflag=1;