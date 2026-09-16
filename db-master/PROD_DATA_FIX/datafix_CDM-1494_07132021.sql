-- CDM-14947 - Need to Void for Payments to Generate
/*
-- Issue Description: 
   User request to void the below Placement:
   
-- Case ID: 3148360 - christin.dowtin@maryland.gov
-- Client ID: 1923347 (TONY HUBBARD) - 2710f83e-5f70-4ea1-a9c5-e01717f13414
-- Placement ID: 1558987 - 10/12/2020 To 06/02/2021 - d8a8f130-4104-4467-a7bd-0737b5378d5c
-- Private Organization: 5018960 (UHS of Savannah - d/b/a Coastal Harbor Treatment Center)
-- Program ID: 50002270	(Tony Hubbard)	- 10/12/2020 To 12/31/2021
-- RCC Facility: 5088786 (Coastal Harbor Treatment Center) 	
-- Old Placement Structure (ID 76): Residential Treatment Centers (RTC)
-- New Placement Structure (ID 14): Residential Group Homes

-- Category/ Module: Placements  (Case Management) 
-- Root cause: Currently CJAMS is not allowing the users to modify or void the placement dates after the exit.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- placementrevision - Void
-- REQUESTED BY:Christin Dowtin - d0fcaea1-0989-456e-96cc-65e55199d92a
-- APPROVED by :Ambrose Iwugo - 1157696d-d0e3-45d3-8642-be5c3b2ece0c
-- Team ID 1214f3db-4042-4e98-852e-b6419d97c048
 
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
(	gen_random_uuid(), 'd8a8f130-4104-4467-a7bd-0737b5378d5c', current_date, '2020-10-12 00:00:00', '18:00', 
	'2021-06-02 00:00:00', '11:00', NULL, NULL, '', 
	'3045', current_date, '1', now(), 'CDM-14947', 
	now(), 'CDM-14947', 1, nextval('sequence_placementrevision'::regclass), 'WKER', 
	'Placement void Request.', NULL, NULL, NULL, NULL, 
	1, now(), 'd0fcaea1-0989-456e-96cc-65e55199d92a', now(), '1157696d-d0e3-45d3-8642-be5c3b2ece0c', 
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
(	gen_random_uuid(), 'd8a8f130-4104-4467-a7bd-0737b5378d5c', current_date, '2020-10-12 00:00:00', '18:00', 
	'2021-06-02 00:00:00', '11:00', NULL, NULL, '', 
	'3047', current_date, '1', now(), 'CDM-14947', 
	now(), 'CDM-14947', 1, nextval('sequence_placementrevision'::regclass), 'WKER', 
	'Placement voided.', NULL, NULL, NULL, NULL, 
	1, now(), 'd0fcaea1-0989-456e-96cc-65e55199d92a', now(), '1157696d-d0e3-45d3-8642-be5c3b2ece0c', 
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
	updatedby = 'CDM-14947', 
	updatedon = now()
where placementid = 'd8a8f130-4104-4467-a7bd-0737b5378d5c' 
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
	(	gen_random_uuid(), 'PLTR', 'd0fcaea1-0989-456e-96cc-65e55199d92a', '1157696d-d0e3-45d3-8642-be5c3b2ece0c', 
		'e8a55980-6200-4344-810f-7bef323920e4', 'CWCW', 'CWSP', 'd8a8f130-4104-4467-a7bd-0737b5378d5c', 15, 0, 
		'CDM-14947', now(), 'CDM-14947', now(), true, 
		'', NULL, 'Placement Void Submitted for review', '3148360', 'Servicecase', 
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
	(	gen_random_uuid(), 'PLTR', '1157696d-d0e3-45d3-8642-be5c3b2ece0c', 'd0fcaea1-0989-456e-96cc-65e55199d92a', 
		'e8a55980-6200-4344-810f-7bef323920e4', 'CWSP', 'CWCW', 'd8a8f130-4104-4467-a7bd-0737b5378d5c', 16, 1, 
		'CDM-14947', now(), 'CDM-14947', now(), true, 
		'', NULL, 'Child Placement Void Approved', '3148360', 'Servicecase', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL
	);

-- NO updates to placement validations - N/A Placement Structure  was 76: RTC

-- Closed Placement - NO Vacancy updates required
