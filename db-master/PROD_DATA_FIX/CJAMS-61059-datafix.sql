/*
Issue Description: CJAMS-61059 
Category/Module: Please remove two people from case
Root cause: User requested to remove the Clients from the case:
DELEON UNKNOWN - 204186870
LAMONT SMITH - 204186864
Fix provided: Data fix has been done to to remove the Clients from the case:
DELEON UNKNOWN - 204186870
LAMONT SMITH - 204186864
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A 
Reason why no related code fix: Data fix needed to correct the user entry error
*/

--DELEON UNKNOWN - 204186870

update intakeservicerequestactor
set activeflag = 0, updatedby = 'CJAMS-61059', updatedon = now()
where personid ='e87f28c2-355a-4d76-89de-90a51b5128ad' and activeflag = 1;

update actor
set activeflag = 0, updatedby = 'CJAMS-61059', updatedon = now()
where personid ='e87f28c2-355a-4d76-89de-90a51b5128ad' and activeflag = 1;

update cjams.actorrelationship a2 
set activeflag = 0,
updatedon = now(),
updatedby = 'CJAMS-61059'
where intakeservicerequestactorid in ('828e24db-9204-4bb7-8f86-ce8e43f46682',
'e8a84fa3-3b05-426d-b052-862878d22f6d','6bfa7bdd-6e2a-46f3-a7c7-d6542c21b049');

update personrole
set activeflag = 0, updatedby = 'CJAMS-61059', updatedon = now()
where personid ='e87f28c2-355a-4d76-89de-90a51b5128ad' and activeflag = 1;

update personroletype
set activeflag = 0, updatedby = 'CJAMS-61059', updatedon = now()
where personroleid in ('03564208-f86f-4ecc-8eee-1cd2b236c1eb','154105e1-b386-4039-9594-54a88c0b45b2') and activeflag = 1;

--LAMONT SMITH - 204186864

update intakeservicerequestactor
set activeflag = 0, updatedby = 'CJAMS-61059', updatedon = now()
where personid ='4cf92e98-9f0c-4c09-bda5-7da7724660fd' and activeflag = 1;

update actor
set activeflag = 0, updatedby = 'CJAMS-61059', updatedon = now()
where personid ='4cf92e98-9f0c-4c09-bda5-7da7724660fd' and activeflag = 1;

update cjams.actorrelationship a2 
set activeflag = 1,
updatedon = now(),
updatedby = 'CJAMS-61059'
where intakeservicerequestactorid in ('f3d82149-bfb0-4587-8ce0-aa5ae06d032e',
'a379e318-72cb-4db8-8cac-c9ec4e8d4859','6a72c122-8ce3-4d98-a3f8-855b68015065');

update personrole
set activeflag = 0, updatedby = 'CJAMS-61059', updatedon = now()
where personid = '4cf92e98-9f0c-4c09-bda5-7da7724660fd'and activeflag = 1;

update personroletype 
set activeflag = 0, updatedby = 'CJAMS-61059', updatedon = now()
where personroleid in ('6715662a-44d1-42de-94e0-43f66c2471a8','edf298c7-fe77-45c2-9751-b6600048c74f')and activeflag = 1;

