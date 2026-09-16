/*
Issue Description: User Error, User requested to remove the client Chrisean Jesus Malone, Jr. (client # 204137301) from intake: I251013294821 and Case: 251030514719
Category/Module: Error
Root cause: The person was incorrectly added to the service case
Fix provided: DB queries remove person from the service case and intake
Data/Code fix ticket#: CJAMS-59955
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

/*
 select * from person p where cjamspid = '204137301';--6dfa5e91-0bde-4e86-8899-ac478e3d9369;
 select * from actor where personid = '6dfa5e91-0bde-4e86-8899-ac478e3d9369' and activeflag =1;
 
--actor id
ad452e58-5429-4106-85f1-a68e13909c1b
300ba4a8-978d-445f-a140-e2cda78ac64b
27a88cf0-cab1-4e78-9337-7be5d700fe6e
f9557684-033b-4f00-88b8-479a060e2fd1
feb41a10-a534-4ad6-8f6b-6f4d758ba28b
a41f25b8-f2e2-4029-9ec1-a920e3794d38
1c9f8186-ef66-4877-b33b-91e94049b88d
5ca54d11-bcba-46d6-98b8-99d1978722a4
8638c71a-f2ad-4e6f-80d4-7c72f89f15e6
*/

--Deactivating person in actor
update actor
set activeflag = 0, updatedby = 'CJAMS-59955', updatedon = now()
where actorid in (
'ad452e58-5429-4106-85f1-a68e13909c1b',
'300ba4a8-978d-445f-a140-e2cda78ac64b',
'27a88cf0-cab1-4e78-9337-7be5d700fe6e',
'f9557684-033b-4f00-88b8-479a060e2fd1',
'feb41a10-a534-4ad6-8f6b-6f4d758ba28b',
'a41f25b8-f2e2-4029-9ec1-a920e3794d38',
'1c9f8186-ef66-4877-b33b-91e94049b88d',
'5ca54d11-bcba-46d6-98b8-99d1978722a4',
'8638c71a-f2ad-4e6f-80d4-7c72f89f15e6')
and activeflag = 1;

--Deactivating peron in intakeservicerequestactor
/*
select * from intakeservicerequestactor i 
where actorid in (
'ad452e58-5429-4106-85f1-a68e13909c1b',
'300ba4a8-978d-445f-a140-e2cda78ac64b',
'27a88cf0-cab1-4e78-9337-7be5d700fe6e',
'f9557684-033b-4f00-88b8-479a060e2fd1',
'feb41a10-a534-4ad6-8f6b-6f4d758ba28b',
'a41f25b8-f2e2-4029-9ec1-a920e3794d38',
'1c9f8186-ef66-4877-b33b-91e94049b88d',
'5ca54d11-bcba-46d6-98b8-99d1978722a4',
'8638c71a-f2ad-4e6f-80d4-7c72f89f15e6')
and activeflag = 1;
*/

update intakeservicerequestactor 
set activeflag = 0, updatedby = 'CJAMS-59955', updatedon = now()
where activeflag = 1 and intakeservicerequestactorid in (
'8a02e056-dbe2-41bf-8234-f95c0732d59a',
'f97104de-1d90-4d88-8c1f-427718f58354',
'3bc561a3-772d-40e5-8a48-6797fce2ab26',
'6de350fa-3608-42c3-92bc-6ca3f7596b49',
'f5ea07a4-7405-4ed6-847c-c0feeedca02c',
'7f38df83-7161-429e-ba94-baeea1ea8810',
'd54b45e3-be03-43e3-b4f5-078b2d4bb9d2',
'539ba856-3a29-401b-9575-7574251ba52a',
'f6b79794-fa90-4283-93de-6cb78479ae37');

--Deactivating person in actorrelationship
/*
select * from actorrelationship a 
where activeflag = 1 and intakeservicerequestactorid in (
'8a02e056-dbe2-41bf-8234-f95c0732d59a',
'f97104de-1d90-4d88-8c1f-427718f58354',
'3bc561a3-772d-40e5-8a48-6797fce2ab26',
'6de350fa-3608-42c3-92bc-6ca3f7596b49',
'f5ea07a4-7405-4ed6-847c-c0feeedca02c',
'7f38df83-7161-429e-ba94-baeea1ea8810',
'd54b45e3-be03-43e3-b4f5-078b2d4bb9d2',
'539ba856-3a29-401b-9575-7574251ba52a',
'f6b79794-fa90-4283-93de-6cb78479ae37');
*/

update actorrelationship
set activeflag = 0, updatedby = 'CJAMS-59955', updatedon = now()
where activeflag = 1 and actorrelationshipid in (
'd0f2d9cc-d998-4535-842a-8b599a6717ee',
'9a874cc8-8af5-4930-8feb-490427c02cb7',
'6ac793df-5433-47ea-9c51-2d13218dc0b0',
'953593d0-55bd-405a-abb1-0018725d596c',
'6585cb4b-a4f8-4ca2-840f-f47474184508',
'af29f036-351d-4bbc-9071-8ed5d118d8e0',
'e61bc8da-4bf9-40c3-9320-bc87ee0275d6',
'5c2742b3-cbd6-4eef-b70a-6bc9af5beeda',
'3032fd5a-2f6f-412f-88bb-129605e1369f',
'27312bd1-5cb0-4ff6-a76e-4f832fce051c',
'403df0ea-cb6a-4af5-957b-8631ab224099',
'975945ef-24bd-4a19-be6f-badd025f2a85',
'968aaad8-cbec-45fa-9fcc-e7163a812b29');

--Deactivating person in personrole
--select * from personrole p where personid = '6dfa5e91-0bde-4e86-8899-ac478e3d9369'

update personrole 
set activeflag = 0, updatedby = 'CJAMS-59955', updatedon = now()
where personroleid in ('c2218b2b-5b82-45fd-bcad-a381a1fadbda',
'8d4a0e55-b7d7-4de6-88be-b5a7ae28e3bd',
'c1b87fd3-1228-4067-bbe1-ae91ae42a8fc',
'31a4b8d9-f40d-4c92-a58b-dc1062f3bb10',
'dd12317d-2e0f-4e28-8639-d1e06ef524fd',
'3a8e59f0-26a3-46b7-b58a-e8f40abd61a4',
'a9fb6903-9bf9-47ed-b690-66beba0763e8',
'98940a84-2b41-4af3-97b0-32d6c1a410ab',
'b123ae1c-8b4e-4645-9897-9175ea0b4705') 
and activeflag = 1;

--Deactivating person in personprogramarea

--select * from personprogramarea p where personid = '6dfa5e91-0bde-4e86-8899-ac478e3d9369'
update personprogramarea
set activeflag = 0, updatedby = 'CJAMS-59955', updatedon = now()
where personprogramid = '5209aa4f-6857-4dca-b4c3-7d866c2de64b' and activeflag = 1;

/*
select * from personroletype p where personroleid in
('c2218b2b-5b82-45fd-bcad-a381a1fadbda',
'8d4a0e55-b7d7-4de6-88be-b5a7ae28e3bd',
'c1b87fd3-1228-4067-bbe1-ae91ae42a8fc',
'31a4b8d9-f40d-4c92-a58b-dc1062f3bb10',
'dd12317d-2e0f-4e28-8639-d1e06ef524fd',
'3a8e59f0-26a3-46b7-b58a-e8f40abd61a4',
'a9fb6903-9bf9-47ed-b690-66beba0763e8',
'98940a84-2b41-4af3-97b0-32d6c1a410ab',
'b123ae1c-8b4e-4645-9897-9175ea0b4705') 
and activeflag =1; 
*/

update personroletype
set activeflag = 0, updatedby = 'CJAMS-59955', updatedon = now()
where personroleid in ('c2218b2b-5b82-45fd-bcad-a381a1fadbda',
'8d4a0e55-b7d7-4de6-88be-b5a7ae28e3bd',
'c1b87fd3-1228-4067-bbe1-ae91ae42a8fc',
'31a4b8d9-f40d-4c92-a58b-dc1062f3bb10',
'dd12317d-2e0f-4e28-8639-d1e06ef524fd',
'3a8e59f0-26a3-46b7-b58a-e8f40abd61a4',
'a9fb6903-9bf9-47ed-b690-66beba0763e8',
'98940a84-2b41-4af3-97b0-32d6c1a410ab',
'b123ae1c-8b4e-4645-9897-9175ea0b4705') 
and activeflag = 1;