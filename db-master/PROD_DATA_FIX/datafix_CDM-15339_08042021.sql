-- CDM-15339 - Payment
/*
-- Issue Description: 
   User Request to Void 2 placements and update Exit date of one.
   
-- Case ID: 3154214
-- Client ID: 2064384 (JOHN ROWELL)
-- Private Organization: 5000647 (Board of Child Care of the United Methodist Church, Incorporated)	
-- RCC Facility: 5000650 (Board of Child Care Main Campus Gaither Rd)

-- To change the placement Exit date as 11/23/2020 (old value 12/31/2020)    
-- Placement ID: 339640 - 2020-03-04 To 2020-12-31 - a6c8ae78-a3d5-4616-a32e-b07abf824a8a
-- Program: 1590 (Main Campus 3300 Gaither Rd - High Intensity) - 2006-07-01 To 2021-03-31

-- Void
-- Placement ID: 1560748 - 2021-02-01 To 2021-04-23 - 86eff189-db8f-476c-b275-1e0922c58c80
-- Program: 50002392 (High Intensity-Gaither Rd GH) - 2021-02-01 To 2022-06-30

-- Void
-- Placement ID: 1560746 - 2021-01-01 To 2021-01-31 - fece2881-fffd-4927-93bc-551c3fe0b2e0
-- Program: 1590 (Main Campus 3300 Gaither Rd - High Intensity) - 2006-07-01 To 2021-03-31

-- Category/ Module: Placements  (Case Management) 
-- Root cause: Currently CJAMS is not allowing the users to modify the placement dates after the exit.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- Placement Entry date changes
select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon 
from placement 
where placementid = 'a6c8ae78-a3d5-4616-a32e-b07abf824a8a'
	and activeflag  = 1 ;

update placement  
set enddatetime = '2020-11-23 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-15339'
where placementid = 'a6c8ae78-a3d5-4616-a32e-b07abf824a8a'
	and activeflag = 1 ;

-- Placement Revision Entry date changes
select entrydate, entrytime, exitdate, exittime, updatedby, updatedon  
	from placementrevision  
where placementid = 'a6c8ae78-a3d5-4616-a32e-b07abf824a8a' 	
	and exitdate is not null ;

update placementrevision  
set exitdate = '2020-11-23 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-15339'
where placementid = 'a6c8ae78-a3d5-4616-a32e-b07abf824a8a'
	and exitdate is not null ;

-- Placement Validations 
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from tb_placement_validation 
where placement_id = 339640 
	and delete_sw  = 'N';

Update tb_placement_validation 
set placement_exit_dt = '2020-11-23'::date,
	update_ts = now(),
	update_user_id = 'CDM-15339'
where placement_id = 339640
	and delete_sw = 'N' ;

-- Delete
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from tb_placement_validation 
where placement_id = 339640 
	and placement_validation_id = 1944717
	and delete_sw  = 'N';

Update tb_placement_validation 
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-15339'
where placement_id = 339640 
	and placement_validation_id = 1944717
	and delete_sw  = 'N';

-- Void
-- Placement ID: 1560748 - 2021-02-01 To 2021-04-23 - 86eff189-db8f-476c-b275-1e0922c58c80
-- Program: 50002392 (High Intensity-Gaither Rd GH) - 2021-02-01 To 2022-06-30


-- Case worker: Jennifer Evans ed2f13d8-0b71-41cd-8ed9-8f1db47b571f
-- Supervisor Name: Daniel A. Johnson 251ca32d-4b6f-460e-ab34-0d740c55b6dd
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
(	gen_random_uuid(), '86eff189-db8f-476c-b275-1e0922c58c80', current_date, '2021-02-01 00:00:00', '00:00', 
	'2021-04-23 00:00:00', '23:59', NULL, NULL, '', 
	'3045', current_date, '1', now(), 'CDM-15339', 
	now(), 'CDM-15339', 1, nextval('sequence_placementrevision'::regclass), 'WKER', 
	'Placement void Request.', NULL, NULL, NULL, NULL, 
	1, now(), 'ed2f13d8-0b71-41cd-8ed9-8f1db47b571f', now(), '251ca32d-4b6f-460e-ab34-0d740c55b6dd', 
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
(	gen_random_uuid(), '86eff189-db8f-476c-b275-1e0922c58c80', current_date, '2021-02-01 00:00:00', '00:00', 
	'2021-04-23 00:00:00', '23:59', NULL, NULL, '', 
	'3047', current_date, '1', now(), 'CDM-15339', 
	now(), 'CDM-15339', 1, nextval('sequence_placementrevision'::regclass), 'WKER', 
	'Placement voided.', NULL, NULL, NULL, NULL, 
	1, now(), 'ed2f13d8-0b71-41cd-8ed9-8f1db47b571f', now(), '251ca32d-4b6f-460e-ab34-0d740c55b6dd', 
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
	updatedby = 'CDM-15339', 
	updatedon = now()
where placementid = '86eff189-db8f-476c-b275-1e0922c58c80' 
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
	(	gen_random_uuid(), 'PLTR', 'ed2f13d8-0b71-41cd-8ed9-8f1db47b571f', '251ca32d-4b6f-460e-ab34-0d740c55b6dd', 
		'98e48338-6869-410f-a272-ff58cfc80a00', 'CWCW', 'CWSP', '86eff189-db8f-476c-b275-1e0922c58c80', 15, 0, 
		'CDM-15339', now(), 'CDM-15339', now(), true, 
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
	(	gen_random_uuid(), 'PLTR', '251ca32d-4b6f-460e-ab34-0d740c55b6dd', 'ed2f13d8-0b71-41cd-8ed9-8f1db47b571f', 
		'98e48338-6869-410f-a272-ff58cfc80a00', 'CWSP', 'CWCW', '86eff189-db8f-476c-b275-1e0922c58c80', 16, 1, 
		'CDM-15339', now(), 'CDM-15339', now(), true, 
		'', NULL, 'Child Placement Void Approved', '3154214', 'Servicecase', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL
	);

-- No pending placement validation

-- Closed Placement - NO Vacancy updates required

-- Void
-- Placement ID: 1560746 - 2021-01-01 To 2021-01-31 - fece2881-fffd-4927-93bc-551c3fe0b2e0
-- Program: 1590 (Main Campus 3300 Gaither Rd - High Intensity) - 2006-07-01 To 2021-03-31


-- Case worker: Jennifer Evans ed2f13d8-0b71-41cd-8ed9-8f1db47b571f
-- Supervisor Name: Daniel A. Johnson 251ca32d-4b6f-460e-ab34-0d740c55b6dd
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
(	gen_random_uuid(), 'fece2881-fffd-4927-93bc-551c3fe0b2e0', current_date, '2021-01-01 00:00:00', '00:00', 
	'2021-01-31 00:00:00', '23:59', NULL, NULL, '', 
	'3045', current_date, '1', now(), 'CDM-15339', 
	now(), 'CDM-15339', 1, nextval('sequence_placementrevision'::regclass), 'WKER', 
	'Placement void Request.', NULL, NULL, NULL, NULL, 
	1, now(), 'ed2f13d8-0b71-41cd-8ed9-8f1db47b571f', now(), '251ca32d-4b6f-460e-ab34-0d740c55b6dd', 
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
(	gen_random_uuid(), 'fece2881-fffd-4927-93bc-551c3fe0b2e0', current_date, '2021-01-01 00:00:00', '00:00', 
	'2021-01-31 00:00:00', '23:59', NULL, NULL, '', 
	'3047', current_date, '1', now(), 'CDM-15339', 
	now(), 'CDM-15339', 1, nextval('sequence_placementrevision'::regclass), 'WKER', 
	'Placement voided.', NULL, NULL, NULL, NULL, 
	1, now(), 'ed2f13d8-0b71-41cd-8ed9-8f1db47b571f', now(), '251ca32d-4b6f-460e-ab34-0d740c55b6dd', 
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
	updatedby = 'CDM-15339', 
	updatedon = now()
where placementid = 'fece2881-fffd-4927-93bc-551c3fe0b2e0' 
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
	(	gen_random_uuid(), 'PLTR', 'ed2f13d8-0b71-41cd-8ed9-8f1db47b571f', '251ca32d-4b6f-460e-ab34-0d740c55b6dd', 
		'98e48338-6869-410f-a272-ff58cfc80a00', 'CWCW', 'CWSP', 'fece2881-fffd-4927-93bc-551c3fe0b2e0', 15, 0, 
		'CDM-15339', now(), 'CDM-15339', now(), true, 
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
	(	gen_random_uuid(), 'PLTR', '251ca32d-4b6f-460e-ab34-0d740c55b6dd', 'ed2f13d8-0b71-41cd-8ed9-8f1db47b571f', 
		'98e48338-6869-410f-a272-ff58cfc80a00', 'CWSP', 'CWCW', 'fece2881-fffd-4927-93bc-551c3fe0b2e0', 16, 1, 
		'CDM-15339', now(), 'CDM-15339', now(), true, 
		'', NULL, 'Child Placement Void Approved', '3154214', 'Servicecase', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL
	);

-- No pending placement validation

-- Closed Placement - NO Vacancy updates required

