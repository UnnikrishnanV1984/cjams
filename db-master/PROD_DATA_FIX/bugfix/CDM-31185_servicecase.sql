/*
  Issue Description: CDM-31185- Missing service case
  Root cause: Service case is not being populated .
  Fix provided : Upon pasing the required param to the creteservice able to 
  see the service case in jump server
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/

select * from cjams.createservicecase('7b337ead-f817-487f-b7e0-24976a191d7b','',1,'027ec556-25bb-41a2-8058-ead774a387a5','ASSGN','CDM-31185');

/* assigning the case to the user who created it
*/
INSERT INTO caseassignment
	(fromworkeridno, toworkeridno, insertedby, updatedby, insertedon, updatedon,startdate, objecttypekey, objectid,
	responsibilitytypekey,assignmenttype,assigndate)
	VALUES('027ec556-25bb-41a2-8058-ead774a387a5','027ec556-25bb-41a2-8058-ead774a387a5','027ec556-25bb-41a2-8058-ead774a387a5','CDM-31185',now(),now(),now(),'servicecase',(select servicecaseid from intakeservicerequest where intakeserviceid='7b337ead-f817-487f-b7e0-24976a191d7b'),
	'assignment','W',now()::date);
