-- CDM-20474 - Duplicate Provider Payments
/*
-- Issue Description: 
   User Request to Void the Placement

-- Case ID: 3252850
-- Client ID: 3754853 (DARREN BARBERO) - 27b1c8d9-9c73-4dd1-81ef-11e34667944c
-- Over Lapping Placements
-- Placement ID: 309637 - 2016-02-01 To 2018-06-30 - e861e188-580d-4a29-8831-267577a8f337
 	
-- Category/ Module: Placements  (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Case worker: Erica Thornton - 515041cb-f6b0-4148-a0c6-e89823e14815
-- Supervisor Name: Melissa DiFranco - 8c38cb86-3ca7-476e-8d52-f89c4d62be66
-- Team ID of Supervisor: 7c2ad291-af40-418d-97a0-7871ceb16f90 - Independent Living 1


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
(	gen_random_uuid(), 'e861e188-580d-4a29-8831-267577a8f337', current_date, '2016-02-01 00:00:00', 
	'10:00', '2018-06-30 00:00:00', '10:00', NULL, NULL, '', 
	'3045', current_date, '1', now(), 'CDM-20474', 
	now(), 'CDM-20474', 1, nextval('sequence_placementrevision'::regclass), 'WKER', 
	'Placement void Request.', NULL, NULL, NULL, NULL, 
	1, now(), '515041cb-f6b0-4148-a0c6-e89823e14815', now(), '8c38cb86-3ca7-476e-8d52-f89c4d62be66', 
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
(	gen_random_uuid(), 'e861e188-580d-4a29-8831-267577a8f337', current_date, '2016-02-01 00:00:00', 
	'10:00', '2018-06-30 00:00:00', '10:00', NULL, NULL, '', 
	'3047', current_date, '1', now(), 'CDM-20474', 
	now(), 'CDM-20474', 1, nextval('sequence_placementrevision'::regclass), 'WKER', 
	'Placement voided.', NULL, NULL, NULL, NULL, 
	1, now(), '515041cb-f6b0-4148-a0c6-e89823e14815', now(), '8c38cb86-3ca7-476e-8d52-f89c4d62be66', 
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
	updatedby = 'CDM-20474', 
	updatedon = now()
where placementid = 'e861e188-580d-4a29-8831-267577a8f337' 
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
	(	gen_random_uuid(), 'PLTR', '515041cb-f6b0-4148-a0c6-e89823e14815', '8c38cb86-3ca7-476e-8d52-f89c4d62be66', 
		'7c2ad291-af40-418d-97a0-7871ceb16f90', 'CWCW', 'CWSP', 'e861e188-580d-4a29-8831-267577a8f337', 15, 0, 
		'CDM-20474', now(), 'CDM-20474', now(), true, 
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
	(	gen_random_uuid(), 'PLTR', '8c38cb86-3ca7-476e-8d52-f89c4d62be66', '515041cb-f6b0-4148-a0c6-e89823e14815', 
		'7c2ad291-af40-418d-97a0-7871ceb16f90', 'CWSP', 'CWCW', 'e861e188-580d-4a29-8831-267577a8f337', 16, 1, 
		'CDM-20474', now(), 'CDM-20474', now(), true, 
		'', NULL, 'Child Placement Void Approved', '3154214', 'Servicecase', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL
	);

-- No pending placement validation

-- Closed Placement - NO Vacancy updates required
