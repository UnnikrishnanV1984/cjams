/*
Issue Description: 241030284461 needs to be reopened as of 11/21/24 and should be assigned to lauren.cauffman@maryland.gov
231030147746 needs update with received time 07/14/2023  and completed time as 10/11/23
Category/Module: Support
Root cause: This is following up CDM-42889, user is requesting further changes
Fix provided: DB queries to insert the new changes in both cases
Data/Code fix ticket#: CIDM-10001
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support ticket
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:

delete from servicecasedisposition where insertedby = 'CIDM-10001';
delete from caseassignment where insertedby = 'CIDM-10001';
*/

--1. Case 241030284461

--Updating servicecase
update servicecase
set statustypekey = 'ASSGN', dispositioncode = null, updatedby = 'CIDM-10001', updatedon = now()
where servicecaseid = '7d0de276-360d-4401-8c43-5f0f1fce6c82' and activeflag = 1;

--Inserting into servicecasedisposition
insert into servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate,
activeflag, insertedby, insertedon, updatedby, updatedon)
values (gen_random_uuid(), '7d0de276-360d-4401-8c43-5f0f1fce6c82', '2024-11-21 00:00:00.000', 'Open', 'Inprogress', 'Case Reopened',
'2024-11-21 00:00:00.000', 1, 'CIDM-10001', now(), 'CIDM-10001', now());

--Inserting into caseassignment
insert into caseassignment
(caseassignmentid, fromworkeridno, toworkeridno, effectivedate, effectivetime, insertedby, insertedon, updatedby, 
updatedon, objecttypekey, objectid, responsibilitytypekey, activeflag, startdate, enddate, fromteamid, toteamid, fromldssid,
toldssid, assignmenttype, assigndate)
values (gen_random_uuid(), '72439d81-dfaa-46d0-a372-f90eb16f75fd', '8aa46919-9467-474d-8699-db8b04db4005', now(), now(),
	'CIDM-10001', now(), 'CIDM-10001', now(), 'servicecase', '7d0de276-360d-4401-8c43-5f0f1fce6c82', 'family', 1,
	'2024-11-21 00:00:00.000', null, '92c70062-0598-4c20-b853-b701430ab353', '92c70062-0598-4c20-b853-b701430ab353',
	'9f60d4f1-4004-474f-a432-a19da7b1efe0', '9f60d4f1-4004-474f-a432-a19da7b1efe0', 'W', '2024-11-21 00:00:00.000');
	
--2. 231030147746

--Updating servicecase
update servicecase
set startdate = '2023-07-14 09:35:00.000', enddate = '2023-10-11 16:36:51.1', dispositioncode = 'closed',
	statustypekey = 'closed', updatedby = 'CIDM-10001', updatedon = now()
where servicecaseid = 'c669078a-3d4a-4ebd-9bd6-3ece4df9792a' and activeflag = 1;

--Inserting into servicecasedisposition
insert into servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate,
activeflag, insertedby, insertedon, updatedby, updatedon)
values (gen_random_uuid(), 'c669078a-3d4a-4ebd-9bd6-3ece4df9792a', '2023-10-11 16:36:51.1', 'Closed', 'Closed', 'Closed',
	'2023-10-11 16:36:51.1', 1, 'CIDM-10001', now(), 'CIDM-10001', now());