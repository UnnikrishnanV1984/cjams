/*
Issue Description: This ticket needs Data fix to create a new service case for the intake I251013216323. 
Category/Module: Support
Root cause: User request to  create new service case
Fix provided: DB queries to  create new service case
Data/Code fix ticket#: CDM-44147
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
select * from cjams.createservicecase
('c846eb0b-dc24-44c3-9e5a-3c5031627b45', null, 1, '1f5d2877-a717-4eb7-8ad0-42fa47da39b2','intake');

insert into caseassignment
(caseassignmentid,fromworkeridno,fromsupervisoridno,toworkeridno,tosupervisoridno,old_id,insertedby,updatedby,insertedon,updatedon,objecttypekey,objectid,responsibilitytypekey,
activeflag,startdate,fromteamid,toteamid,statustypekey ,fromldssid,toldssid,assignmenttype,fk_id)
values
(gen_random_uuid(),'386ef07e-93d9-4ad6-a3e6-ae87e18c074d','6004194','1f5d2877-a717-4eb7-8ad0-42fa47da39b2','6004194','3285097','CDM-44147','CDM-44147',now(),now(),
'adoptioncase',(select servicecaseid from intakeservicerequest where intakeserviceid='c846eb0b-dc24-44c3-9e5a-3c5031627b45'),'family',1,'2025-01-28 15:04:01.000','07c4e2d4-bad1-4da1-8e54-6a03a987307f','07c4e2d4-bad1-4da1-8e54-6a03a987307f',
'ASSGN','34457960-811a-4d35-a416-b8941d6974cc','34457960-811a-4d35-a416-b8941d6974cc','W','6004194');