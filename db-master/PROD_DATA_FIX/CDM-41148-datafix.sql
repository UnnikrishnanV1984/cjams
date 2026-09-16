/*
  Issue Description: CDM-41148
   Category/ Module  : Approval
   Root cause: User request to Data fix remove the case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

--241022830876

UPDATE cjams.intakeservicerequestdispositioncode
SET activeflag = 0, updatedby='CDM-41148', updatedon=now()
WHERE intakeservicerequestdispositioncodeid = '4d4cf543-b725-4ae8-9552-678185be674c';  

UPDATE cjams.caseassignment
SET activeflag = 0, updatedby='CDM-41148', updatedon=now()
WHERE caseassignmentid='11bdcf67-1c21-46a4-96cf-68c3fa3504cd';

UPDATE cjams.intakeservicerequest
set activeflag = 0, updatedby='CDM-41148', updatedon=now()
WHERE intakeserviceid='9707f74a-2e6c-48b4-9858-ccc34ace7bbd';

UPDATE cjams.routing
SET activeflag = 0
WHERE objectid = '9707f74a-2e6c-48b4-9858-ccc34ace7bbd' and activeflag = 1;

update personprogramarea set activeflag = 0, updatedby = 'CDM-41148', updatedon = now()
where objectid='9707f74a-2e6c-48b4-9858-ccc34ace7bbd' and activeflag =1;

update actor set activeflag = 0, updatedby = 'CDM-41148', updatedon = now()
where intakeserviceid='9707f74a-2e6c-48b4-9858-ccc34ace7bbd' and activeflag =1;

update intakeservicerequestactor set activeflag = 0, updatedby = 'CDM-41148', updatedon = now()
where intakeserviceid = '9707f74a-2e6c-48b4-9858-ccc34ace7bbd' and activeflag = 1;

update actorrelationship set activeflag = 0, updatedby = 'CDM-41148', updatedon = now()
where intakeserviceid='287ea177-a952-4fcd-a750-bb869a89ad54' and activeflag =1;

update personrole set activeflag = 0, updatedby = 'CDM-41148', updatedon = now()
where intakeserviceid='9707f74a-2e6c-48b4-9858-ccc34ace7bbd' and activeflag =1;

update personroletype set activeflag = 0, updatedby = 'CDM-41148', updatedon = now() where personroleid in ('c3f72103-fc1f-4311-b9e6-4b122e7202d8', '40c1ad1f-1d16-4c47-9330-ae55dc2c3ff8','b89364ce-de9d-4a0c-8a4d-2d3c0fd78ce3',
'04e41ae4-c527-4beb-977e-4cebb31e7ac0', 'd6f52def-b0ba-4090-a253-ef94933f640f');

--241022830877

UPDATE cjams.intakeservicerequestdispositioncode
SET activeflag = 0, updatedby='CDM-41148', updatedon=now()
WHERE intakeservicerequestdispositioncodeid = '26bd5774-2a13-4d63-9b50-12d2c879d60b';  

UPDATE cjams.caseassignment
SET activeflag = 0, updatedby='CDM-41148', updatedon=now()
WHERE caseassignmentid='6b696501-4fc7-4af3-8f37-b90c0395e281';

UPDATE cjams.intakeservicerequest
set activeflag = 0, updatedby='CDM-41148', updatedon=now()
WHERE intakeserviceid='287ea177-a952-4fcd-a750-bb869a89ad54';

UPDATE cjams.routing
SET activeflag = 0
WHERE objectid = '287ea177-a952-4fcd-a750-bb869a89ad54' and activeflag = 1;

update personprogramarea set activeflag = 0, updatedby = 'CDM-41148', updatedon = now()
where objectid='287ea177-a952-4fcd-a750-bb869a89ad54' and activeflag =1;

update actor set activeflag = 0, updatedby = 'CDM-41148', updatedon = now()
where intakeserviceid='287ea177-a952-4fcd-a750-bb869a89ad54' and activeflag =1;

update intakeservicerequestactor set activeflag = 0, updatedby = 'CDM-41148', updatedon = now()
where intakeserviceid = '287ea177-a952-4fcd-a750-bb869a89ad54' and activeflag = 1;

update actorrelationship set activeflag = 0, updatedby = 'CDM-41148', updatedon = now()
where intakeserviceid='287ea177-a952-4fcd-a750-bb869a89ad54' and activeflag =1;

update personrole set activeflag = 0, updatedby = 'CDM-41148', updatedon = now()
where intakeserviceid='287ea177-a952-4fcd-a750-bb869a89ad54' and activeflag =1;

update personroletype set activeflag = 0, updatedby = 'CDM-41148', updatedon = now() where personroleid in ('81fb53fa-e186-4621-8bd0-1dd37321bca2', 'd044824f-2515-4d86-b798-0e6a0f5589cc','723379ec-49e1-4441-ac3d-ade2662d6396',
'9d676184-a884-4356-82ab-24d49e5e95c5', 'f2e5a3eb-c079-4bc2-bd8d-a47dc757331c');

--241022830875

UPDATE cjams.intakeservicerequestdispositioncode
SET activeflag = 0, updatedby='CDM-41148', updatedon=now()
WHERE intakeservicerequestdispositioncodeid = 'bd36b132-bee5-4031-8c85-277a766a04dd';  

UPDATE cjams.caseassignment
SET activeflag = 0, updatedby='CDM-41148', updatedon=now()
WHERE caseassignmentid='cb5ab54a-4c3e-4374-8bf5-8740b1aa8866';

UPDATE cjams.intakeservicerequest
set activeflag = 0, updatedby='CDM-41148', updatedon=now()
WHERE intakeserviceid='fecc2c6e-4bc1-474f-bd8c-49210cf454ee';

UPDATE cjams.routing
SET activeflag = 0
WHERE objectid = 'fecc2c6e-4bc1-474f-bd8c-49210cf454ee' and activeflag = 1;

update personprogramarea set activeflag = 0, updatedby = 'CDM-41148', updatedon = now()
where objectid='fecc2c6e-4bc1-474f-bd8c-49210cf454ee' and activeflag =1;

update actor set activeflag = 0, updatedby = 'CDM-41148', updatedon = now()
where intakeserviceid='fecc2c6e-4bc1-474f-bd8c-49210cf454ee' and activeflag =1;

update intakeservicerequestactor set activeflag = 0, updatedby = 'CDM-41148', updatedon = now()
where intakeserviceid = 'fecc2c6e-4bc1-474f-bd8c-49210cf454ee' and activeflag = 1;

update actorrelationship set activeflag = 0, updatedby = 'CDM-41148', updatedon = now()
where intakeserviceid='fecc2c6e-4bc1-474f-bd8c-49210cf454ee' and activeflag =1;

update personrole set activeflag = 0, updatedby = 'CDM-41148', updatedon = now()
where intakeserviceid='fecc2c6e-4bc1-474f-bd8c-49210cf454ee' and activeflag =1;

update personroletype set activeflag = 0, updatedby = 'CDM-41148', updatedon = now() where personroleid in ('328f1380-c81a-44a3-b42a-a85a0b90244e', '724009c4-eccf-4341-966f-9f7c6c7bc0f9','8cba94b7-60f6-479f-89c0-8908048e8788',
'6166bd77-e6dd-46bb-b4dc-ef49d2a5f0fc', 'b6505f5d-d480-4360-908f-b231194d90bb');