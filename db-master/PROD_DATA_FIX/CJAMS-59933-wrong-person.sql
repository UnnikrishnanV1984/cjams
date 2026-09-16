/*
   Issue Description: User requested to remove the child (Zalayh Lilyahna Deshields; DOB: 2/8/2013; PID: 204147319) listed under the inactive tab from the Case AR case  (251023062102)
   since User has added all the information for the child 4380508 (Zalayh L. Rideout). 
   Category/ Module  : Contact notes, person, assessment
   Root cause: User Error,User wants to remove the client ID# 204147319 from the intake, CPS AR, and Contact Note.
   Fix Provided: Data fix has been promoted to delete persons card, contacts, assessements, payments, Program assignments etc.
*/
/*
 select * from person p where cjamspid = '204147319';--cddbce31-43fd-4e49-96b0-b4e9911400b3;
 select * from actor where personid = 'cddbce31-43fd-4e49-96b0-b4e9911400b3' and activeflag =1;

--actor id
f77934f9-e7fb-4b9a-8ee6-f6f5a2af294c
24fd7bcf-9d12-4aec-9355-b8361e31efae
61faf106-9d39-460d-b271-9121ac973e09
0c99d765-e4d0-42cf-ad3f-e533fa3cca25
*/

--Deactivating person in actor
update actor
set activeflag = 0, updatedby = 'CJAMS-59933', updatedon = now()
where actorid in (
'f77934f9-e7fb-4b9a-8ee6-f6f5a2af294c',
'24fd7bcf-9d12-4aec-9355-b8361e31efae',
'61faf106-9d39-460d-b271-9121ac973e09',
'0c99d765-e4d0-42cf-ad3f-e533fa3cca25')
and activeflag = 1;

--Deactivating peron in intakeservicerequestactor
/*
select * from intakeservicerequestactor i 
where actorid in (
'f77934f9-e7fb-4b9a-8ee6-f6f5a2af294c',
'24fd7bcf-9d12-4aec-9355-b8361e31efae',
'61faf106-9d39-460d-b271-9121ac973e09',
'0c99d765-e4d0-42cf-ad3f-e533fa3cca25')
and activeflag = 1;
*/

update intakeservicerequestactor 
set activeflag = 0, updatedby = 'CJAMS-59933', updatedon = now()
where activeflag = 1 and intakeservicerequestactorid in (
'4959e1ac-b25b-40e4-a11c-fa12a4351624',
'c759fe90-65b2-495d-bfe5-176d21f1d51f',
'c9ce1e29-bba9-429a-9c69-f87d50099a47',
'37da8e60-3c2a-4cc2-8a2b-ee8db85f59e5',
'f73ab260-5e40-4469-98cc-d07a50fbf275');

--Deactivating person in actorrelationship
/*
select * from actorrelationship a 
where activeflag = 1 and intakeservicerequestactorid in (
'4959e1ac-b25b-40e4-a11c-fa12a4351624',
'c759fe90-65b2-495d-bfe5-176d21f1d51f',
'c9ce1e29-bba9-429a-9c69-f87d50099a47',
'37da8e60-3c2a-4cc2-8a2b-ee8db85f59e5',
'f73ab260-5e40-4469-98cc-d07a50fbf275');
*/

update actorrelationship
set activeflag = 0, updatedby = 'CJAMS-59933', updatedon = now()
where activeflag = 1 and actorrelationshipid in (
'61650326-18b8-41b0-958e-2b3c7f409130',
'19612235-7c89-4264-98c4-a5ea2cd31fe8',
'26bc20e4-2579-412b-b126-a6188f65d98b',
'c2cdca54-7868-4544-b44c-82dba5150cec');

--Deactivating person in personrole
--select * from personrole p where personid = 'cddbce31-43fd-4e49-96b0-b4e9911400b3'

update personrole 
set activeflag = 0, updatedby = 'CJAMS-59933', updatedon = now()
where personroleid in ('75f68e38-088b-4dff-baf9-12f5afa37cab',
'31cc24d0-6729-49fc-a5b0-091e28c7f6f9',
'3e1cf0db-08e4-4c41-b77a-163d085803b6',
'6303bf0c-c5bf-4c21-a35d-444dcf32a957') 
and activeflag = 1;

--Deactivating person in personprogramarea
--select * from personprogramarea p where personid = 'cddbce31-43fd-4e49-96b0-b4e9911400b3'

update personprogramarea
set activeflag = 0, updatedby = 'CJAMS-59933', updatedon = now()
where personprogramid = '2bf9a536-2402-4de1-95c1-a7094eb6515d' and activeflag = 1;

/*
select * from personroletype p where personroleid in
('75f68e38-088b-4dff-baf9-12f5afa37cab',
'31cc24d0-6729-49fc-a5b0-091e28c7f6f9',
'3e1cf0db-08e4-4c41-b77a-163d085803b6',
'6303bf0c-c5bf-4c21-a35d-444dcf32a957') 
and activeflag =1; 
*/

update personroletype
set activeflag = 0, updatedby = 'CJAMS-59933', updatedon = now()
where personroleid in ('75f68e38-088b-4dff-baf9-12f5afa37cab',
'31cc24d0-6729-49fc-a5b0-091e28c7f6f9',
'3e1cf0db-08e4-4c41-b77a-163d085803b6',
'6303bf0c-c5bf-4c21-a35d-444dcf32a957') 
and activeflag = 1;

--select focusperson,* from progressnote where progressnoteid='d19d01ce-1677-4647-83b0-db1e748cc6d4';
--select * from contactparticipant c where progressnoteid='d19d01ce-1677-4647-83b0-db1e748cc6d4' and activeflag =1;--"29df74d7-d11c-487d-afd3-9e9f82eb5495"

update contactparticipant 
set activeflag = 0,
	updatedby = 'CJAMS-59933',
	updatedon = now()
where contactparticipantid = '29df74d7-d11c-487d-afd3-9e9f82eb5495'
and activeflag =1;