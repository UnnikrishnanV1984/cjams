/*
Issue Description: User Error, User requested to remove the client ID# 204116909 (Paul Cider) from the CPS IR case # 251023032220.
 SSA/Product Owner approved to remove the client ID# 204116909 (Paul Cider) from the CPS IR case # 251023032220.
Category/Module: Error
Root cause: The person was incorrectly added to the IR case
Fix provided: DB queries remove person from the CPS case
Data/Code fix ticket#: CDM-41645
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

/*
 * select * from person p where cjamspid = '204116909';--bfada958-e112-4eb2-99ad-ab25f63ecb62;
 * select * from actor where personid = 'bfada958-e112-4eb2-99ad-ab25f63ecb62' and activeflag =1;
 * 
--actor id
0cb35ad5-40f2-4e84-8a55-8bfeac05cc55
e19302c6-2475-4dd3-8083-0cb1f31e05cf
*/
--Deactivating person in actor
update actor
set activeflag = 0, updatedby = 'CJAMS-59463', updatedon = now()
where actorid in (
'0cb35ad5-40f2-4e84-8a55-8bfeac05cc55',
'e19302c6-2475-4dd3-8083-0cb1f31e05cf')
and activeflag = 1;

--Deactivating peron in intakeservicerequestactor
/*select * from intakeservicerequestactor i where actorid in
(
'0cb35ad5-40f2-4e84-8a55-8bfeac05cc55',
'e19302c6-2475-4dd3-8083-0cb1f31e05cf')
and activeflag =1;*/

update intakeservicerequestactor 
set activeflag = 0, updatedby = 'CJAMS-59463', updatedon = now()
where activeflag = 1 and intakeservicerequestactorid in (
'4bfd1cdb-08b4-4c8d-94e7-32f0d2c2a84e',
'4728f726-2476-4029-9f4e-6a40b0303b71',
'bd86325d-031a-44fc-9fdb-66c83fcb5542');

--Deactivating person in actorrelationship
update actorrelationship
set activeflag = 0, updatedby = 'CJAMS-59463', updatedon = now()
where activeflag = 1 and actorrelationshipid in (
'3705844a-ab31-4cca-b498-bdabd4fd2bc6',
'7c897083-1efb-4d21-a239-feca083bc45f',
'6267fbdb-333b-44fb-9e72-5991fb3d921c');

--Deactivating person in personrole
update personrole 
set activeflag = 0, updatedby = 'CJAMS-59463', updatedon = now()
where personroleid in ('c74424fb-f718-4d5c-80b6-061dd68e1799',
'f7dc4d1d-4ea2-4a55-91e1-3547de95733d') 
and activeflag = 1;

--Deactivating person in personprogramarea
update personprogramarea
set activeflag = 0, updatedby = 'CJAMS-59463', updatedon = now()
where personprogramid = '2ee1d034-4826-4d2d-9981-3445c052f2f8' and activeflag = 1;

update personroletype
set activeflag = 0, updatedby = 'CJAMS-59463', updatedon = now()
where personroleid in ('c74424fb-f718-4d5c-80b6-061dd68e1799',
'f7dc4d1d-4ea2-4a55-91e1-3547de95733d')
and activeflag = 1;