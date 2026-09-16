/*
Issue Description: Need data fix. Please assign the CPS IR case 241022663573 to the appeal worker to Jeanne Baxter (jeanne.baxter@maryland.gov) and the assignment start date is 11/07/2024, Supervisor is Stacie Parker. 
Category/Module: Support
Root cause: Supervisor cannot assign a case that has been closed/completed
Fix provided: DB query to insert a new case assignment for the user
Data/Code fix ticket#: CDM-43463
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support ticket
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query: delete from caseassignment where insertedby = 'CDM-43463';
*/

--inserting into caseassignment
insert into caseassignment
(caseassignmentid, fromworkeridno, toworkeridno, effectivedate, effectivetime, insertedby, insertedon, updatedby, 
updatedon, objecttypekey, objectid, responsibilitytypekey, activeflag, startdate, enddate, fromteamid, toteamid, fromldssid,
toldssid, assignmenttype, assigndate)
values (gen_random_uuid(), '527e483b-5108-4906-b2bb-6fdbc317f03e', '22f78177-19c0-4bb2-a921-c133de3590cd', now(), now(),
    'CDM-43463', now(), 'CDM-43463', now(), 'servcerequest', '95869be9-ccb5-46db-bedd-50e5dd72e1bc', 'administrative', 1, 
	'2024-11-07 00:00:00.000', null, '406c0f48-4048-490a-a834-3a00e8382e1b', '13235932-5e81-4427-a9d0-affbc6001410',
	'f5214cb2-953e-41a9-a4ad-71341501e2ad', 'f5214cb2-953e-41a9-a4ad-71341501e2ad', 'W', now());