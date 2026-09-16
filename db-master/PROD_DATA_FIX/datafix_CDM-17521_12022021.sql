-- CDM-17521 - Missing placement
/*
-- Issue Description: 
   User request to revert void for the below placement
   
-- Case ID: 3229160
-- Client ID: 3813424 (ISAIAH GARRETT) - 0960ccdd-4b35-4dd4-babc-d894f55fa146
-- Placement ID: 1556597 - 2020-07-31 To 2020-11-09 - 5e3162f4-13fa-41c5-945e-28833e3d4058
-- Private Organization: 5000485 (Arrow Child & Family Ministries of Maryland, Inc.)
-- RCC Facility: 5000486 (Arrow Child & Family - Diagnostic Center RCC)

-- Current Program: 1141 (Diagnostic Center RCC- Arrow) - 2006-07-01 To 2021-12-31
-- New Program: 50002318 (Diagnostic Evaluation Treatment Program/DETP) - 2020-07-01 To 2021-04-30

-- Structure: 14 - Residential Group Homes

-- Category/ Module: Placements  (Case Management) 
-- Root cause: User error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to change the placement Exit date as 08/25/2021 (Voided Placement)
-- Placement Entry date changes
select alternateid, contractprogramid, service_id, 
	startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon, 
	isvoided, voidapprovaldate, voidapprovalstatustypekey, voiddate, voidreasontypekey 
from placement 
where placementid = '5e3162f4-13fa-41c5-945e-28833e3d4058'
	and activeflag  = 1 ;
	
update placement  
set contractprogramid = 50002318,
	exitreasontypekey = NULL, 
	exittypekey = 'CPL', 
	isvoided = 0, 
	voidapprovaldate = now(), 
	voidapprovalstatustypekey = NULL, 
	voiddate = NULL, 
	voidreasontypekey = NULL, 
	updatedon = now(), 
	updatedby = 'CDM-17521'
where placementid = '5e3162f4-13fa-41c5-945e-28833e3d4058'
	and activeflag = 1 ;

-- Placement Validations
select delete_sw, validation_start_dt, validation_end_dt, validation_status_cd, update_ts, update_user_id 
	from tb_placement_validation 
where placement_id = 1556597
order by validation_start_dt ;

-- Insert Nov 2020
-- Add May 2021
insert into tb_placement_validation
	(	placement_validation_id, placement_id, placement_entry_dt, placement_exit_dt, validation_status_cd, 
		comment_tx, create_user_id, update_user_id, delete_sw, validation_start_dt, 
		validation_end_dt, create_ts, update_ts, etl_userid, etl_load_date
	)
values
	(	nextval('sq_placement_validation'::regclass), 1556597, '2020-07-31', '2020-11-09', '1750', 
		NULL, 'CDM-17521', 'CDM-17521', 'N', '2020-11-01', 
		'2020-11-30', now(), now(), NULL, NULL
	);
	
-- update delete sw for Oct 2020
select delete_sw, validation_start_dt, validation_end_dt, validation_status_cd, update_ts, update_user_id 
from tb_placement_validation
where placement_validation_id = 1939054
	and placement_id = 1556597
	and delete_sw = 'Y' ;

Update tb_placement_validation 
set delete_sw = 'N',
	update_ts = now(),
	update_user_id = 'CDM-17521'
where placement_validation_id = 1939054
	and placement_id = 1556597
	and delete_sw = 'Y' ;


-- Update exit date for all
Update tb_placement_validation 
set placement_exit_dt = '2020-11-09'::date,
	validation_status_cd = '1750',
	update_ts = now(),
	update_user_id = 'CDM-17521'
where placement_id = 1556597
	and delete_sw = 'N' ;
	

-- Placement Revision
select entrydate, entrytime, exitdate, exittime, updatedby, updatedon  
	from placementrevision  
where placementid = '5e3162f4-13fa-41c5-945e-28833e3d4058'
	and placementrevisionid
		in (	'd069193a-acf8-44b2-b89d-68d3c4e4ac85', 
				'92ac954e-3a4b-4a72-8411-95575afbf950'
			) ;

delete from placementrevision
where placementid = '5e3162f4-13fa-41c5-945e-28833e3d4058'
	and placementrevisionid
		in (	'd069193a-acf8-44b2-b89d-68d3c4e4ac85', 
				'92ac954e-3a4b-4a72-8411-95575afbf950'
			) ;

-- Make active 
select entrydate, entrytime, exitdate, exittime, updatedby, updatedon, activeflag  
	from placementrevision  
where placementid = '75824682-563b-4914-8b85-904a35cbd7db'
	and placementrevisionid = '552f5fe7-b0d3-499e-a5d2-215f021c5b58' ;
	
update placementrevision  
set activeflag = 1, 
	updatedon = now(), 
	updatedby = 'CDM-17521'
where placementid = '75824682-563b-4914-8b85-904a35cbd7db'
	and placementrevisionid = '552f5fe7-b0d3-499e-a5d2-215f021c5b58' ;
	
-- update exit date
select entrydate, entrytime, exitdate, exittime, updatedby, updatedon  
	from placementrevision  
where placementid = '5e3162f4-13fa-41c5-945e-28833e3d4058'
	and exitdate is not null ;

update placementrevision  
set exitdate = '2020-11-09 15:54:11', 
	updatedon = now(), 
	updatedby = 'CDM-17521'
where placementid = '5e3162f4-13fa-41c5-945e-28833e3d4058'
	and exitdate is not null ;

-- Routing
select activeflag, routingstatustypeid, activeflag, updatedby, updatedon, * 
from routing
where objectid = '5e3162f4-13fa-41c5-945e-28833e3d4058'
	and routingid in (  '33ee67ff-edad-4dfa-91cc-45238fb40662',
						'ab6467dd-6d63-45bf-9c91-35d9cee6e8f8'
					 )
	and eventcode = 'PLTR'
order by insertedon desc ;

delete from routing
where objectid = '5e3162f4-13fa-41c5-945e-28833e3d4058'
	and routingid in (  '33ee67ff-edad-4dfa-91cc-45238fb40662',
						'ab6467dd-6d63-45bf-9c91-35d9cee6e8f8'
					 )
	and eventcode = 'PLTR' ;

/*
-- Old data 
INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status)
VALUES('92ac954e-3a4b-4a72-8411-95575afbf950'::uuid, '5e3162f4-13fa-41c5-945e-28833e3d4058'::uuid, '2020-11-04 00:00:00.000', '2020-07-31 00:00:00.000', '13:00', NULL, NULL, NULL, NULL, '', '3045', NULL, '1', '2020-11-04 12:37:55.621', 'd52c4212-1449-4a78-9643-851ab973d8e6', '2020-11-10 15:54:11.685', 'cce01557-161b-4f7e-b727-2a17a069b684', 0, 1086486, 'CP', 'Placement Correction', NULL, NULL, NULL, NULL, 1, '2020-11-04 17:37:54.247', 'd52c4212-1449-4a78-9643-851ab973d8e6', '2020-11-04 12:37:55.621', 'cce01557-161b-4f7e-b727-2a17a069b684', '2020-11-10 00:00:00.000', NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status)
VALUES('d069193a-acf8-44b2-b89d-68d3c4e4ac85'::uuid, '5e3162f4-13fa-41c5-945e-28833e3d4058'::uuid, '2020-11-04 00:00:00.000', '2020-07-31 00:00:00.000', '13:00', NULL, NULL, NULL, NULL, '', '3047', '2020-11-10 00:00:00.000', '1', '2020-11-10 15:54:11.685', 'cce01557-161b-4f7e-b727-2a17a069b684', '2020-11-10 15:54:11.685', 'cce01557-161b-4f7e-b727-2a17a069b684', 1, 1087159, 'CP', 'Placement Correction', NULL, NULL, NULL, NULL, 1, '2020-11-04 17:37:54.247', 'd52c4212-1449-4a78-9643-851ab973d8e6', '2020-11-04 12:37:55.621', 'cce01557-161b-4f7e-b727-2a17a069b684', '2020-11-10 15:54:11.685', NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('ab6467dd-6d63-45bf-9c91-35d9cee6e8f8'::uuid, 'PLTR', 'cce01557-161b-4f7e-b727-2a17a069b684', '2b437a57-1840-4d24-81b4-88f9a3e49e53', '5de8554e-67e6-4940-b5f6-1c1827dbd9c9'::uuid, 'CWSP', 'CWCW', '5e3162f4-13fa-41c5-945e-28833e3d4058', 16, 1, 'cce01557-161b-4f7e-b727-2a17a069b684', '2020-11-10 15:54:11.685', 'cce01557-161b-4f7e-b727-2a17a069b684', '2020-11-10 15:54:11.685', true, '', NULL, 'Child PlacementApproved', '3229160', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('33ee67ff-edad-4dfa-91cc-45238fb40662'::uuid, 'PLTR', 'cce01557-161b-4f7e-b727-2a17a069b684', NULL, NULL, 'CWSP', 'IVESV', '5e3162f4-13fa-41c5-945e-28833e3d4058', 16, 1, 'cce01557-161b-4f7e-b727-2a17a069b684', '2020-11-10 15:54:11.685', 'cce01557-161b-4f7e-b727-2a17a069b684', '2020-11-10 15:54:11.685', false, NULL, NULL, NULL, '3229160', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/
