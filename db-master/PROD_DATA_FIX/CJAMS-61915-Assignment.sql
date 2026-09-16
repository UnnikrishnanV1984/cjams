/*
Issue Description:Dashboard:CH: Buckreis, Ashley #241022957857. May you please assign me this case with the date after it was closed in CPS? The supervisor at the time is no longer with our Agency and no other supervisors can assign it to me. Thank you! Screen
Root cause: User requert to  add  CPS IR case to the appeal coordinator due to they do not access do that.
Fix provided: DB query to udate documentproperties,documentattachment.
Data/Code fix ticket#:CJAMS-61915
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#:  no
Reason why no related code fix:User error, not logic error.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
delete from caseassignment where updatedby='CJAMS-61915';
delete from routing where updatedby='CJAMS-61915';
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
	(	cjams.gen_random_uuid(), cjams.gen_random_uuid(), NULL, 'c132839a-76e5-498d-a8bd-306591287fc4', NULL, NULL, 
		'22f78177-19c0-4bb2-a921-c133de3590cd', NULL, NULL, NULL, 
		now(), now(), NULL, NULL, NULL, NULL, NULL, 
		'CJAMS-61915', 'CJAMS-61915', now(), now(), 'servicerequest', 'f7c35db8-4d76-4a6c-b8e5-8be84023e5d4', 
		NULL, 1, now(), NULL, 
		'ca9a68a7-3cfa-4f3d-999e-2f0785604dab', 'de12a5e3-d28e-4618-ad95-1b739145fc97', 
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
	(	cjams.gen_random_uuid(), 'APPL', 'c132839a-76e5-498d-a8bd-306591287fc4', '22f78177-19c0-4bb2-a921-c133de3590cd', 
		'de12a5e3-d28e-4618-ad95-1b739145fc97', 'CWSP', 'CWSP', 'f7c35db8-4d76-4a6c-b8e5-8be84023e5d4', 
		15, 1, 'CJAMS-61915', now(), 'CJAMS-61915', now(), 
		true, '', NULL, 'Appeal Review', '241022957857', NULL, 
		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	);
