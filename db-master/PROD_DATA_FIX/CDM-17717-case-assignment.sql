 /*
 Issue Description:CDM-17717
 Category/ Module:case assignment
 Root cause: removed user
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/
INSERT INTO caseassignment
	(fromworkeridno, toworkeridno, insertedby, updatedby, insertedon, updatedon,startdate, objecttypekey, objectid,
	responsibilitytypekey,fromteamid,toteamid,fromldssid,toldssid,assignmenttype,assigndate)
	VALUES('11c49ec3-6a5b-4b09-a78a-ccaab244de50','5321bcf2-3dd0-49a5-94a4-580c0750348c','CDM-17717','CDM-17717',now(),now(),now(),'3243282','9274657c-fa9d-446e-8757-72eb53cc663f',
	'assignment','a88ea485-4e05-4c71-9765-18c5f71a6ba2','a88ea485-4e05-4c71-9765-18c5f71a6ba2','b26afb64-6b7f-462e-8074-cfdc9cce04c4','b26afb64-6b7f-462e-8074-cfdc9cce04c4','W',now()::date);
