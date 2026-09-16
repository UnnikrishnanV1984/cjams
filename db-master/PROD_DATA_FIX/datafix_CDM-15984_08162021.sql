-- CDM-15984 - Void placement
/*
-- Issue Description: 
   User Request to Void the Placement
   
-- Case ID: 3221787 - shanee.davis@maryland.gov
-- Client ID: 1722787 (PAUL	E BOSTON) - 2005e795-80e9-4f9a-860c-63e9fee96025
-- Placement ID: 1560541 - 2020-12-29 To 2021-01-25 - 3fa2643f-0151-4e94-a5cd-43bb9dde12ac
-- Private Organization: 5000748 (The Children's Home, Inc.)
-- RCC Facility: 5000751 (The Children's Home Long Term Care Group Home)	
-- Program: 50002337 (Group Home/205 Bloombsbury Ave) - 2020-07-01 To 2022-06-30

-- Category/ Module: Placements  (Case Management) 
-- Root cause: Currently CJAMS is not allowing the users to modify the placement dates after the exit.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/


-- Case worker: ShaneeDavis-Campbell - bc99ad0f-e2e6-40c6-971b-5812bce5ec2b 
-- Supervisor Name: Kathryn Morton - ba2dbc8f-3213-4b1b-9905-d643e1692db1
-- Team ID of Supervisor: e8a55980-6200-4344-810f-7bef323920e4 

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
(	gen_random_uuid(), '3fa2643f-0151-4e94-a5cd-43bb9dde12ac', current_date, '2020-12-29 00:00:00', '17:00', 
	'2021-01-25 00:00:00', '08:00', NULL, NULL, '', 
	'3045', current_date, '1', now(), 'CDM-15984', 
	now(), 'CDM-15984', 1, nextval('sequence_placementrevision'::regclass), 'WKER', 
	'Placement void Request.', NULL, NULL, NULL, NULL, 
	1, now(), 'bc99ad0f-e2e6-40c6-971b-5812bce5ec2b', now(), 'ba2dbc8f-3213-4b1b-9905-d643e1692db1', 
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
(	gen_random_uuid(), '3fa2643f-0151-4e94-a5cd-43bb9dde12ac', current_date, '2020-12-29 00:00:00', '17:00', 
	'2021-01-25 00:00:00', '08:00', NULL, NULL, '', 
	'3047', current_date, '1', now(), 'CDM-15984', 
	now(), 'CDM-15984', 1, nextval('sequence_placementrevision'::regclass), 'WKER', 
	'Placement voided.', NULL, NULL, NULL, NULL, 
	1, now(), 'bc99ad0f-e2e6-40c6-971b-5812bce5ec2b', now(), 'ba2dbc8f-3213-4b1b-9905-d643e1692db1', 
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
	updatedby = 'CDM-15984', 
	updatedon = now()
where placementid = '3fa2643f-0151-4e94-a5cd-43bb9dde12ac' 
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
	(	gen_random_uuid(), 'PLTR', 'bc99ad0f-e2e6-40c6-971b-5812bce5ec2b', 'ba2dbc8f-3213-4b1b-9905-d643e1692db1', 
		'e8a55980-6200-4344-810f-7bef323920e4', 'CWCW', 'CWSP', '3fa2643f-0151-4e94-a5cd-43bb9dde12ac', 15, 0, 
		'CDM-15984', now(), 'CDM-15984', now(), true, 
		'', NULL, 'Placement Void Submitted for review', '3154214', 'Servicecase', 
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
	(	gen_random_uuid(), 'PLTR', 'ba2dbc8f-3213-4b1b-9905-d643e1692db1', 'bc99ad0f-e2e6-40c6-971b-5812bce5ec2b', 
		'e8a55980-6200-4344-810f-7bef323920e4', 'CWSP', 'CWCW', '3fa2643f-0151-4e94-a5cd-43bb9dde12ac', 16, 1, 
		'CDM-15984', now(), 'CDM-15984', now(), true, 
		'', NULL, 'Child Placement Void Approved', '3154214', 'Servicecase', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL
	);

-- No pending placement validation

-- Closed Placement - NO Vacancy updates required
