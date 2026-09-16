/*
  Issue Description: CJAMS-64353
  Category/ Module : Persons
  Root cause: The person was added incorrectly in the intake. Data fix needed to remove the person from this intake I261013658989.
  Fix Provided: Data fix has been done to remove the person from intake
  Regression Impacts: N/A
  Is Code fix needed: No
  Code fix ticket # : N/A
  Reason why no related code fix: Data entry error and data fix needed.
*/
-- CJAMS PID#:200163569 (f0d35360-c8f3-4186-af77-42a70047efd4)

 
--Removing person from intake 
update cjams.actor 
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CJAMS-64353'
where personid = 'f0d35360-c8f3-4186-af77-42a70047efd4'
	and intakenumber = 'I261013658989'
	and activeflag = 1;


update cjams.intakeservicerequestactor  
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CJAMS-64353'
where intakeservicerequestactorid in ('e17c923d-67d0-4e47-9892-1f164031a74e')
and activeflag=1;

update personroletype 
SET activeflag = 0, 
	updatedon = now(), 
	updatedby = 'CJAMS-64353' 
where personroleid in ('b7d6aafa-2626-43fa-a3e8-08ede52b50bf')
and activeflag=1;

update cjams.personrole   
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CJAMS-64353'
where personroleid  in ('7ea36927-595c-4f38-8a80-b6144526cc22')
and activeflag=1;

update cjams.actorrelationship 
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CJAMS-64353'
where actorrelationshipid in ('3a30806a-9427-42b7-9069-718712362544', 'd0e8d1e4-d207-4ae6-9636-57aa435db067')
and activeflag=1;





