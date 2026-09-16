-- CDM-14952 - Placement
/*
-- Issue Description: 
   User request to void the below placement:

-- Case ID: 3272107 - brenda.alwine@maryland.gov (renee.pierson2@maryland.gov)
-- Client ID: 4285758 (MASON HUNT) - 0af44a9e-c8a7-4e66-8c54-b138f11391f3
-- Placement ID: 1563915 - 2021-06-17 To 2021-06-24 - 5c85d6a1-0868-451b-9eb4-d0a66a36808e
-- Provider ID: 5095593	(Claire Perna Hambel) - Local Department Home

-- Category/ Module: Placements  (Case Management) 
-- Root cause: Currently CJAMS is not allowing the users to modify or void the placement dates after the exit.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- Case worker: 3a226208-4d64-4180-aa50-10a0a5ddbd98 (Renee Pierson)
-- Supervisor Name: 330d12cd-f428-41b9-b332-36e53fe5f16a (Brenda Alwine) 
-- Team: da6e89a1-82e1-46f7-a90e-d41a3987591d

-- Placementrevision - Void 
INSERT INTO cjams.placementrevision
(	placementrevisionid, placementid, transactiondate, entrydate, entrytime, 
	exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, 
	approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, 
	updatedon, updatedby, activeflag, alternateid, voidreasontypekey, 
	voidremarks, enddate, endtime, exittypekey, remarks, 
	isvoided, voiddate, requestedby, requesteddate, approvedby, 
	approveddate, etl_userid, etl_load_date, ischangepreadoptive, status
)
VALUES
(	gen_random_uuid(), '5c85d6a1-0868-451b-9eb4-d0a66a36808e', current_date, '2021-06-17 00:00:00', '12:30', 
	'2021-06-24 00:00:00', '14:00', NULL, NULL, '', 
	'3045', current_date, '1', now(), 'CDM-14952', 
	now(), 'CDM-14952', 1, nextval('sequence_placementrevision'::regclass), 'WKER', 
	'Placement void Request.', NULL, NULL, NULL, NULL, 
	1, now(), '3a226208-4d64-4180-aa50-10a0a5ddbd98', now(), '330d12cd-f428-41b9-b332-36e53fe5f16a', 
	now(), NULL, NULL, NULL, 'Approved'
);

INSERT INTO cjams.placementrevision
(	placementrevisionid, placementid, transactiondate, entrydate, entrytime, 
	exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, 
	approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, 
	updatedon, updatedby, activeflag, alternateid, voidreasontypekey, 
	voidremarks, enddate, endtime, exittypekey, remarks, 
	isvoided, voiddate, requestedby, requesteddate, approvedby, 
	approveddate, etl_userid, etl_load_date, ischangepreadoptive, status
)
VALUES
(	gen_random_uuid(), '5c85d6a1-0868-451b-9eb4-d0a66a36808e', current_date, '2021-06-17 00:00:00', '12:30', 
	'2021-06-24 00:00:00', '14:00', NULL, NULL, '', 
	'3047', current_date, '1', now(), 'CDM-14952', 
	now(), 'CDM-14952', 1, nextval('sequence_placementrevision'::regclass), 'WKER', 
	'Placement voided.', NULL, NULL, NULL, NULL, 
	1, now(), '3a226208-4d64-4180-aa50-10a0a5ddbd98', now(), '330d12cd-f428-41b9-b332-36e53fe5f16a', 
	now(), NULL, NULL, NULL, 'Approved'
);

-- placement update
update placement 
set isvoided = 1, 
	voidapprovaldate = current_date, 
	voidapprovalstatustypekey = '3047', 
	voiddate = current_date, 
	enddatetime = current_date,
	voidreasontypekey = 'WKER',
	updatedby = 'CDM-14952', 
	updatedon = now()
where placementid = '5c85d6a1-0868-451b-9eb4-d0a66a36808e' 
	and activeflag = 1 ;
	
-- rounting
INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, tosecurityusersid, 
		teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, isreviewrequest, 
		remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, 
		old_from_id, old_to_id, principaltype, actiondatetime, etl_userid,
		etl_load_date, entityid, reassignnotes
	)
VALUES
	(	gen_random_uuid(), 'PLTR', '3a226208-4d64-4180-aa50-10a0a5ddbd98', '330d12cd-f428-41b9-b332-36e53fe5f16a', 
		'da6e89a1-82e1-46f7-a90e-d41a3987591d', 'CWCW', 'CWSP', '5c85d6a1-0868-451b-9eb4-d0a66a36808e', 15, 0, 
		'CDM-14952', now(), 'CDM-14952', now(), true, 
		'', NULL, 'Placement Void Submitted for review', '3272107', 'Servicecase', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL
	);

INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, tosecurityusersid, 
		teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, isreviewrequest, 
		remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, 
		old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, 
		etl_load_date, entityid, reassignnotes
	)
VALUES
	(	gen_random_uuid(), 'PLTR', '330d12cd-f428-41b9-b332-36e53fe5f16a', '3a226208-4d64-4180-aa50-10a0a5ddbd98', 
		'da6e89a1-82e1-46f7-a90e-d41a3987591d', 'CWSP', 'CWCW', '5c85d6a1-0868-451b-9eb4-d0a66a36808e', 16, 1, 
		'CDM-14952', now(), 'CDM-14952', now(), true, 
		'', NULL, 'Child Placement Void Approved', '3272107', 'Servicecase', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL
	);

-- Delete pending placement validation(s) 
select placement_id, validation_start_dt, validation_end_dt, delete_sw, update_ts, update_user_id 
	from tb_placement_validation 
where placement_id = 1563915
	and delete_sw  = 'N' ;

Update tb_placement_validation 
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-14952'
where placement_id = 1563915
	and delete_sw  = 'N' ;

-- Closed Placement - NO Vacancy updates required

