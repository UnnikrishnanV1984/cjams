-- CDM-16396 - Provider
/*
-- Issue Description: 
   User Request to Void the Placement

-- Case ID: 3299463
-- Client ID: 1740697 (TANIYAH DARCEL BROWN) - fcf091ca-8576-4b5d-a5a9-c45eeccdb9c3
-- Placement ID: 1559738 - 2020-11-25 To 2021-03-01 - 75c27042-dfc1-4108-b9b0-669c4b83a524
-- Private Organization: 5000748 (The Children's Home, Inc.)
-- RCC Facility: 5000751 (The Children's Home Long Term Care Group Home)
-- Program : 1384 (Children's Home Long Term Care Home) - 2006-07-01 To 2021-03-31
-- Placement Structure: Residential Group Homes

-- Category/ Module: Placements  (Case Management) 
-- Root cause: Currently CJAMS is not allowing the users to modify the placement dates after the exit.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- Case worker: Chandler C. Johnson - 4a79ac81-fef4-4d9c-9d52-2c3003967098
-- Supervisor Name: Daniel A. Johnson - 251ca32d-4b6f-460e-ab34-0d740c55b6dd
-- Team ID: 98e48338-6869-410f-a272-ff58cfc80a00

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
(	gen_random_uuid(), '75c27042-dfc1-4108-b9b0-669c4b83a524', current_date, '2020-11-25 00:00:00', '08:00', 
	'2021-03-01 00:00:00', '00:00', NULL, NULL, '', 
	'3045', current_date, '1', now(), 'CDM-16396', 
	now(), 'CDM-16396', 1, nextval('sequence_placementrevision'::regclass), 'WKER', 
	'Placement void Request.', NULL, NULL, NULL, NULL, 
	1, now(), '4a79ac81-fef4-4d9c-9d52-2c3003967098', now(), '251ca32d-4b6f-460e-ab34-0d740c55b6dd', 
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
(	gen_random_uuid(), '75c27042-dfc1-4108-b9b0-669c4b83a524', current_date, '2020-11-25 00:00:00', '08:00', 
	'2021-03-01 00:00:00', '00:00', NULL, NULL, '', 
	'3047', current_date, '1', now(), 'CDM-16396', 
	now(), 'CDM-16396', 1, nextval('sequence_placementrevision'::regclass), 'WKER', 
	'Placement voided.', NULL, NULL, NULL, NULL, 
	1, now(), '4a79ac81-fef4-4d9c-9d52-2c3003967098', now(), '251ca32d-4b6f-460e-ab34-0d740c55b6dd', 
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
	updatedby = 'CDM-16396', 
	updatedon = now()
where placementid = '75c27042-dfc1-4108-b9b0-669c4b83a524' 
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
	(	gen_random_uuid(), 'PLTR', '4a79ac81-fef4-4d9c-9d52-2c3003967098', '251ca32d-4b6f-460e-ab34-0d740c55b6dd', 
		'98e48338-6869-410f-a272-ff58cfc80a00', 'CWCW', 'CWSP', '75c27042-dfc1-4108-b9b0-669c4b83a524', 15, 0, 
		'CDM-16396', now(), 'CDM-16396', now(), true, 
		'', NULL, 'Placement Void Submitted for review', '3299463', 'Servicecase', 
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
	(	gen_random_uuid(), 'PLTR', '251ca32d-4b6f-460e-ab34-0d740c55b6dd', '4a79ac81-fef4-4d9c-9d52-2c3003967098', 
		'98e48338-6869-410f-a272-ff58cfc80a00', 'CWSP', 'CWCW', '75c27042-dfc1-4108-b9b0-669c4b83a524', 16, 1, 
		'CDM-16396', now(), 'CDM-16396', now(), true, 
		'', NULL, 'Child Placement Void Approved', '3299463', 'Servicecase', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL
	);

-- No pending placement validation

-- Closed Placement - NO Vacancy updates required
