-- CDM-15051 - void placement
/*
-- Issue Description: 
   User request to void the below placement
   
-- Case ID: 3123108
-- Client ID: 1667882 (KA-CEE Q	PARKER) - 5f2d0258-21d5-422a-a345-e4d7db5a70c7
-- Placement ID: 1563012 - 2021-04-30 To 2021-06-09 - bcc22e49-3331-4d0a-a2e0-2a1705ad2093
-- Private Organization: 5000788 (Hearts and Homes For Youth, Inc.)
-- RCC Facility: 5000793 (Hearts and Homes - Helen Smith Girls Group Home)
-- Program ID: 50002350	(Group Home/HI Intensity/Helen Smith) - 2020-07-01 To 2022-06-30	

-- Category/ Module: Placements  (Case Management) 
-- Root cause: Currently CJAMS is not allowing the users to modify or void the placement dates after the exit.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- Requestor: d0d8ef63-c0e3-4e1c-8d3b-f37b486d03c9	Tamara Lee
-- Supervisor: 95558df3-ac2c-47ad-93e4-c30889c8c8c9	Erica Fowlkes
-- Team : 1845ecff-4d1d-4c57-9f76-013b698bc3c6

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
(	gen_random_uuid(), 'bcc22e49-3331-4d0a-a2e0-2a1705ad2093', current_date, '2021-04-30 00:00:000', '13:00', 
	'2021-06-09 00:00:00', '00:00', NULL, NULL, '', 
	'3045', current_date, '1', now(), 'CDM-15051', 
	now(), 'CDM-15051', 1, nextval('sequence_placementrevision'::regclass), 'WKER', 
	'Placement void Request.', NULL, NULL, NULL, NULL, 
	1, now(), 'd0d8ef63-c0e3-4e1c-8d3b-f37b486d03c9', now(), '95558df3-ac2c-47ad-93e4-c30889c8c8c9', 
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
(	gen_random_uuid(), 'bcc22e49-3331-4d0a-a2e0-2a1705ad2093', current_date, '2021-04-30 00:00:000', '13:00', 
	'2021-06-09 00:00:00', '00:00', NULL, NULL, '', 
	'3047', current_date, '1', now(), 'CDM-15051', 
	now(), 'CDM-15051', 1, nextval('sequence_placementrevision'::regclass), 'WKER', 
	'Placement voided.', NULL, NULL, NULL, NULL, 
	1, now(), 'd0d8ef63-c0e3-4e1c-8d3b-f37b486d03c9', now(), '95558df3-ac2c-47ad-93e4-c30889c8c8c9', 
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
	updatedby = 'CDM-15051', 
	updatedon = now()
where placementid = 'bcc22e49-3331-4d0a-a2e0-2a1705ad2093' 
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
	(	gen_random_uuid(), 'PLTR', 'd0d8ef63-c0e3-4e1c-8d3b-f37b486d03c9', '95558df3-ac2c-47ad-93e4-c30889c8c8c9', 
		'1845ecff-4d1d-4c57-9f76-013b698bc3c6', 'CWCW', 'CWSP', 'bcc22e49-3331-4d0a-a2e0-2a1705ad2093', 15, 0, 
		'CDM-15051', now(), 'CDM-15051', now(), true, 
		'', NULL, 'Placement Void Submitted for review', '3123108', 'Servicecase', 
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
	(	gen_random_uuid(), 'PLTR', '95558df3-ac2c-47ad-93e4-c30889c8c8c9', 'd0d8ef63-c0e3-4e1c-8d3b-f37b486d03c9', 
		'1845ecff-4d1d-4c57-9f76-013b698bc3c6', 'CWSP', 'CWCW', 'bcc22e49-3331-4d0a-a2e0-2a1705ad2093', 16, 1, 
		'CDM-15051', now(), 'CDM-15051', now(), true, 
		'', NULL, 'Child Placement Void Approved', '3123108', 'Servicecase', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL
	);

-- NO updates to placement validations - Nothing is pending

-- Closed Placement - NO Vacancy updates required
