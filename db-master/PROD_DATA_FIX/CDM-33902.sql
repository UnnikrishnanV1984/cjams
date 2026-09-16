/*
 * CDM-33902 - need expungment tab
 * Customer Email ID:elizabeth.long@maryland.gov
 * Customer Name:Elizabeth Long
 * Focus Area:Court: Other
 * Description - CW2636923:On older appeals case, no expungement tab to change finding to indicated unnamed maltreator. Can edit appeal/ finalize 
 * but no expungement tab to change to unnamed maltreator.
 * Case# CW2636923, start date: 9/1/2023
 * Create a case assignment for elizabeth.long@maryland.gov as below and make sure the case is displaying in her appeal work dashboard.
 * 
 */

--select * from userprofile where fullname = 'Susan Glorioso'; -- 8c0e1774-c485-4f55-a1a1-8ca6a7323a46
--select * from userprofile where fullname = 'Elizabeth Long'; -- b28a47f7-fb75-4f4e-9e15-da1ea41d71c3
--"intakeserviceid": "d44216d0-b96c-4ac2-9d74-15b95b872ba4"
--select * from team where teamname = 'In Home Services Unit 2' and countyid = 'bbce9638-24f9-4336-993c-007f6755c980';-- aa902e82-ef46-43f2-81c8-b24fa69c3ed2
--select * from county where countyid ='bbce9638-24f9-4336-993c-007f6755c980'; -- Howard

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
	(	cjams.gen_random_uuid(), cjams.gen_random_uuid(), NULL, '8c0e1774-c485-4f55-a1a1-8ca6a7323a46', NULL, NULL, 
		'b28a47f7-fb75-4f4e-9e15-da1ea41d71c3', NULL, NULL, NULL, 
		now(), now(), NULL, NULL, NULL, NULL, NULL, 
		'CDM-33902', 'CDM-33902', now(), now(), 'servicerequest', 'd44216d0-b96c-4ac2-9d74-15b95b872ba4', 
		NULL, 1, '09/01/2023', NULL, 
		'aa902e82-ef46-43f2-81c8-b24fa69c3ed2', 'aa902e82-ef46-43f2-81c8-b24fa69c3ed2', 
		NULL, NULL, 'bbce9638-24f9-4336-993c-007f6755c980', 'bbce9638-24f9-4336-993c-007f6755c980', 
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
	(	cjams.gen_random_uuid(), 'APPL', '8c0e1774-c485-4f55-a1a1-8ca6a7323a46', 'b28a47f7-fb75-4f4e-9e15-da1ea41d71c3', 
		'aa902e82-ef46-43f2-81c8-b24fa69c3ed2', 'CWSP', 'CWSP', 'd44216d0-b96c-4ac2-9d74-15b95b872ba4', 
		15, 1, 'CDM-31574', now(), 'CDM-31574', now(), 
		true, '', NULL, 'Appeal Review', NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
	);

--select currentstatustypekey  , * from intakeservicerequestdispositioncode where intakeservicerequestdispositioncodeid = '270c9c43-b97e-47e4-b3d8-acc05cfe50f1'
--select * from intakeserreqstatustype where intakeserreqstatustypekey  = 'Completed'; --7995cecb-062d-406c-8ea9-b1da4b1877d8
--backup intakeserreqstatustypeid = 642f18b0-ef6e-4d4b-9871-acc0734f3f5a
UPDATE cjams.intakeservicerequestdispositioncode
SET updatedby='CDM-31574', updatedon=now(), intakeserreqstatustypeid='7995cecb-062d-406c-8ea9-b1da4b1877d8'::uuid 
WHERE intakeservicerequestdispositioncodeid='270c9c43-b97e-47e4-b3d8-acc05cfe50f1'::uuid;


-- intakeserreqstatustypeid
-- Old 642f18b0-ef6e-4d4b-9871-acc0734f3f5a - Closed
-- New 7995cecb-062d-406c-8ea9-b1da4b1877d8 - Completed

select intakeserreqstatustypeid, updatedby, updatedon 
from intakeservicerequest 
where intakeserviceid = 'd44216d0-b96c-4ac2-9d74-15b95b872ba4'
	and activeflag = 1;
	
update intakeservicerequest 
set	intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8', -- Completed
	updatedby = 'CDM-31574', 
	updatedon = now()
where intakeserviceid = 'd44216d0-b96c-4ac2-9d74-15b95b872ba4'
	and activeflag = 1;	