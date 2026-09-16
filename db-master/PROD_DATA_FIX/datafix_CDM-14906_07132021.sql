-- CDM-14906 - Provider should not have been paid
/*
-- Issue Description: 
   User request to void the below Placement:
   
-- Case ID: 3122982
-- Client ID: 4258597 (A'ZURI REESE) - e5b6f598-a6de-4722-9bdb-389362d4cda4
-- Placement ID: 1559861 - 2020-12-23 To 2021-03-10 - 185dd98f-e0b7-4512-bd6a-badfc0381175
-- Private Organization: 5000882 (Pressley Ridge, Inc.)
-- CPA Office: 5091998 (Pressley Ridge - Second Generations ILP Greenbelt)
-- Program ID: 15364 (Second Generations TMP-IL) - 	2007-04-16 To 2022-06-30

-- Category/ Module: Placements  (Case Management) 
-- Root cause: Currently CJAMS is not allowing the users to modify or void the placement dates after the exit.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- placementrevision - Void
-- REQUESTED BY: Felicia Atueyi - f6f95c13-d3b3-4ceb-bd19-0a8e54dc93ae
-- APPROVED by: Susan McEachron - 7938acb3-e80b-4caa-9ef0-1ddd9725a54f
-- Team ID: 563c98a3-d333-4afa-aa83-dae6144aa4b9

-- CP -	Correcting the Placement (Placement never existed)
 
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
(	gen_random_uuid(), '185dd98f-e0b7-4512-bd6a-badfc0381175', current_date, '2020-12-23 00:00:00', '12:00', 
	'2021-03-10 00:00:00', '08:00', NULL, NULL, '', 
	'3045', current_date, '1', now(), 'CDM-14906', 
	now(), 'CDM-14906', 1, nextval('sequence_placementrevision'::regclass), 'CP', 
	'Placement void Request.', NULL, NULL, NULL, NULL, 
	1, now(), 'f6f95c13-d3b3-4ceb-bd19-0a8e54dc93ae', now(), '7938acb3-e80b-4caa-9ef0-1ddd9725a54f', 
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
(	gen_random_uuid(), '185dd98f-e0b7-4512-bd6a-badfc0381175', current_date, '2020-12-23 00:00:00', '12:00', 
	'2021-03-10 00:00:00', '08:00', NULL, NULL, '', 
	'3047', current_date, '1', now(), 'CDM-14906', 
	now(), 'CDM-14906', 1, nextval('sequence_placementrevision'::regclass), 'CP', 
	'Placement voided.', NULL, NULL, NULL, NULL, 
	1, now(), 'f6f95c13-d3b3-4ceb-bd19-0a8e54dc93ae', now(), '7938acb3-e80b-4caa-9ef0-1ddd9725a54f', 
	now(), NULL, NULL, NULL, 'Approved'
);

-- placement update
update placement 
set isvoided = 1, 
	voidapprovaldate = current_date, 
	voidapprovalstatustypekey = '3047', 
	voiddate = current_date, 
	enddatetime = current_date,
	voidreasontypekey = 'CP',
	updatedby = 'CDM-14906', 
	updatedon = now()
where placementid = '185dd98f-e0b7-4512-bd6a-badfc0381175' 
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
	(	gen_random_uuid(), 'PLTR', 'f6f95c13-d3b3-4ceb-bd19-0a8e54dc93ae', '7938acb3-e80b-4caa-9ef0-1ddd9725a54f', 
		'563c98a3-d333-4afa-aa83-dae6144aa4b9', 'CWCW', 'CWSP', '185dd98f-e0b7-4512-bd6a-badfc0381175', 15, 0, 
		'CDM-14906', now(), 'CDM-14906', now(), true, 
		'', NULL, 'Placement Void Submitted for review', '3122982', 'Servicecase', 
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
	(	gen_random_uuid(), 'PLTR', '7938acb3-e80b-4caa-9ef0-1ddd9725a54f', 'f6f95c13-d3b3-4ceb-bd19-0a8e54dc93ae', 
		'563c98a3-d333-4afa-aa83-dae6144aa4b9', 'CWSP', 'CWCW', '185dd98f-e0b7-4512-bd6a-badfc0381175', 16, 1, 
		'CDM-14906', now(), 'CDM-14906', now(), true, 
		'', NULL, 'Child Placement Void Approved', '3122982', 'Servicecase', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL
	);

-- NO updates to placement validations - No Pending validations

-- Closed Placement - NO Vacancy updates required

