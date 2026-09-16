/*
Issue: CJAMS-61281 Unable to Assign Appeal
Category/Module: Case assignment
Root cause: Unable to assign appeals to worker Jeanne Baxter for the following cases as the cases were closed by a supervisor who is no longer working at the local agency.IR 241021934869 IR 241021935363 IR 241021963249 IR 241021979438 IR 241021987400
            SSA approval provided and data fix needs to be done to make the cases available in the appeal worker dashboard.
Fix provided: Data fix has been done to add appeal worker in the case assignment
Data/Code fix ticket#: CJAMS-61281
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: SSA approval provided for closed IR cases and data fix needs to be done for case assigment.
*/

--case number 241021934869 
--objectid :  '16914097-dbb3-4d38-88ad-bbc98723f2ec'
INSERT INTO cjams.caseassignment
(caseassignmentid, eventidno_fk, eventdttmkey_fk, fromworkeridno, fromsupervisoridno, fromofficecode, toworkeridno, tosupervisoridno, toofficecode, caseassigncode, effectivedate, effectivetime, frombizunitidno, tobizunitidno, old_id, foldergroupindc, cmfldrgrpasgnkey, insertedby, updatedby, insertedon, updatedon, objecttypekey, objectid, responsibilitytypekey, activeflag, startdate, enddate, fromteamid, toteamid, remarks, statustypekey, fromldssid, toldssid, assignmenttype, fk_id, assigndate, isrestricted, assigndescription, summary, isnew, expungementflag, entityopendate, etl_userid, etl_load_date, servicetype, transferreason, communicationtype)
VALUES(gen_random_uuid(), NULL, NULL, 'cbedde2c-e07f-4a68-9978-2f128bc59c96', NULL, NULL, '22f78177-19c0-4bb2-a921-c133de3590cd', NULL, NULL, NULL, '2024-06-03 00:00:00', '2024-06-03 00:00:00', NULL, NULL, NULL, NULL, NULL, 'CJAMS-61281', 'CJAMS-61281', now(), now(), 'servicerequest', '16914097-dbb3-4d38-88ad-bbc98723f2ec', null, 1, '2024-06-03 00:00:00', null, 'ca9a68a7-3cfa-4f3d-999e-2f0785604dab', '13235932-5e81-4427-a9d0-affbc6001410', NULL, NULL, 'f5214cb2-953e-41a9-a4ad-71341501e2ad', 'f5214cb2-953e-41a9-a4ad-71341501e2ad', 'W', NULL, '2024-06-03 00:00:00.000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, tosecurityusersid, 
		fromroleid, toroleid, objectid, 
		routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, 
		old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	cjams.gen_random_uuid(), 'APPL', 'cbedde2c-e07f-4a68-9978-2f128bc59c96', '22f78177-19c0-4bb2-a921-c133de3590cd', 
		'CWSP', 'CWSP', '16914097-dbb3-4d38-88ad-bbc98723f2ec', 
		15, 1, 'CJAMS-61281', now(), 'CJAMS-61281', now(), 
		true, '', NULL, 'Appeal Review', NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	);


--case number 241021935363
--object id: '5f1cb8c7-841d-4a1e-89a0-fc86d8332cb1'

INSERT INTO cjams.caseassignment
(caseassignmentid, eventidno_fk, eventdttmkey_fk, fromworkeridno, fromsupervisoridno, fromofficecode, toworkeridno, tosupervisoridno, toofficecode, caseassigncode, effectivedate, effectivetime, frombizunitidno, tobizunitidno, old_id, foldergroupindc, cmfldrgrpasgnkey, insertedby, updatedby, insertedon, updatedon, objecttypekey, objectid, responsibilitytypekey, activeflag, startdate, enddate, fromteamid, toteamid, remarks, statustypekey, fromldssid, toldssid, assignmenttype, fk_id, assigndate, isrestricted, assigndescription, summary, isnew, expungementflag, entityopendate, etl_userid, etl_load_date, servicetype, transferreason, communicationtype)
VALUES(gen_random_uuid(), NULL, NULL, 'cbedde2c-e07f-4a68-9978-2f128bc59c96', NULL, NULL, '22f78177-19c0-4bb2-a921-c133de3590cd', NULL, NULL, NULL, '2024-06-03 00:00:00', '2024-06-03 00:00:00', NULL, NULL, NULL, NULL, NULL, 'CJAMS-61281', 'CJAMS-61281', now(), now(), 'servicerequest', '5f1cb8c7-841d-4a1e-89a0-fc86d8332cb1', null, 1, '2024-06-03 00:00:00', null, 'ca9a68a7-3cfa-4f3d-999e-2f0785604dab', '13235932-5e81-4427-a9d0-affbc6001410', NULL, NULL, 'f5214cb2-953e-41a9-a4ad-71341501e2ad', 'f5214cb2-953e-41a9-a4ad-71341501e2ad', 'W', NULL, '2024-06-03 00:00:00.000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, tosecurityusersid, 
		fromroleid, toroleid, objectid, 
		routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, 
		old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	cjams.gen_random_uuid(), 'APPL', 'cbedde2c-e07f-4a68-9978-2f128bc59c96', '22f78177-19c0-4bb2-a921-c133de3590cd', 
		'CWSP', 'CWSP', '5f1cb8c7-841d-4a1e-89a0-fc86d8332cb1', 
		15, 1, 'CJAMS-61281', now(), 'CJAMS-61281', now(), 
		true, '', NULL, 'Appeal Review', NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	);

--case number 241021963249
--object id: '7d3ce32e-3fca-42b9-b366-b2bf39087237'

INSERT INTO cjams.caseassignment
(caseassignmentid, eventidno_fk, eventdttmkey_fk, fromworkeridno, fromsupervisoridno, fromofficecode, toworkeridno, tosupervisoridno, toofficecode, caseassigncode, effectivedate, effectivetime, frombizunitidno, tobizunitidno, old_id, foldergroupindc, cmfldrgrpasgnkey, insertedby, updatedby, insertedon, updatedon, objecttypekey, objectid, responsibilitytypekey, activeflag, startdate, enddate, fromteamid, toteamid, remarks, statustypekey, fromldssid, toldssid, assignmenttype, fk_id, assigndate, isrestricted, assigndescription, summary, isnew, expungementflag, entityopendate, etl_userid, etl_load_date, servicetype, transferreason, communicationtype)
VALUES(gen_random_uuid(), NULL, NULL, 'cbedde2c-e07f-4a68-9978-2f128bc59c96', NULL, NULL, '22f78177-19c0-4bb2-a921-c133de3590cd', NULL, NULL, NULL, '2024-06-11 00:00:00', '2024-06-11 00:00:00', NULL, NULL, NULL, NULL, NULL, 'CJAMS-61281', 'CJAMS-61281', now(), now(), 'servicerequest', '7d3ce32e-3fca-42b9-b366-b2bf39087237', null, 1, '2024-06-11 00:00:00', null, 'ca9a68a7-3cfa-4f3d-999e-2f0785604dab', '13235932-5e81-4427-a9d0-affbc6001410', NULL, NULL, 'f5214cb2-953e-41a9-a4ad-71341501e2ad', 'f5214cb2-953e-41a9-a4ad-71341501e2ad', 'W', NULL, '2024-06-11 00:00:00.000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, tosecurityusersid, 
		fromroleid, toroleid, objectid, 
		routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, 
		old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	cjams.gen_random_uuid(), 'APPL', 'cbedde2c-e07f-4a68-9978-2f128bc59c96', '22f78177-19c0-4bb2-a921-c133de3590cd', 
		'CWSP', 'CWSP', '7d3ce32e-3fca-42b9-b366-b2bf39087237', 
		15, 1, 'CJAMS-61281', now(), 'CJAMS-61281', now(), 
		true, '', NULL, 'Appeal Review', NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	);

--case number 241021979438 
--object id: '093a0d86-3a5f-4114-98c7-ea31dd7bdad7'

INSERT INTO cjams.caseassignment
(caseassignmentid, eventidno_fk, eventdttmkey_fk, fromworkeridno, fromsupervisoridno, fromofficecode, toworkeridno, tosupervisoridno, toofficecode, caseassigncode, effectivedate, effectivetime, frombizunitidno, tobizunitidno, old_id, foldergroupindc, cmfldrgrpasgnkey, insertedby, updatedby, insertedon, updatedon, objecttypekey, objectid, responsibilitytypekey, activeflag, startdate, enddate, fromteamid, toteamid, remarks, statustypekey, fromldssid, toldssid, assignmenttype, fk_id, assigndate, isrestricted, assigndescription, summary, isnew, expungementflag, entityopendate, etl_userid, etl_load_date, servicetype, transferreason, communicationtype)
VALUES(gen_random_uuid(), NULL, NULL, 'cbedde2c-e07f-4a68-9978-2f128bc59c96', NULL, NULL, '22f78177-19c0-4bb2-a921-c133de3590cd', NULL, NULL, NULL, '2024-06-21 00:00:00', '2024-06-21 00:00:00', NULL, NULL, NULL, NULL, NULL, 'CJAMS-61281', 'CJAMS-61281', now(), now(), 'servicerequest', '093a0d86-3a5f-4114-98c7-ea31dd7bdad7', null, 1, '2024-06-21 00:00:00', null, 'ca9a68a7-3cfa-4f3d-999e-2f0785604dab', '13235932-5e81-4427-a9d0-affbc6001410', NULL, NULL, 'f5214cb2-953e-41a9-a4ad-71341501e2ad', 'f5214cb2-953e-41a9-a4ad-71341501e2ad', 'W', NULL, '2024-06-21 00:00:00.000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, tosecurityusersid, 
		fromroleid, toroleid, objectid, 
		routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, 
		old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	cjams.gen_random_uuid(), 'APPL', 'cbedde2c-e07f-4a68-9978-2f128bc59c96', '22f78177-19c0-4bb2-a921-c133de3590cd', 
		'CWSP', 'CWSP', '093a0d86-3a5f-4114-98c7-ea31dd7bdad7', 
		15, 1, 'CJAMS-61281', now(), 'CJAMS-61281', now(), 
		true, '', NULL, 'Appeal Review', NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	);

--case number 241021987400 
--object id: '4ced0e70-ae04-4aa1-a2a8-06cd7f6fc06f'

INSERT INTO cjams.caseassignment
(caseassignmentid, eventidno_fk, eventdttmkey_fk, fromworkeridno, fromsupervisoridno, fromofficecode, toworkeridno, tosupervisoridno, toofficecode, caseassigncode, effectivedate, effectivetime, frombizunitidno, tobizunitidno, old_id, foldergroupindc, cmfldrgrpasgnkey, insertedby, updatedby, insertedon, updatedon, objecttypekey, objectid, responsibilitytypekey, activeflag, startdate, enddate, fromteamid, toteamid, remarks, statustypekey, fromldssid, toldssid, assignmenttype, fk_id, assigndate, isrestricted, assigndescription, summary, isnew, expungementflag, entityopendate, etl_userid, etl_load_date, servicetype, transferreason, communicationtype)
VALUES(gen_random_uuid(), NULL, NULL, 'cbedde2c-e07f-4a68-9978-2f128bc59c96', NULL, NULL, '22f78177-19c0-4bb2-a921-c133de3590cd', NULL, NULL, NULL, '2024-06-21 00:00:00', '2024-06-21 00:00:00', NULL, NULL, NULL, NULL, NULL, 'CJAMS-61281', 'CJAMS-61281', now(), now(), 'servicerequest', '4ced0e70-ae04-4aa1-a2a8-06cd7f6fc06f', null, 1, '2024-06-21 00:00:00', null, 'ca9a68a7-3cfa-4f3d-999e-2f0785604dab', '13235932-5e81-4427-a9d0-affbc6001410', NULL, NULL, 'f5214cb2-953e-41a9-a4ad-71341501e2ad', 'f5214cb2-953e-41a9-a4ad-71341501e2ad', 'W', NULL, '2024-06-21 00:00:00.000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, tosecurityusersid, 
		fromroleid, toroleid, objectid, 
		routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, 
		old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	cjams.gen_random_uuid(), 'APPL', 'cbedde2c-e07f-4a68-9978-2f128bc59c96', '22f78177-19c0-4bb2-a921-c133de3590cd', 
		'CWSP', 'CWSP', '4ced0e70-ae04-4aa1-a2a8-06cd7f6fc06f', 
		15, 1, 'CJAMS-61281', now(), 'CJAMS-61281', now(), 
		true, '', NULL, 'Appeal Review', NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	);
