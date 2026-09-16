-- CDM-13844 - Void Placement
/*
-- Issue Description: 
   Please void the Mentor Maryland Placement dated 12/18/2020-5/20/2021.
   
-- Case ID: 3176962 - tracie.cobb@maryland.gov
-- Client ID: 2710645 (MIYONNA KEMORA DIXON) - 83af539e-4027-476b-be78-4e1d48168840
-- Placement ID: 1560916 - 2020-12-18 To 2021-05-20 - 530dbf8b-4dc9-4c34-84a6-e6823864be52
-- Private Organization: 5001618 (MENTOR Maryland, Inc.)
-- CPA Office: 5001625 (MENTOR Maryland - Baltimore CPA)
-- Program ID: 1545	(Medically Complex TFC- Mentor) - 2006-07-01 To 2022-06-30

-- Category/ Module: Placements  (Case Management) 
-- Root cause: Currently CJAMS is not allowing the users to modify or void the placement dates after the exit.
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
(	gen_random_uuid(), '530dbf8b-4dc9-4c34-84a6-e6823864be52', current_date, '2020-12-18 00:00:00', '08:00', 
	'2021-05-20 00:00:00', '17:00', NULL, NULL, '', 
	'3045', current_date, '1', now(), 'CDM-13844', 
	now(), 'CDM-13844', 1, nextval('sequence_placementrevision'::regclass), 'WKER', 
	'Placement void Request.', NULL, NULL, NULL, NULL, 
	1, now(), '4e4c52d8-38a3-4999-bb99-7ccf9a5de5d8', now(), 'ba2dbc8f-3213-4b1b-9905-d643e1692db1', 
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
(	gen_random_uuid(), '530dbf8b-4dc9-4c34-84a6-e6823864be52', current_date, '2020-12-18 00:00:00', '08:00', 
	'2021-05-20 00:00:00', '17:00', NULL, NULL, '', 
	'3047', current_date, '1', now(), 'CDM-13844', 
	now(), 'CDM-13844', 1, nextval('sequence_placementrevision'::regclass), 'WKER', 
	'Placement voided.', NULL, NULL, NULL, NULL, 
	1, now(), '4e4c52d8-38a3-4999-bb99-7ccf9a5de5d8', now(), 'ba2dbc8f-3213-4b1b-9905-d643e1692db1', 
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
	updatedby = 'CDM-13844', 
	updatedon = now()
where placementid = '530dbf8b-4dc9-4c34-84a6-e6823864be52' 
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
	(	gen_random_uuid(), 'PLTR', '4e4c52d8-38a3-4999-bb99-7ccf9a5de5d8', 'ba2dbc8f-3213-4b1b-9905-d643e1692db1', 
		'e8a55980-6200-4344-810f-7bef323920e4', 'CWCW', 'CWSP', '530dbf8b-4dc9-4c34-84a6-e6823864be52', 15, 0, 
		'CDM-13844', now(), 'CDM-13844', now(), true, 
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
	(	gen_random_uuid(), 'PLTR', 'ba2dbc8f-3213-4b1b-9905-d643e1692db1', '4e4c52d8-38a3-4999-bb99-7ccf9a5de5d8', 
		'e8a55980-6200-4344-810f-7bef323920e4', 'CWSP', 'CWCW', '530dbf8b-4dc9-4c34-84a6-e6823864be52', 16, 1, 
		'CDM-13844', now(), 'CDM-13844', now(), true, 
		'', NULL, 'Child Placement Void Approved', '3176962', 'Servicecase', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL
	);

-- NO updates to placement validations - Nothing is pending

-- Closed Placement - NO Vacancy updates required

