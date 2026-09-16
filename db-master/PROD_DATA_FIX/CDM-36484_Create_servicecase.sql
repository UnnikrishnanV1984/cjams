/*
  Issue Description: CDM-36484 - Missing service case
  Root cause: Service case is not being populated .
  Fix provided : Execute createservicecase function with appropriate parameters and add caseassignment record
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date:  
  Backup before update/ delete:
*/

--intakeserviceid --> f280b278-65e9-4c11-9a31-1a03e0f7796a
--servicerequestnumber --> 241021800783
--supervisor id --> ba384e95-a535-4b1f-b9ea-b94c4f9ef782

select * from cjams.createservicecase('f280b278-65e9-4c11-9a31-1a03e0f7796a','',1,'ba384e95-a535-4b1f-b9ea-b94c4f9ef782','ASSGN','intake');

-- assigning the case to the supervisor for caseworker assignment
INSERT INTO caseassignment
	(fromworkeridno, toworkeridno, insertedby, updatedby, insertedon, updatedon,startdate, objecttypekey, objectid,
	responsibilitytypekey,assignmenttype,assigndate)
	VALUES('ba384e95-a535-4b1f-b9ea-b94c4f9ef782','ba384e95-a535-4b1f-b9ea-b94c4f9ef782','ba384e95-a535-4b1f-b9ea-b94c4f9ef782','CDM-36484',now(),now(),now(),'servicecase',(select servicecaseid from intakeservicerequest where intakeserviceid='f280b278-65e9-4c11-9a31-1a03e0f7796a'),
	'assignment','W',now()::date);