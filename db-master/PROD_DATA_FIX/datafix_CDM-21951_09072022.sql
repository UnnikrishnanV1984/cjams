-- CDM-21951 - CJAMS A/R
/*
-- Issue Description: 
   User Request to Void the Placement

-- Case ID: 3252447 - cornella.johnson@maryland.gov
-- Client ID: 2860260 (DIERRA NICOLE HARDEN) - 2de8b859-687f-4751-ae50-fa8d92d6223a
-- Private Organization: 5000882 (Pressley Ridge, Inc.)
-- CPA Office: 5061783 (Pressley Ridge Caroline St)
-- Program ID: 50002239	(TFC-Teen Mother's Program)
-- User request to void - 1563293 - 2021-03-23 To 2022-02-04 - 255f95b0-3458-4314-b64b-d49621156e7b

-- Category/ Module: Placements  (Case Management) 
-- Root cause: Closed Case with Duplicate Overlapping Placements
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Case worker: Cornella Johnson - df7b7383-12c5-40b8-81d4-43ad75d71b7c
-- Supervisor Name: SGilbert - f3ba0abc-1278-4f79-ae3c-dfb167940c87
-- Team ID: 1d7a4627-4136-4ba3-94b8-727185c4dfdd

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
(	gen_random_uuid(), '255f95b0-3458-4314-b64b-d49621156e7b', current_date, '2020-11-25 00:00:00', '08:00', 
	'2021-03-01 00:00:00', '00:00', NULL, NULL, '', 
	'3045', current_date, '1', now(), 'CDM-21951', 
	now(), 'CDM-21951', 1, nextval('sequence_placementrevision'::regclass), 'WKER', 
	'Placement void Request.', NULL, NULL, NULL, NULL, 
	1, now(), 'df7b7383-12c5-40b8-81d4-43ad75d71b7c', now(), 'f3ba0abc-1278-4f79-ae3c-dfb167940c87', 
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
(	gen_random_uuid(), '255f95b0-3458-4314-b64b-d49621156e7b', current_date, '2020-11-25 00:00:00', '08:00', 
	'2021-03-01 00:00:00', '00:00', NULL, NULL, '', 
	'3047', current_date, '1', now(), 'CDM-21951', 
	now(), 'CDM-21951', 1, nextval('sequence_placementrevision'::regclass), 'WKER', 
	'Placement voided.', NULL, NULL, NULL, NULL, 
	1, now(), 'df7b7383-12c5-40b8-81d4-43ad75d71b7c', now(), 'f3ba0abc-1278-4f79-ae3c-dfb167940c87', 
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
	updatedby = 'CDM-21951', 
	updatedon = now()
where placementid = '255f95b0-3458-4314-b64b-d49621156e7b' 
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
	(	gen_random_uuid(), 'PLTR', 'df7b7383-12c5-40b8-81d4-43ad75d71b7c', 'f3ba0abc-1278-4f79-ae3c-dfb167940c87', 
		'1d7a4627-4136-4ba3-94b8-727185c4dfdd', 'CWCW', 'CWSP', '255f95b0-3458-4314-b64b-d49621156e7b', 15, 0, 
		'CDM-21951', now(), 'CDM-21951', now(), true, 
		'', NULL, 'Placement Void Submitted for review', '3252447', 'Servicecase', 
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
	(	gen_random_uuid(), 'PLTR', 'f3ba0abc-1278-4f79-ae3c-dfb167940c87', 'df7b7383-12c5-40b8-81d4-43ad75d71b7c', 
		'1d7a4627-4136-4ba3-94b8-727185c4dfdd', 'CWSP', 'CWCW', '255f95b0-3458-4314-b64b-d49621156e7b', 16, 1, 
		'CDM-21951', now(), 'CDM-21951', now(), true, 
		'', NULL, 'Child Placement Void Approved', '3252447', 'Servicecase', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL
	);

-- No pending placement validation

-- Closed Placement - NO Vacancy updates required
