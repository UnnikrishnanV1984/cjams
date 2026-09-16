-- CDM-16263 - Void of Placements
/*
-- Issue Description: 
   User Request to Void the Placement

-- Case ID: 3154214
-- Client ID: 2064384 (JOHN	ROWELL) - 4b0fe22a-3d25-4bb2-a9f5-9c66e9fcf5a5
-- Placement ID: 1564817 - 2021-07-20 To 2021-08-11 - c89dd629-d996-4a4f-90b4-7bfcf9e50f95
-- Provider ID: 5077078	(Shannon Leffler) - Local Department Home
 	
-- Category/ Module: Placements  (Case Management) 
-- Root cause: Currently CJAMS is not allowing the users to modify the placement dates after the exit.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/


-- Case worker: Caroline Brouse - 2035a5aa-da3c-4355-a1f6-89f47a01fe8a
-- Supervisor Name: Daniel A. Johnson - 251ca32d-4b6f-460e-ab34-0d740c55b6dd
-- Team ID of Supervisor: 98e48338-6869-410f-a272-ff58cfc80a00 

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
(	gen_random_uuid(), 'c89dd629-d996-4a4f-90b4-7bfcf9e50f95', current_date, '2021-07-20 00:00:00', '19:30', 
	'2021-08-11 00:00:00', '14:15', NULL, NULL, '', 
	'3045', current_date, '1', now(), 'CDM-16263', 
	now(), 'CDM-16263', 1, nextval('sequence_placementrevision'::regclass), 'WKER', 
	'Placement void Request.', NULL, NULL, NULL, NULL, 
	1, now(), '2035a5aa-da3c-4355-a1f6-89f47a01fe8a', now(), '251ca32d-4b6f-460e-ab34-0d740c55b6dd', 
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
(	gen_random_uuid(), 'c89dd629-d996-4a4f-90b4-7bfcf9e50f95', current_date, '2021-07-20 00:00:00', '19:30', 
	'2021-08-11 00:00:00', '14:15', NULL, NULL, '', 
	'3047', current_date, '1', now(), 'CDM-16263', 
	now(), 'CDM-16263', 1, nextval('sequence_placementrevision'::regclass), 'WKER', 
	'Placement voided.', NULL, NULL, NULL, NULL, 
	1, now(), '2035a5aa-da3c-4355-a1f6-89f47a01fe8a', now(), '251ca32d-4b6f-460e-ab34-0d740c55b6dd', 
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
	updatedby = 'CDM-16263', 
	updatedon = now()
where placementid = 'c89dd629-d996-4a4f-90b4-7bfcf9e50f95' 
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
	(	gen_random_uuid(), 'PLTR', '2035a5aa-da3c-4355-a1f6-89f47a01fe8a', '251ca32d-4b6f-460e-ab34-0d740c55b6dd', 
		'98e48338-6869-410f-a272-ff58cfc80a00', 'CWCW', 'CWSP', 'c89dd629-d996-4a4f-90b4-7bfcf9e50f95', 15, 0, 
		'CDM-16263', now(), 'CDM-16263', now(), true, 
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
	(	gen_random_uuid(), 'PLTR', '251ca32d-4b6f-460e-ab34-0d740c55b6dd', '2035a5aa-da3c-4355-a1f6-89f47a01fe8a', 
		'98e48338-6869-410f-a272-ff58cfc80a00', 'CWSP', 'CWCW', 'c89dd629-d996-4a4f-90b4-7bfcf9e50f95', 16, 1, 
		'CDM-16263', now(), 'CDM-16263', now(), true, 
		'', NULL, 'Child Placement Void Approved', '3154214', 'Servicecase', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL
	);

-- No pending placement validation

-- Closed Placement - NO Vacancy updates required
