/*
  Issue Description: CJAMS-59127 - I251013268387:The CPS ROA "out of state" referral was in the process of being approved and connected to create service case, but it disappeared and the supervisor could not complete the task. The CPS ROA out of state has always worked for our local, but this time now there is no way to show a "completed" date for this intake referral now
  Root cause: Service case is not being populated for the intake (I251013268387) .
  Fix provided : created service case for the intake (I251013268387) and added caseassignment record.
  Pull request# for code fix: N/A
  Reason why no related code fix: N/A 
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: N/A
*/
--intakeserviceid --> d06a7746-4cd1-4c5b-9431-e866894aff08
--servicerequestnumber --> 251030497249
--supervisor id --> 26d596f0-53ef-4c65-98c2-32a19785a007
-- New Servicecaseno created --> 241030402122 

select * from cjams.createservicecase('d06a7746-4cd1-4c5b-9431-e866894aff08','',1,'26d596f0-53ef-4c65-98c2-32a19785a007','ASSGN','intake');

-- assigning the case to the supervisor for caseworker assignment
INSERT INTO caseassignment
	(fromworkeridno, toworkeridno, insertedby, updatedby, insertedon, updatedon,startdate, objecttypekey, objectid,
	responsibilitytypekey,assignmenttype,assigndate)
	VALUES('26d596f0-53ef-4c65-98c2-32a19785a007','26d596f0-53ef-4c65-98c2-32a19785a007','26d596f0-53ef-4c65-98c2-32a19785a007','CJAMS-59127',now(),now(),now(),'servicecase',(select servicecaseid from intakeservicerequest where intakeserviceid='d06a7746-4cd1-4c5b-9431-e866894aff08'),
	'assignment','W',now()::date);