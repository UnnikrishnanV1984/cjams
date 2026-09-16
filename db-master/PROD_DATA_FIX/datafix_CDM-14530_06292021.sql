-- CDM-14530 - Error in placement
/*
-- Issue Description: 
   The placement for Anari Peyton was entered into CJAMS incorrectly. 
   The placement with Debra Brown for the dates of 6/18/2021 through 6/21/2021 needs to be deleted from CJAMS. 
   
-- Case ID: 2020033004433 - omar.wilkins@maryland.gov
-- Client ID: 4083290 (ANARI N PEYTON) - df6f1b23-cb83-4c9d-b6c2-dabd373172b5
-- Placement ID: 1563998 - 2021-06-18 To 2021-06-21 - dcec12ee-79b9-4cb0-b9d9-c3825d6cda9d
-- Provider ID: 5090620	(Debra Brown)
-- Wrk: Omar Wilkins - 162165d9-5c4f-47dd-a539-821e4a21f240	
-- Sup: Shawna Cunningham - 28f2759e-713f-45eb-978e-b2b5308ed483 (scunningham@maryland.gov)

-- Category/ Module: Placements  (Case Management) 
-- Root cause: Currently CJAMS is not allowing the users to modify the placement dates after the exit.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- placementrevision - Void 
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
(	gen_random_uuid(), 'dcec12ee-79b9-4cb0-b9d9-c3825d6cda9d', current_date, '2021-06-18 00:00:00', '15:30', 
	'2021-06-21 00:00:00', '18:00', NULL, NULL, '', 
	'3045', current_date, '1', now(), 'CDM-14530', 
	now(), 'CDM-14530', 1, nextval('sequence_placementrevision'::regclass), 'WKER', 
	'Placement void Request.', NULL, NULL, NULL, NULL, 
	1, NULL, '162165d9-5c4f-47dd-a539-821e4a21f240', now(), '28f2759e-713f-45eb-978e-b2b5308ed483', 
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
(	gen_random_uuid(), 'dcec12ee-79b9-4cb0-b9d9-c3825d6cda9d', current_date, '2021-06-18 00:00:00', '15:30', 
	'2021-06-21 00:00:00', '18:00', NULL, NULL, '', 
	'3047', current_date, '1', now(), 'CDM-14530', 
	now(), 'CDM-14530', 1, nextval('sequence_placementrevision'::regclass), 'WKER', 
	'Placement voided.', NULL, NULL, NULL, NULL, 
	1, NULL, '162165d9-5c4f-47dd-a539-821e4a21f240', now(), '28f2759e-713f-45eb-978e-b2b5308ed483', 
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
	updatedby = 'CDM-14530', 
	updatedon = now()
where placementid = 'dcec12ee-79b9-4cb0-b9d9-c3825d6cda9d' 
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
	(	gen_random_uuid(), 'PLTR', '162165d9-5c4f-47dd-a539-821e4a21f240', '28f2759e-713f-45eb-978e-b2b5308ed483', 
		'03cdc5ef-02af-4d9b-a313-452fa7686ef8', 'CWCW', 'CWSP', 'dcec12ee-79b9-4cb0-b9d9-c3825d6cda9d', 15, 0, 
		'CDM-14530', now(), 'CDM-14530', now(), true, 
		'', NULL, 'Placement Void Submitted for review', '2020033004433', 'Servicecase', 
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
	(	gen_random_uuid(), 'PLTR', '28f2759e-713f-45eb-978e-b2b5308ed483', '162165d9-5c4f-47dd-a539-821e4a21f240', 
		'03cdc5ef-02af-4d9b-a313-452fa7686ef8', 'CWSP', 'CWCW', 'dcec12ee-79b9-4cb0-b9d9-c3825d6cda9d', 16, 1, 
		'CDM-14530', now(), 'CDM-14530', now(), true, 
		'', NULL, 'Child Placement Void Approved', '2020033004433', 'Servicecase', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL
	);

-- Kinship Structure - NO updates to placement validations

-- Closed Placement - NO Vacancy updates required
