-- CDM-14521 - Void placement
/*
-- Issue Description: 
   User request to void the placement for The National Center for Children and Families from 12/3/20 - 12/29/20.

-- Case ID: 3221787 - denise.sims@maryland.gov
-- Client ID: 1722787 (PAUL	E BOSTON) - 2005e795-80e9-4f9a-860c-63e9fee96025
-- Placement ID: 1559720 - 2020-12-03 To 2020-12-29 - 807a9eda-53a0-49f6-b635-032e0d1c83d1
-- Private Organization: 5001352 (The National Center for Children and Families, Inc.)
-- RCC Facility: 5001559 (National Center for Children and Families RCC)
-- Program: 50002291 (Group Home/HI-6301 Greentree Rd, Bethesda MD) - 2020-07-01 To 2022-06-30
   

-- Category/ Module: Placements  (Case Management) 
-- Root cause: Currently CJAMS is not allowing the users to modify or void the placement dates after the exit.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- Requestor: 91f9eb86-2360-4cfb-a2fb-d13f8dddecc7 - denise.sims@maryland.gov
-- Sipervisor: 95257d35-049f-4f35-874e-2e6a496f1d46 - tuesday.isom-cyrus@maryland.gov
-- Team: 2546af4b-b0f4-4b5f-a21f-5d27602a7c9d

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
(	gen_random_uuid(), '807a9eda-53a0-49f6-b635-032e0d1c83d1', current_date, '2020-12-03 00:00:00', '08:00', 
	'2020-12-29 00:00:00', '15:00', NULL, NULL, '', 
	'3045', current_date, '1', now(), 'CDM-14521', 
	now(), 'CDM-14521', 1, nextval('sequence_placementrevision'::regclass), 'WKER', 
	'Placement void Request.', NULL, NULL, NULL, NULL, 
	1, now(), '91f9eb86-2360-4cfb-a2fb-d13f8dddecc7', now(), '95257d35-049f-4f35-874e-2e6a496f1d46', 
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
(	gen_random_uuid(), '807a9eda-53a0-49f6-b635-032e0d1c83d1', current_date, '2020-12-03 00:00:00', '08:00', 
	'2020-12-29 00:00:00', '15:00', NULL, NULL, '', 
	'3047', current_date, '1', now(), 'CDM-14521', 
	now(), 'CDM-14521', 1, nextval('sequence_placementrevision'::regclass), 'WKER', 
	'Placement voided.', NULL, NULL, NULL, NULL, 
	1, now(), '91f9eb86-2360-4cfb-a2fb-d13f8dddecc7', now(), '95257d35-049f-4f35-874e-2e6a496f1d46', 
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
	updatedby = 'CDM-14521', 
	updatedon = now()
where placementid = '807a9eda-53a0-49f6-b635-032e0d1c83d1' 
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
	(	gen_random_uuid(), 'PLTR', '91f9eb86-2360-4cfb-a2fb-d13f8dddecc7', '95257d35-049f-4f35-874e-2e6a496f1d46', 
		'2546af4b-b0f4-4b5f-a21f-5d27602a7c9d', 'CWCW', 'CWSP', '807a9eda-53a0-49f6-b635-032e0d1c83d1', 15, 0, 
		'CDM-14521', now(), 'CDM-14521', now(), true, 
		'', NULL, 'Placement Void Submitted for review', '3221787', 'Servicecase', 
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
	(	gen_random_uuid(), 'PLTR', '95257d35-049f-4f35-874e-2e6a496f1d46', '91f9eb86-2360-4cfb-a2fb-d13f8dddecc7', 
		'2546af4b-b0f4-4b5f-a21f-5d27602a7c9d', 'CWSP', 'CWCW', '807a9eda-53a0-49f6-b635-032e0d1c83d1', 16, 1, 
		'CDM-14521', now(), 'CDM-14521', now(), true, 
		'', NULL, 'Child Placement Void Approved', '3221787', 'Servicecase', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL
	);

-- NO updates to placement validations - Nothing is pending

-- Closed Placement - NO Vacancy updates required

