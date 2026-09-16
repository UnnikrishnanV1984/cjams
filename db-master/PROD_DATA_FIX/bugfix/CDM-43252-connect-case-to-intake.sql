/*
Issue Description: Dashboard:I241013191057 referral was screened in however then was not able to assign to a worker. Supervisor unable to override or make any changes
Category/Module: create service case
Root cause: Service case is not created in after intake is screened in by the supervisor. TDB, at this point of time looks like some intermittent issue, we will monitor if this happens again 
Fix provided: Data fix has been done to create a new service case and link it to the intake
Data/Code fix ticket#: CDM-43253
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: 
Backup before update/ delete:Query:
*/

select * from cjams.createservicecase('ab0164a8-73b1-449c-ae44-129695ee7d2f','',1,'ba51d587-d94f-4b54-8225-78af2eab1214','ASSGN','intake');

-- assigning the case to the supervisor for caseworker assignment
INSERT INTO caseassignment
	(fromworkeridno, toworkeridno, insertedby, updatedby, insertedon, updatedon,startdate, objecttypekey, objectid,
	responsibilitytypekey,assignmenttype,assigndate, toteamid)
	VALUES('ba51d587-d94f-4b54-8225-78af2eab1214','31860dc7-0182-4de8-ae3b-cd480f5688ea','ba51d587-d94f-4b54-8225-78af2eab1214','CDM-43252',now(),'2024-12-12 11:00:00','2024-12-12 11:00:00','servicecase',(select servicecaseid from intakeservicerequest where intakeserviceid='ab0164a8-73b1-449c-ae44-129695ee7d2f'),
	'family','W','2024-12-12 11:00:00','92c70062-0598-4c20-b853-b701430ab353');

--updating the case start date in service case table
update servicecase 
set startdate='2024-12-12 11:00:00.000', 
insertedon='2024-12-12 11:00:00.000',
updatedon=now(),
updatedby='CDM-43252'
where  servicecaseid in (select servicecaseid from intakeservicerequest where intakeserviceid='ab0164a8-73b1-449c-ae44-129695ee7d2f');

--Updating the case assignment in routing table
update routing 
set toroleid='CWCW',
tosecurityusersid='31860dc7-0182-4de8-ae3b-cd480f5688ea',
updatedby = 'CDM-43252',
updatedon = now()
where objectid in (select servicecaseid::varchar from intakeservicerequest where intakeserviceid='ab0164a8-73b1-449c-ae44-129695ee7d2f');
