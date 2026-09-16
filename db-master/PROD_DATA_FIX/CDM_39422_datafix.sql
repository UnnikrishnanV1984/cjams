
/* 
    Issue Description: CDM-39422
  Category/ Module  : Approval
  Root cause: User request to create service case assigned to intakenumber to brittany with administrative role
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: 
  Backup before update/ delete: 
*/

select * from cjams.createservicecase('941525b9-966c-4247-9bd1-b2e5305b4db5','',1,'63fb46b7-bd92-407f-914a-2ffdc3c2d81f','ASSGN','CDM-39422');

INSERT INTO caseassignment
	(fromworkeridno, toworkeridno, insertedby, updatedby, insertedon, updatedon,startdate, objecttypekey, objectid,
	responsibilitytypekey,assignmenttype,assigndate, fromteamid, toteamid)
	VALUES('63fb46b7-bd92-407f-914a-2ffdc3c2d81f','3dcf7f61-694f-47a3-a620-a9b167fab71e','63fb46b7-bd92-407f-914a-2ffdc3c2d81f','CDM-39422','2024-06-05 00:00:00.000',now(),'2024-06-05 00:00:00.000','servicecase',(select servicecaseid from intakeservicerequest where intakeserviceid='941525b9-966c-4247-9bd1-b2e5305b4db5'),
	'administrative','W','2024-06-05 00:00:00.000','3488c161-40cc-44bd-b3e5-10c1252a4da2', '3488c161-40cc-44bd-b3e5-10c1252a4da2');
