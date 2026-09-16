/*
   Issue Description: CDM-31846
   Category/ Module  :  Assignment
   Root cause: user requested to do caseassignment for appeal worker
   Pull request# for code fix: 
   Reason why no related code fix: 
    requested a data fix to resolve
*/

INSERT INTO cjams.caseassignment
	(	caseassignmentid, eventidno_fk, eventdttmkey_fk, fromworkeridno, fromsupervisoridno, fromofficecode, 
		toworkeridno, tosupervisoridno, toofficecode, caseassigncode, 
		effectivedate, effectivetime, frombizunitidno, tobizunitidno, old_id, foldergroupindc, cmfldrgrpasgnkey, 
		insertedby, updatedby, insertedon, updatedon, objecttypekey, objectid, 
		responsibilitytypekey, activeflag, startdate, enddate, 
		fromteamid, toteamid, 
		remarks, statustypekey, fromldssid, toldssid, 
		assignmenttype, fk_id, assigndate, isrestricted, assigndescription, summary, 
		isnew, expungementflag, entityopendate, etl_userid, etl_load_date, servicetype, transferreason, communicationtype
		)
VALUES
	(	cjams.gen_random_uuid(), cjams.gen_random_uuid(), NULL, 'cbedde2c-e07f-4a68-9978-2f128bc59c96', NULL, NULL, 
		'22f78177-19c0-4bb2-a921-c133de3590cd', NULL, NULL, NULL, 
		now(), now(), NULL, NULL, NULL, NULL, NULL, 
		'CDM-31846', 'CDM-31846', now(), now(), 'servicerequest', '096dc819-422a-4aeb-8a23-d79ba3e38e61', 
		NULL, 1, now(), NULL, 
		'e58453de-fe0b-40ec-bf8b-3fbf5cbbfd2a', '13235932-5e81-4427-a9d0-affbc6001410', 
		NULL, NULL, 'f5214cb2-953e-41a9-a4ad-71341501e2ad', 'f5214cb2-953e-41a9-a4ad-71341501e2ad', 
		'W', NULL, now(), NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL, NULL, NULL
	);


    INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, tosecurityusersid, 
		teamid, fromroleid, toroleid, objectid, 
		routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, 
		old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	cjams.gen_random_uuid(), 'APPL', 'cbedde2c-e07f-4a68-9978-2f128bc59c96', '22f78177-19c0-4bb2-a921-c133de3590cd', 
		'e58453de-fe0b-40ec-bf8b-3fbf5cbbfd2a', 'CWSP', 'CWSP', '096dc819-422a-4aeb-8a23-d79ba3e38e61', 
		15, 1, 'CDM-31846', now(), 'CDM-31846', now(), 
		true, '', NULL, 'Appeal Review', NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	);