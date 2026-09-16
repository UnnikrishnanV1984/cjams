/*
Issue Description: End the Jen Kephart case assignment and create a new assignment to new appeal coordinator for all the attached cases.
Category/Module: Support
Root cause: New assignments cannot be added to completed/closed cases without reopening
Fix provided: DB queries to end active Jen Kephart assignments and then insert assignments for new coordinator
Note: Only 32 new case assignments were inserted because one of the case numbers is mentioned twice in the ticket
Data/Code fix ticket#: CDM-43343
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support ticket
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query: delete from caseassignment where insertedby = 'CDM-43343';
*/

--Updating open assigments in caseassignment
update caseassignment
set enddate = now(), updatedby = 'CDM-43343', updatedon = now()
where activeflag = 1 and caseassignmentid in (
'94904b30-29c6-4bfc-9dcd-fdb50590c52b',
'abebf263-dc87-4745-a9a5-3f88aee41d2e',
'8aeb361a-c10d-496e-b099-497cb032b2d6',
'5a5727e4-e1e9-42a5-ae2c-d331f6dfda11',
'1ddf8ea5-9312-42e5-9a4b-237f6731d1b9',
'35d66422-57b0-4e4f-8a24-fafb1bf6f246',
'acdafa13-981d-40c1-b016-25e55be98018',
'd29f5456-4481-4a06-bd87-737b2a292f27');

--Inserting new assignments in caseassignment
insert into caseassignment
	(caseassignmentid, eventidno_fk, fromworkeridno, toworkeridno, effectivedate, effectivetime, insertedby, insertedon, updatedby,
	updatedon, objecttypekey, objectid, activeflag, startdate, fromteamid, toteamid, fromldssid, toldssid, assignmenttype, assigndate)
select
	gen_random_uuid(), objid::uuid, '9f767911-dcb2-44ae-9152-b85a19589095', '8b7692be-2fbc-49fd-9dce-78666f986886', now(), now(), 'CDM-43343',
	now(), 'CDM-43343', now(), 'servicerequest', objid::uuid, 1, now(), '2c38c542-8bbe-42c6-9789-6411eb1c728b', 
	'1bf3e463-8c28-44cc-840f-8c5e43a6dd7b', 'd0a6f218-4dee-45c3-b842-be7446a5ef41', 'd0a6f218-4dee-45c3-b842-be7446a5ef41', 'W', now()
from (values
	('54122997-a55f-4996-83a4-0c3f115164c9'), ('367a06e2-5a7a-416c-82c6-73a3830629e3'), ('40a54845-aa37-4679-82dc-4af62758fe96'),
	('54c41004-b616-47e9-b66e-c15b25ae6483'), ('41c9f019-80cf-4358-8cd8-80607ca616bc'), ('b39282f3-0492-475b-a1c8-e96fab05f7a2'),
	('4936ee00-28a1-420e-b958-387510905f30'), ('12d0a80f-bc37-4e6a-acb2-1795c9efca39'), ('6fa4c4d5-6621-4c15-b3a1-70ba708596c1'),
	('4207d210-df05-4737-aba5-5c1b4a7d3714'), ('d9fe4397-1c0f-49cf-b292-b7b6e60b0ab6'), ('2fa24da6-1375-42a5-b1a8-0fee13ba56d3'),
	('7a0bc747-95eb-4deb-a8bd-dcd3c807be42'), ('faf915a6-df9b-49b5-b9e8-bd7be9c7ab4b'), ('2ed62390-600d-4639-a08f-84162ec52cef'),
	('80a77de5-c189-4e53-8a05-4d93e56cffd4'), ('e58422a2-4cde-4fe1-b65f-b703121d028f'), ('6e2149a3-9842-496d-be52-0d35782d0502'),
	('8f67d54f-1800-4cf5-9d25-6cc4ce91d8cd'), ('88f877f2-bcdc-404d-8874-9976660ef8c3'), ('7145933a-e6a6-4380-adfa-038244190435'),
	('0ec8628d-3b71-44ce-bca1-c758f5a4e4dc'), ('345d17c7-b342-4063-9b5a-78d414436245'), ('c90c51b3-d7c2-4f99-bb85-3c20bee93bc4'),
	('c4a43e0c-2f73-4129-bacd-6ad7f85e14bf'), ('65b607d4-4bb3-48cc-9b95-c7834b374c06'), ('716bd435-617e-498c-9fdf-346368219d2a'),
	('6befe767-7f6a-4609-8f45-7681740ad937'), ('7a3735f6-6111-4d55-a531-55fdb405641d'), ('028e73a4-c916-4618-aed1-d49a27c10ffb'),
	('cdee2c83-31d7-4027-b90a-97b20485daa4'), ('5358324f-ea57-419f-9a7f-66bb6090d98c') ) as v(objid);