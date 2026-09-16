-- CDM-15217 - Need to VOID a Placement
/*
-- Issue Description: 
   User request to void the below placement:

-- Case ID: 3176962
-- Client ID: 2710645 (MIYONNA KEMORA DIXON) - 83af539e-4027-476b-be78-4e1d48168840
-- Placement ID: 1563278 - 2021-05-21 To 2021-07-19 - 6dbf59e1-8345-4f67-acf6-0d626fc58d69
-- Private Organization: 5000668 (The Children's Choice Of Maryland, Inc.)
-- CPA Office: 5001617 (Children's Choice Lanham)		
-- Program ID: 222 (Treatment Foster Care) - 2005-07-01 To 2022-06-30

-- Category/ Module: Placements  (Case Management) 
-- Root cause: Currently CJAMS is not allowing the users to modify or void the placement dates after the exit.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- Case worker: 831b6bfe-c3cf-43ec-9f55-5272d945c024 (LACEY COPELIN)
-- Supervisor Name: 9f80d4f6-09f6-49ff-b892-c1474c4c2ec7 (Sameidra Carter) 
-- Team: dafa95a0-8fb4-455c-b75c-7ca8ecdaf363

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
(	gen_random_uuid(), '6dbf59e1-8345-4f67-acf6-0d626fc58d69', current_date, '2021-05-21 00:00:00', '17:00', 
	'2021-07-19 00:00:00', '08:00', NULL, NULL, '', 
	'3045', current_date, '1', now(), 'CDM-15217', 
	now(), 'CDM-15217', 1, nextval('sequence_placementrevision'::regclass), 'WKER', 
	'Placement void Request.', NULL, NULL, NULL, NULL, 
	1, now(), '831b6bfe-c3cf-43ec-9f55-5272d945c024', now(), '9f80d4f6-09f6-49ff-b892-c1474c4c2ec7', 
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
(	gen_random_uuid(), '6dbf59e1-8345-4f67-acf6-0d626fc58d69', current_date, '2021-05-21 00:00:00', '17:00', 
	'2021-07-19 00:00:00', '08:00', NULL, NULL, '', 
	'3047', current_date, '1', now(), 'CDM-15217', 
	now(), 'CDM-15217', 1, nextval('sequence_placementrevision'::regclass), 'WKER', 
	'Placement voided.', NULL, NULL, NULL, NULL, 
	1, now(), '831b6bfe-c3cf-43ec-9f55-5272d945c024', now(), '9f80d4f6-09f6-49ff-b892-c1474c4c2ec7', 
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
	updatedby = 'CDM-15217', 
	updatedon = now()
where placementid = '6dbf59e1-8345-4f67-acf6-0d626fc58d69' 
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
	(	gen_random_uuid(), 'PLTR', '831b6bfe-c3cf-43ec-9f55-5272d945c024', '9f80d4f6-09f6-49ff-b892-c1474c4c2ec7', 
		'dafa95a0-8fb4-455c-b75c-7ca8ecdaf363', 'CWCW', 'CWSP', '6dbf59e1-8345-4f67-acf6-0d626fc58d69', 15, 0, 
		'CDM-15217', now(), 'CDM-15217', now(), true, 
		'', NULL, 'Placement Void Submitted for review', '3176962', 'Servicecase', 
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
	(	gen_random_uuid(), 'PLTR', '9f80d4f6-09f6-49ff-b892-c1474c4c2ec7', '831b6bfe-c3cf-43ec-9f55-5272d945c024', 
		'dafa95a0-8fb4-455c-b75c-7ca8ecdaf363', 'CWSP', 'CWCW', '6dbf59e1-8345-4f67-acf6-0d626fc58d69', 16, 1, 
		'CDM-15217', now(), 'CDM-15217', now(), true, 
		'', NULL, 'Child Placement Void Approved', '3176962', 'Servicecase', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL
	);

-- NO updates to placement validations - Nothing is pending

-- Closed Placement - NO Vacancy updates required
