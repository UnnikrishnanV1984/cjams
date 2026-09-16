/*
Issue Description: change pathway from CPS-AR to CPS-IR duplicate Investigation findings has been created.
Need technical investigation for the duplication.
Also when the case was sent for closure, the request was not sent for the 1st time and needed to send again, 
need technical investigation for this as well.
Category/Module: Bug
Root cause: Changing CPS AR/IR pathway seems to duplicate investigation findings
Fix provided: DB queries to deactivate duplicate investigation findings
Data/Code fix ticket#: CDM-41254
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#: CIDM-9358
Reason why no related code fix: N/A
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Deactivating duplicates in investigationmaltreatment
update investigationmaltreatment
set activeflag = 0, updatedby = 'CDM-41254', updatedon = now()
where activeflag = 1 and maltreatmentid in (
	'71a02a6d-492b-4ad3-b7f3-53c4315f7db2',
	'c61cbc08-5b12-4828-ab72-4754086fad53',
	'82166758-9d34-468d-8c22-933f291b4f0d');
	
--Deactivating duplicates in investigationmaltreatmentactor
update investigationmaltreatmentactor
set activeflag = 0, updatedby = 'CDM-41254', updatedon = now()
where activeflag = 1 and investigationmaltreatmentactorid in (
	'1d5fe489-19b1-4a8d-a3b4-f8a44a915eee',
	'ababfcad-edbd-473c-a281-e8ba7a9c91b7',
	'd24e12f8-095f-4436-8cbc-325832158378');
	
--Deactivating duplicates in investigationallegation
update investigationallegation
set activeflag = 0, updatedby = 'CDM-41254', updatedon = now()
where activeflag = 1 and investigationallegationid in (
	'f01803fb-94e6-47f9-aefe-b1aa03c5b49f',
	'242bd316-5fd1-4056-aa27-730dd5e8ab5f',
	'16eb2e46-50c3-44ac-ad6c-d6a9e5c63c60');
	
--Deactivating duplicates in investigationfinding
update investigationfinding
set activeflag = 0, updatedby = 'CDM-41254', updatedon = now()
where activeflag = 1 and investigationfindingid in (
	'5b857f1a-5741-46ce-9d20-2c880e68e574',
	'46dddb63-0989-4cce-8038-726e5d7995f1',
	'9bfb6624-6aa9-48a7-b980-8e185e3761ce');