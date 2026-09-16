/*
Issue Description: Please see why the user is listed twice the user has only one profile active
Category/Module: Support
Root cause: User has two active accounts in databse under two separate email ids.
Fix provided: DB queries to deactivate the other account
Data/Code fix ticket#: CDM-42393
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating userprofile
update userprofile
set activeflag = 0, updatedby = 'CDM-42393', updatedon = now()
where securityusersid = '4421415d-dbec-4a90-9343-08ab95cf34a5' and activeflag = 1;

--Updating teammember
update teammember
set activeflag = 0, updatedby = 'CDM-42393', updatedon = now()
where teammemberid = '9455f5f2-85f8-4eb5-839d-45c05b905b17' and activeflag = 1;

--Updating teammemberassignment
update teammemberassignment
set activeflag = 0, updatedby = 'CDM-42393', updatedon = now()
where teammemberassignmentid = '017e7c4c-17df-4373-972a-110ec0ab315d' and activeflag = 1;

--Updating muser
update muser
set activeflag = 0, updatedby = 'CDM-42393', updatedon = now()
where email = 'albi1221@yahoo.com' and activeflag = 1;

--Updating rolemapping
update rolemapping
set activeflag = 0, updatedby = 'CDM-42393', updatedon = now()
where principalid = '14035' and activeflag = 1;

--Updating userresource
update userresource
set activeflag = 0, updatedby = 'CDM-42393', updatedon = now()
where userresourceid = '78ac845f-56f2-41f3-82a1-5c7dcda4e8d8' and activeflag = 1;

--Updating securityusers
update securityusers
set activeflag = 0, updatedby = 'CDM-42393', updatedon = now()
where securityusersid = '4421415d-dbec-4a90-9343-08ab95cf34a5' and activeflag = 1;

update caseassignment
set toworkeridno = 'b9a323d4-ca3d-47bd-80aa-863c8af66a9e'
where caseassignmentid in (
'10271d63-2bb5-4db2-97f0-0542a1026742',
'42a06843-1630-400f-8fd2-36241a9d9f8d',
'8946b436-9ecd-4ebd-85d6-13ab3352beb9',
'73893edd-62fa-4819-8af8-5a7436b26066',
'85e14a49-8958-411d-bab4-722aa01020e2',
'2a977f73-95f0-48d1-8802-c5763cc29cac',
'cd5ab0bf-fcf5-42ea-980c-711621f68b07',
'1540fee6-36bb-41f5-a390-02273c651694');