/*
   Issue Description: CDM-44122
   Category/ Module  : Create Service case for Intake #I251013219367 .
   Root cause: User requested to create a service case linked to existing intake request.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

select * from cjams.createservicecase
('0470e432-1ad0-4015-a18f-6db7c9d547c5', null, 1, 'f156b6d0-67af-404f-bf79-d4fbd737716c','intake');

INSERT INTO caseassignment
	(fromworkeridno, toworkeridno, insertedby, updatedby, insertedon, updatedon,startdate, objecttypekey, objectid,
	responsibilitytypekey,assignmenttype,assigndate)
	VALUES('f156b6d0-67af-404f-bf79-d4fbd737716c','f156b6d0-67af-404f-bf79-d4fbd737716c',
	'f156b6d0-67af-404f-bf79-d4fbd737716c','CDM-44122',now(),now(),now(),'servicecase',
	(select servicecaseid from intakeservicerequest where intakeserviceid='0470e432-1ad0-4015-a18f-6db7c9d547c5'),
	'assignment','W',now()::date);