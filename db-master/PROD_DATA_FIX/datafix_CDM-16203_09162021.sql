-- CDM-16203 - Removal dates
/*
-- Issue Description: 
   User Request to Void the Removal, OOH and Placement of duplicate Client on teh Service Case

-- Case ID: 3151160
-- Client ID: 200139056	(Deniesha Lindsay) - d125386e-8750-4966-96fc-9613ee86ee5b
-- Placement ID: 1558005 - 2020-07-27 To 2020-07-28 - d3321c60-ecff-49d8-bee0-b9776e3a46db
-- Provider ID: 5071644 (Maria Kovacs)

-- Removal
-- 250673 - 2020-07-27 To 2020-07-28 - bc3389d0-6a8c-4b62-a87b-6e539dced94b

-- Category/ Module: Placements  (Case Management) 
-- Root cause: Currently CJAMS is not allowing the users to modify the placement dates after the exit.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- Case worker: TCobb - 4e4c52d8-38a3-4999-bb99-7ccf9a5de5d8
-- Supervisor Name: Erika Robinson - 3b624981-6029-4eba-ba75-e6b3f5377333
-- Team ID: e8a55980-6200-4344-810f-7bef323920e4

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
(	gen_random_uuid(), 'd3321c60-ecff-49d8-bee0-b9776e3a46db', current_date, '2020-07-27 00:00:00', '20:00', 
	'2020-07-28 00:00:00', '17:00', NULL, NULL, '', 
	'3045', current_date, '1', now(), 'CDM-16203', 
	now(), 'CDM-16203', 1, nextval('sequence_placementrevision'::regclass), 'WKER', 
	'Placement void Request.', NULL, NULL, NULL, NULL, 
	1, now(), '4e4c52d8-38a3-4999-bb99-7ccf9a5de5d8', now(), '3b624981-6029-4eba-ba75-e6b3f5377333', 
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
(	gen_random_uuid(), 'd3321c60-ecff-49d8-bee0-b9776e3a46db', current_date, '2020-07-27 00:00:00', '20:00', 
	'2020-07-28 00:00:00', '17:00', NULL, NULL, '', 
	'3047', current_date, '1', now(), 'CDM-16203', 
	now(), 'CDM-16203', 1, nextval('sequence_placementrevision'::regclass), 'WKER', 
	'Placement voided.', NULL, NULL, NULL, NULL, 
	1, now(), '4e4c52d8-38a3-4999-bb99-7ccf9a5de5d8', now(), '3b624981-6029-4eba-ba75-e6b3f5377333', 
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
	updatedby = 'CDM-16203', 
	updatedon = now()
where placementid = 'd3321c60-ecff-49d8-bee0-b9776e3a46db' 
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
	(	gen_random_uuid(), 'PLTR', '4e4c52d8-38a3-4999-bb99-7ccf9a5de5d8', '3b624981-6029-4eba-ba75-e6b3f5377333', 
		'e8a55980-6200-4344-810f-7bef323920e4', 'CWCW', 'CWSP', 'd3321c60-ecff-49d8-bee0-b9776e3a46db', 15, 0, 
		'CDM-16203', now(), 'CDM-16203', now(), true, 
		'', NULL, 'Placement Void Submitted for review', '3151160', 'Servicecase', 
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
	(	gen_random_uuid(), 'PLTR', '3b624981-6029-4eba-ba75-e6b3f5377333', '4e4c52d8-38a3-4999-bb99-7ccf9a5de5d8', 
		'e8a55980-6200-4344-810f-7bef323920e4', 'CWSP', 'CWCW', 'd3321c60-ecff-49d8-bee0-b9776e3a46db', 16, 1, 
		'CDM-16203', now(), 'CDM-16203', now(), true, 
		'', NULL, 'Child Placement Void Approved', '3151160', 'Servicecase', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL
	);

-- No pending placement validation

-- Closed Placement - NO Vacancy updates required

-- Update Removal
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid = 250673
	and rm.activeflag = 1 ;

update intakeservreqchildremoval rm 
set rm.exitdate = rm.removaldate,
	rm.updatedby = 'CDM-16203',
	rm.updatedon = now() 
where rm.removalid = 250673
	and rm.activeflag = 1 ;

-- Update OOH
select startdate, enddate, programkey, updatedby, updatedon 
	from personprogramarea  
where personprogramid = 'dd584d9f-7fcc-4362-907e-ceb1ae265f73'
	and activeflag = 1 ;

update personprogramarea
set enddate = startdate,
	updatedby = 'CDM-16203',
	updatedon = now()
where personprogramid = 'dd584d9f-7fcc-4362-907e-ceb1ae265f73'
	and activeflag = 1 ;

-- Delete IV-E
select removal_id, start_dt, end_dt, update_ts, update_user_id, delete_sw  
   from tb_client_eligibility
where removal_id = 250673
   and delete_sw = 'N' ;
   
update tb_client_eligibility
set end_dt = start_dt,
	update_ts = now(),
	update_user_id = 'CDM-16203',
	delete_sw = 'Y'
where removal_id = 250673
   and delete_sw = 'N' ;

