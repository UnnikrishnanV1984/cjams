/*
  Issue Description: CDM-41631 - Intake approved but not connected to create a service case.
  Root cause: Service case is not being populated for the intake (I241013139764) .
  Fix provided : created service case for the intake (I241013139764) and added caseassignment record.
  Pull request# for code fix: N/A
  Reason why no related code fix: N/A 
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: N/A
*/

--intakeserviceid --> 76e52e95-fc7a-4e54-a8f1-1b88a937b37a
--servicerequestnumber --> 241021915623
--supervisor id --> ef3032b3-2f5a-4b48-8b27-c33cf654abf6
-- New Servicecaseno created --> 241030402122 

select * from cjams.createservicecase('76e52e95-fc7a-4e54-a8f1-1b88a937b37a','',1,'ef3032b3-2f5a-4b48-8b27-c33cf654abf6','ASSGN','intake');

-- assigning the case to the supervisor for caseworker assignment
INSERT INTO caseassignment
	(fromworkeridno, toworkeridno, insertedby, updatedby, insertedon, updatedon,startdate, objecttypekey, objectid,
	responsibilitytypekey,assignmenttype,assigndate)
	VALUES('ef3032b3-2f5a-4b48-8b27-c33cf654abf6','ef3032b3-2f5a-4b48-8b27-c33cf654abf6','ef3032b3-2f5a-4b48-8b27-c33cf654abf6','CDM-37650',now(),now(),now(),'servicecase',(select servicecaseid from intakeservicerequest where intakeserviceid='76e52e95-fc7a-4e54-a8f1-1b88a937b37a'),
	'assignment','W',now()::date);