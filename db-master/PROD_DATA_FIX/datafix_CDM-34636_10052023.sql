-- CDM-34636 - Exited Child from Care incorrectly
/*
-- Issue Description: 
   User request to re-open Child Removal / OOH to create new pre-adoptive placement

-- Case ID: 3306252
-- Client ID: 4465418 (KAYDENCE	N BEST) - 26e2e685-1f34-4b32-b68c-541dd8c5a1c0
-- Placement ID: 339303 - 2020-02-04 To 2023-05-05 - 91cd2eba-e151-4a30-bee1-bd47f87cfa6e
-- Provider ID: 5092945	(Peter William Ulrickson) 
-- Removal ID: 198960 -	2020-02-04 To 2023-09-05 - 6e9d0eb1-879d-4b10-b220-6d0fa94d2c31
-- OOH	2020-02-04 To 2023-09-05 - d5f4ef6e-b27f-4413-8286-21ed893c390d

-- Category/ Module: Removal (Case Management) 
-- Root cause: User Error
-- Fix Provided: Datafix has been promoted to re-open the Child Removal / OOH.   
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to re-open the Child Removal, OOH & IV-E and update Placement exit Type (CDM-34636)
-- Update Removal
select removalid, removaldate, exitdate, returntransts, removalexitreason, updatedby, updatedon, activeflag 
	from cjams.intakeservreqchildremoval
where removalid = 198960
	and activeflag = 1;
	
update cjams.intakeservreqchildremoval
set exitdate = Null,
	returndate = Null,
	returntime = Null,
	returntransts = Null,
	removalexitreason = NULL,
	updatedby = 'CDM-34636',
	updatedon = now()
where removalid = 198960
	and activeflag = 1;
	
-- Update OOH
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = 'd5f4ef6e-b27f-4413-8286-21ed893c390d'
	and activeflag = 1;

update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-34636',
	updatedon = now()
where personprogramid = 'd5f4ef6e-b27f-4413-8286-21ed893c390d'
	and activeflag = 1;
	
-- Update Eligibility
select removal_id, client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where removal_id = 198960
	and delete_sw = 'N';

update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CDM-34636',
	update_ts = now()
where removal_id = 198960
	and delete_sw = 'N';

-- Update Placement
select alternateid, 
	exitreasontypekey, -- ADNRE
	exittypekey, -- PLCC
	exittypetypekey, -- NULL
	leastrestrictiveplacement,  -- Child has been adopted by her foster parents. 
	remarks, -- Initial exit date was wrong.
	updatedby, -- 'e27575b1-783d-4b26-a4ad-0985f8ad4d6e'
	updatedon -- '2023-10-03 11:48:34'
from placement 
where alternateid = 339303
	and activeflag = 1 ;
	
update placement
set exitreasontypekey = null,
	exittypekey = 'CIPS', -- Change in Placement Structure
	updatedby = 'CDM-34636',
	updatedon = now()
where alternateid = 339303
	and activeflag = 1 ;	

select approvalstatustypkey, exittypekey, exitreasontypkey, exittypetypkey, updatedby, updatedon, *
	from placementrevision 
where placementid = '91cd2eba-e151-4a30-bee1-bd47f87cfa6e'
	and placementrevisionid 
		not in (
			'44cf0a8e-832c-4d9b-b8ab-b25cf233b0cd',
			'a4d9ce3e-d129-4b58-8757-6468008a5682',
			'f139fb2b-d61b-44a8-8bc4-4c1a414c5576'
			) 
	and exittypekey is not null
	and btrim(exittypekey) <> ''
order by insertedon desc ;

update placementrevision
set exittypekey = 'CIPS', -- Change in Placement Structure
	updatedby = 'CDM-34636',
	updatedon = now()
where placementid = '91cd2eba-e151-4a30-bee1-bd47f87cfa6e'
	and placementrevisionid 
		not in (
			'44cf0a8e-832c-4d9b-b8ab-b25cf233b0cd',
			'a4d9ce3e-d129-4b58-8757-6468008a5682',
			'f139fb2b-d61b-44a8-8bc4-4c1a414c5576'
			) 
	and exittypekey is not null
	and btrim(exittypekey) <> '' ;

	
-- Delete all incorrcet pending review requests
select approvalstatustypkey, exittypekey, exitreasontypkey, exittypetypkey, updatedby, updatedon
	from placementrevision 
where placementid = '91cd2eba-e151-4a30-bee1-bd47f87cfa6e'
	and placementrevisionid 
		in (
			'44cf0a8e-832c-4d9b-b8ab-b25cf233b0cd',
			'a4d9ce3e-d129-4b58-8757-6468008a5682',
			'f139fb2b-d61b-44a8-8bc4-4c1a414c5576'
			) ;

Delete from placementrevision 
where placementid = '91cd2eba-e151-4a30-bee1-bd47f87cfa6e'
	and placementrevisionid 
		in (
			'44cf0a8e-832c-4d9b-b8ab-b25cf233b0cd',
			'a4d9ce3e-d129-4b58-8757-6468008a5682',
			'f139fb2b-d61b-44a8-8bc4-4c1a414c5576'
			) ;

-- Delete all incorrcet routing
select routingid, eventcode, routingstatustypeid, remarks, activeflag, updatedby, updatedon, *
	from routing
where objectid = '91cd2eba-e151-4a30-bee1-bd47f87cfa6e'
	and routingid in  (	'8a6f9b78-8b32-4b0b-8a53-fbeae1e1b6fc',
						'84005037-61a7-469e-8527-96ebc804a2b3',
						'850a4e0a-8409-44f8-8b68-4a1b6e3d5bfb'
						)
order by insertedon desc ;

Delete from routing 
where objectid = '91cd2eba-e151-4a30-bee1-bd47f87cfa6e'
	and routingid in  (	'8a6f9b78-8b32-4b0b-8a53-fbeae1e1b6fc',
						'84005037-61a7-469e-8527-96ebc804a2b3',
						'850a4e0a-8409-44f8-8b68-4a1b6e3d5bfb'
						) ;

-- To revert if needed 
/*
INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status, primaryrelationship, leastrestrictiveplacement, transferagency, otherpublicagency)
VALUES('f139fb2b-d61b-44a8-8bc4-4c1a414c5576', '91cd2eba-e151-4a30-bee1-bd47f87cfa6e', '2023-10-03 00:00:00.000', '2020-02-04 00:00:00.000', '15:00', '2022-11-01 00:00:00.000', '09:00', NULL, NULL, '', '3045', '2023-10-03 00:00:00.000', '1', '2023-10-03 11:51:57.776', 'd4b29e5d-f4b0-4f77-977b-3c132ab51eaa', '2023-10-03 11:51:57.776', 'd4b29e5d-f4b0-4f77-977b-3c132ab51eaa', 0, 1606239, NULL, NULL, NULL, NULL, 'CIPS', 'Initial exit date was wrong.', 0, NULL, 'd4b29e5d-f4b0-4f77-977b-3c132ab51eaa', '2023-10-03 11:51:57.776', NULL, NULL, NULL, NULL, NULL, '', 'Review', NULL, 'Child has been adopted by her foster parents.', NULL, NULL);

INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status, primaryrelationship, leastrestrictiveplacement, transferagency, otherpublicagency)
VALUES('a4d9ce3e-d129-4b58-8757-6468008a5682', '91cd2eba-e151-4a30-bee1-bd47f87cfa6e', '2023-10-03 00:00:00.000', '2020-02-04 00:00:00.000', '15:00', '2022-11-01 00:00:00.000', '09:00', NULL, NULL, '', '3045', '2023-10-03 00:00:00.000', '1', '2023-10-03 11:54:13.582', 'd4b29e5d-f4b0-4f77-977b-3c132ab51eaa', '2023-10-03 11:54:13.582', 'd4b29e5d-f4b0-4f77-977b-3c132ab51eaa', 0, 1606272, NULL, NULL, NULL, NULL, 'CIPS', 'Initial exit date was wrong.', 0, NULL, 'd4b29e5d-f4b0-4f77-977b-3c132ab51eaa', '2023-10-03 11:54:13.582', NULL, NULL, NULL, NULL, NULL, 'Child to be placed in a pre-adoptive home.', 'Review', NULL, 'Child has been adopted by her foster parents.', NULL, NULL);

INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status, primaryrelationship, leastrestrictiveplacement, transferagency, otherpublicagency)
VALUES('44cf0a8e-832c-4d9b-b8ab-b25cf233b0cd', '91cd2eba-e151-4a30-bee1-bd47f87cfa6e', '2023-10-03 00:00:00.000', '2020-02-04 00:00:00.000', '15:00', '2022-11-01 00:00:00.000', '09:00', NULL, NULL, '', '3045', NULL, '1', '2023-10-03 11:55:21.986', 'e27575b1-783d-4b26-a4ad-0985f8ad4d6e', '2023-10-03 11:55:21.986', 'e27575b1-783d-4b26-a4ad-0985f8ad4d6e', 1, 1606273, NULL, NULL, NULL, NULL, 'CIPS', 'Initial exit date was wrong.', 0, NULL, 'e27575b1-783d-4b26-a4ad-0985f8ad4d6e', '2023-10-03 11:55:21.986', NULL, NULL, NULL, NULL, NULL, 'Child to be placed in a pre-adoptive home.', 'Review', NULL, 'Child has been adopted by her foster parents.', NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('8a6f9b78-8b32-4b0b-8a53-fbeae1e1b6fc', 'PLTR', 'e27575b1-783d-4b26-a4ad-0985f8ad4d6e', 'e0362519-4fe0-424a-9360-7620e9031021', '6123c7a6-29a7-4252-ac6b-2018bf5a0bf8', 'CWSP', 'CWSP', '91cd2eba-e151-4a30-bee1-bd47f87cfa6e', 15, 1, 'e27575b1-783d-4b26-a4ad-0985f8ad4d6e', '2023-10-03 11:55:21.501', 'e27575b1-783d-4b26-a4ad-0985f8ad4d6e', '2023-10-03 11:55:21.501', true, '', NULL, 'Placement Exit Submitted for review', '3306252', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('84005037-61a7-469e-8527-96ebc804a2b3', 'PLTR', 'd4b29e5d-f4b0-4f77-977b-3c132ab51eaa', 'e27575b1-783d-4b26-a4ad-0985f8ad4d6e', '6123c7a6-29a7-4252-ac6b-2018bf5a0bf8', 'CWCW', 'CWSP', '91cd2eba-e151-4a30-bee1-bd47f87cfa6e', 15, 0, 'd4b29e5d-f4b0-4f77-977b-3c132ab51eaa', '2023-10-03 11:54:13.076', 'e27575b1-783d-4b26-a4ad-0985f8ad4d6e', '2023-10-03 11:55:21.501', true, '', NULL, 'Placement Exit Submitted for review', '3306252', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('850a4e0a-8409-44f8-8b68-4a1b6e3d5bfb', 'PLTR', 'd4b29e5d-f4b0-4f77-977b-3c132ab51eaa', 'e27575b1-783d-4b26-a4ad-0985f8ad4d6e', '6123c7a6-29a7-4252-ac6b-2018bf5a0bf8', 'CWCW', 'CWSP', '91cd2eba-e151-4a30-bee1-bd47f87cfa6e', 15, 0, 'd4b29e5d-f4b0-4f77-977b-3c132ab51eaa', '2023-10-03 11:51:57.265', 'd4b29e5d-f4b0-4f77-977b-3c132ab51eaa', '2023-10-03 11:54:13.076', true, '', NULL, 'Placement Exit Submitted for review', '3306252', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/
