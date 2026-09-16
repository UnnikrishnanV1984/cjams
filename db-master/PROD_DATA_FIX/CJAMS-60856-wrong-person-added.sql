/* 
    Issue Description: CJAMS-60856
   Category/ Module  : Person
   Root cause: User Error, wrong person was added on the case.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    void the rejected provider placement from backend
*/

--actor id
/*
 * select * from person where cjamspid = '4472275';--99328cbd-66b4-42de-83aa-a912d99513ea
 * select * from actor where personid = '99328cbd-66b4-42de-83aa-a912d99513ea' and activeflag = 1 and intakeserviceid = '79768dc2-57e5-49c0-8297-2ef15ad4bb62';
--017691f7-eb3b-4f4b-a91a-1b7ce856f26c
*/

--Deactivating person in actor
update actor
set activeflag = 0, updatedby = 'CJAMS-60856', updatedon = now()
where actorid ='017691f7-eb3b-4f4b-a91a-1b7ce856f26c'
and activeflag = 1;

--Deactivating peron in intakeservicerequestactor
/*select * from intakeservicerequestactor i where actorid in(
'017691f7-eb3b-4f4b-a91a-1b7ce856f26c')
and activeflag = 1;*/

update intakeservicerequestactor 
set activeflag = 0, updatedby = 'CJAMS-60856', updatedon = now()
where activeflag = 1 and intakeservicerequestactorid in ('83cd580f-ed6f-4857-9fcd-f70d9195649d',
'7d205474-307f-4ee7-b2f3-69cfe2496894');

--Deactivating person in actorrelationship
/*
select * from actorrelationship where intakeservicerequestactorid in ('83cd580f-ed6f-4857-9fcd-f70d9195649d',
'7d205474-307f-4ee7-b2f3-69cfe2496894');
*/

update actorrelationship
set activeflag = 0, updatedby = 'CJAMS-60856', updatedon = now()
where activeflag = 1 and actorrelationshipid in (
'292f641a-eeb1-4fb5-9c89-9f6b7bc078b2',
'82ae914f-280a-471a-b10e-b45b0e2d0350');

--Deactivating person in personrole
--select * from personrole where personid = '99328cbd-66b4-42de-83aa-a912d99513ea' and activeflag = 1 and intakeserviceid = '79768dc2-57e5-49c0-8297-2ef15ad4bb62';

update personrole 
set activeflag = 0, updatedby = 'CJAMS-60856', updatedon = now()
where personroleid = 'c0eb7a80-61bf-4d4f-b9cf-e30798d101af' and activeflag = 1;

--Deactivating person in personprogramarea
--select * from personprogramarea where personid = '99328cbd-66b4-42de-83aa-a912d99513ea' and activeflag = 1 and objectid = '79768dc2-57e5-49c0-8297-2ef15ad4bb62';

update personprogramarea
set activeflag = 0, updatedby = 'CJAMS-60856', updatedon = now()
where personprogramid = '43affdb1-1351-419c-a8d3-1a58b370d45c' and activeflag = 1;

update personroletype
set activeflag = 0, updatedby = 'CJAMS-60856', updatedon = now()
where personroleid ='c0eb7a80-61bf-4d4f-b9cf-e30798d101af'
and activeflag = 1;