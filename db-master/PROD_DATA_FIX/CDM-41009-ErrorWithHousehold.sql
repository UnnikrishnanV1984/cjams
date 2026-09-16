/*
Issue Description: All individuals with the last name nicely should not be listed or apart of Ms. Erin Millers Case.
Category/Module: Bug
Root cause: Five persons were added to this case in error
Fix provided: DB query to remove said persons
Code fix ticket#: CDM-41009
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Deactivating the persons in actor
update actor
set activeflag = 0, updatedby = 'CDM-41009', updatedon = now()
where activeflag = 1 and actorid in (
'574e9156-ca25-4bfb-aa20-848460659471',
'6c74ea25-fa9c-46be-94c4-a208f40efcb6',
'4b106b1a-4494-4b7b-9d0f-287a04d06522',
'fbd4848d-3cd1-4ca0-8fe0-0212345b9ce5',
'514a0d09-ab67-447c-90af-628808b2da62');

--Deactivating the persons in intakeservicerequestactor
update intakeservicerequestactor
set activeflag = 0, updatedby = 'CDM-41009', updatedon = now()
where activeflag = 1 and intakeservicerequestactorid in (
'ccf766e4-3540-40e7-b0dc-e588d10a4b62',
'fb4b93d3-9341-4aa4-87ba-31d2ec44365c',
'f4a80bcb-b22a-4c19-9e31-adac626b43d0',
'00c0ae4d-800b-49b3-885a-84b8c7955719',
'f875b239-ade5-4cf1-ae86-c54dd3f29baf');

--Deactivating the persons in actorrelationship
update actorrelationship
set activeflag = 0, updatedby = 'CDM-41009', updatedon = now()
where activeflag = 1 and intakeservicerequestactorid in (
'ccf766e4-3540-40e7-b0dc-e588d10a4b62',
'fb4b93d3-9341-4aa4-87ba-31d2ec44365c',
'f4a80bcb-b22a-4c19-9e31-adac626b43d0',
'00c0ae4d-800b-49b3-885a-84b8c7955719',
'f875b239-ade5-4cf1-ae86-c54dd3f29baf');

--no records in personprogramarea

--Deactivating the persons in personrole
update personrole
set activeflag = 0, updatedby = 'CDM-41009', updatedon = now()
where activeflag = 1 and personroleid in (
'bc646394-bd33-4764-8893-abd7ff37685a',
'8505a642-ed47-46e4-ab4a-65549fc8a54a',
'621731b8-02c9-483c-aa5b-e910ccb35757',
'b4bb701c-f411-4aea-9d56-ca085ab6e71c',
'987092e0-ab37-4bcf-9765-97ec2aaa1e32');