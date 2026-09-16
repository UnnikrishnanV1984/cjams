-- CDM-14441 - Void Placement
/*
-- Issue Description: 
   Please void the Mentor Maryland Placement dated 06/18/2020-06/18/2021.
   
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
(	gen_random_uuid(), '4c4bf3b2-ee54-4d6d-bffa-ca284a32e740', current_date, '2020-06-18 00:00:00', '13:30', 
	'2020-06-18 00:00:00', '13:30', NULL, NULL, '', 
	'3045', current_date, '1', now(), 'CDM-14441', 
	now(), 'CDM-14441', 1, nextval('sequence_placementrevision'::regclass), 'WKER', 
	'Placement void Request.', NULL, NULL, NULL, NULL, 
	1, now(), 'b1ef9989-b28a-4cce-a9c2-62d7acbde11c', now(), 'a2d33374-e9f5-40da-847f-cd762ba84387', 
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
(	gen_random_uuid(), '4c4bf3b2-ee54-4d6d-bffa-ca284a32e740', current_date, '2020-06-18 00:00:00', '13:30', 
	'2020-06-18 00:00:00', '13:30', NULL, NULL, '', 
	'3047', current_date, '1', now(), 'CDM-14441', 
	now(), 'CDM-14441', 1, nextval('sequence_placementrevision'::regclass), 'WKER', 
	'Placement voided.', NULL, NULL, NULL, NULL, 
	1, now(), 'b1ef9989-b28a-4cce-a9c2-62d7acbde11c', now(), 'a2d33374-e9f5-40da-847f-cd762ba84387', 
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
	updatedby = 'CDM-14441', 
	updatedon = now()
where placementid = '4c4bf3b2-ee54-4d6d-bffa-ca284a32e740' 
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
	(	gen_random_uuid(), 'PLTR', 'b1ef9989-b28a-4cce-a9c2-62d7acbde11c', 'a2d33374-e9f5-40da-847f-cd762ba84387', 
		'e8a55980-6200-4344-810f-7bef323920e4', 'CWCW', 'CWSP', '4c4bf3b2-ee54-4d6d-bffa-ca284a32e740', 15, 0, 
		'CDM-14441', now(), 'CDM-14441', now(), true, 
		'', NULL, 'Placement Void Submitted for review', '3261386', 'Servicecase', 
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
	(	gen_random_uuid(), 'PLTR', 'a2d33374-e9f5-40da-847f-cd762ba84387', 'b1ef9989-b28a-4cce-a9c2-62d7acbde11c', 
		'e8a55980-6200-4344-810f-7bef323920e4', 'CWSP', 'CWCW', '4c4bf3b2-ee54-4d6d-bffa-ca284a32e740', 16, 1, 
		'CDM-14441', now(), 'CDM-14441', now(), true, 
		'', NULL, 'Child Placement Void Approved', '3261386', 'Servicecase', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL
	);

-- NO updates to placement validations - Nothing is pending

-- Closed Placement - NO Vacancy updates required
