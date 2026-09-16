/*
   Issue Description: CDM-44122
   Category/ Module  : Create Service case for Intake #I251013219367 .
   Root cause: User requested to create a service case linked to existing intake request.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


select * from cjams.createservicecase
('9fd603f6-14c7-4bd5-b761-c488ba375061', null, 1, 'b2a9bdd3-f60a-436c-91a5-adc3fdcd4d35','intake');

INSERT INTO caseassignment
	(fromworkeridno, toworkeridno, insertedby, updatedby, insertedon, updatedon,startdate, objecttypekey, objectid,
	responsibilitytypekey,assignmenttype,assigndate)
	VALUES('b2a9bdd3-f60a-436c-91a5-adc3fdcd4d35','b2a9bdd3-f60a-436c-91a5-adc3fdcd4d35',
	'b2a9bdd3-f60a-436c-91a5-adc3fdcd4d35','CDM-44122',now(),now(),now(),'servicecase',
	(select servicecaseid from intakeservicerequest where intakeserviceid='9fd603f6-14c7-4bd5-b761-c488ba375061'),
	'assignment','W',now()::date);