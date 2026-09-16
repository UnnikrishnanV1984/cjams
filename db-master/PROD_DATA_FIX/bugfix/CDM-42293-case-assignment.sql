/*
 * CDM-42293 - Inserted record and updating the assigned by user
 * Description - Assigned case to appeal worker (Jeanne Baxter)
 */

INSERT INTO caseassignment
	(toldssid, toteamid, fromworkeridno, toworkeridno, insertedby, updatedby, insertedon, updatedon,startdate, objecttypekey, objectid,
	responsibilitytypekey,assignmenttype,assigndate)
	VALUES('f5214cb2-953e-41a9-a4ad-71341501e2ad', '13235932-5e81-4427-a9d0-affbc6001410', '34aa88ee-492f-4b39-800a-9fa0d8b5cef8','22f78177-19c0-4bb2-a921-c133de3590cd','34aa88ee-492f-4b39-800a-9fa0d8b5cef8','CDM-42293',now(),now(),'2024-07-19 00:00:00.000','servicecase',
	'8dfa88f3-b67e-4ee8-b8e0-8b2fb2ce6578',
	'NULL','W',now()::date);


INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, tosecurityusersid, 
		fromroleid, toroleid, objectid, 
		routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, 
		old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	cjams.gen_random_uuid(), 'APPL', '34aa88ee-492f-4b39-800a-9fa0d8b5cef8', '22f78177-19c0-4bb2-a921-c133de3590cd', 
		'CWSP', 'CWSP', '8dfa88f3-b67e-4ee8-b8e0-8b2fb2ce6578', 
		15, 1, 'CDM-42293', now(), 'CDM-42293', now(), 
		true, '', NULL, 'Appeal Review', NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	);
