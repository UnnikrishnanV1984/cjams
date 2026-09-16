-- CDM-21405 - Overpayment Issues
/*
-- Issue Description: 
   User request to change the placement Entry Date as 05/23/2019 for both children
   
-- Case ID: 3257129 - stephanie.hamlin@maryland.gov
-- Provider ID: 5083445 (Tiffany Alston) - Local Department Home

-- Client ID: 3841365 (ZAYED EKEH) - 0bc9da28-e201-4945-8504-1ff4137db8b3
-- Placement ID: 1569679 - 2021-05-23 To 2022-02-02 - 7faa6e1b-e978-4684-b89d-a4b97261619c

-- Client ID: 3842424 (TREMAINE	BROWN) - 95e7020a-a80f-436e-818c-9e1c7b6962e1
-- Placement ID: 1569681 - 2022-02-02 To 2022-02-02 - 11df263d-51b6-4357-b353-2cbfca94b7ad

-- Category/ Module: Placements  (Case Management) 
-- Root cause: User Error
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- Client ID: 3841365 (ZAYED EKEH) - 0bc9da28-e201-4945-8504-1ff4137db8b3
-- Placement ID: 1569679 - 2021-05-23 To 2022-02-02 - 7faa6e1b-e978-4684-b89d-a4b97261619c

select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon 
from cjams.placement 
where placementid = '7faa6e1b-e978-4684-b89d-a4b97261619c'
	and activeflag  = 1 ;

update cjams.placement  
set startdatetime = '2019-05-23 00:00:00', 
	starttime = '09:01',
	updatedon = now(), 
	updatedby = 'CDM-21405'
where placementid = '7faa6e1b-e978-4684-b89d-a4b97261619c'
	and activeflag = 1 ;

-- Placement Revision Entry date changes
select entrydate, entrytime, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = '7faa6e1b-e978-4684-b89d-a4b97261619c' 
	and placementrevisionid 
		in (	'8d85d575-ea4e-43d5-8cd2-72990ce24d57',
				'e94111c5-6689-43c1-a6ff-30b2ccc97171'
			) ;	

update cjams.placementrevision  
set entrydate = '2019-05-23 00:00:00', 
	entrytime = '09:01',
	updatedon = now(), 
	updatedby = 'CDM-21405'
where placementid = '7faa6e1b-e978-4684-b89d-a4b97261619c' 
	and placementrevisionid 
		in (	'8d85d575-ea4e-43d5-8cd2-72990ce24d57',
				'e94111c5-6689-43c1-a6ff-30b2ccc97171'
			) ;

-- Delete 
select entrydate, entrytime, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = '7faa6e1b-e978-4684-b89d-a4b97261619c' 
	and placementrevisionid 
		in (	'4e6b6034-a476-4b65-8882-00147b49e4ae',
				'ed003ea1-a0cf-4030-a0cb-977f3763d0f7',
				'4a7041d1-f664-4974-966d-6092117d995b',
				'318d0f53-ab1d-4958-8f94-0dfacc14fc13',
				'd89f579e-6d54-4d91-ab92-ad295c2d917d'
			) ;	

Delete from cjams.placementrevision  
where placementid = '7faa6e1b-e978-4684-b89d-a4b97261619c' 
	and placementrevisionid 
		in (	'4e6b6034-a476-4b65-8882-00147b49e4ae',
				'ed003ea1-a0cf-4030-a0cb-977f3763d0f7',
				'4a7041d1-f664-4974-966d-6092117d995b',
				'318d0f53-ab1d-4958-8f94-0dfacc14fc13',
				'd89f579e-6d54-4d91-ab92-ad295c2d917d'
			) ;	

-- Routing Delete 
select routingid, eventcode, routingstatustypeid, activeflag, updatedby, updatedon  
	from cjams.routing  
where objectid = '7faa6e1b-e978-4684-b89d-a4b97261619c'
	and eventcode = 'PLTR'
	and routingid 
		in (	'c5954c23-4d38-4ddd-99f5-e99eaa88b23b',
				'16e8659d-b576-4676-bee0-49ae03482415',
				'b0f59406-26c7-4466-8d11-99dddf6cbde4',
				'7da5e399-84fa-43cc-a420-60bea6408f81',
				'2d4eb854-977b-4f83-9f0c-f5986b23f73d'
			);	

Delete from cjams.routing  
where objectid = '7faa6e1b-e978-4684-b89d-a4b97261619c'
	and eventcode = 'PLTR'
	and routingid 
		in (	'c5954c23-4d38-4ddd-99f5-e99eaa88b23b',
				'16e8659d-b576-4676-bee0-49ae03482415',
				'b0f59406-26c7-4466-8d11-99dddf6cbde4',
				'7da5e399-84fa-43cc-a420-60bea6408f81',
				'2d4eb854-977b-4f83-9f0c-f5986b23f73d'
			);	


-- Update Entry date 
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from cjams.tb_placement_validation 
where placement_id = 1569679 
	and delete_sw = 'N' ;

Update cjams.tb_placement_validation 
set placement_entry_dt = '2019-05-23'::date,
	-- placement_exit_dt = '2022-02-02'::date,
	update_ts = now(),
	update_user_id = 'CDM-21405'
where placement_id = 1569679 
	and delete_sw = 'N';
	


-- Client ID: 3842424 (TREMAINE	BROWN) - 95e7020a-a80f-436e-818c-9e1c7b6962e1
-- Placement ID: 1569681 - 2022-02-02 To 2022-02-02 - 11df263d-51b6-4357-b353-2cbfca94b7ad

select alternateid, startdatetime, starttime, enddatetime, endtime,
	exitreasontypekey, exittypekey, updatedby , updatedon 
from cjams.placement 
where placementid = '11df263d-51b6-4357-b353-2cbfca94b7ad'
	and activeflag  = 1 ;

update cjams.placement  
set startdatetime = '2019-05-23 00:00:00', 
	starttime = '09:01',
	updatedon = now(), 
	updatedby = 'CDM-21405'
where placementid = '11df263d-51b6-4357-b353-2cbfca94b7ad'
	and activeflag = 1 ;
	

-- Placement Revision Entry date changes
select entrydate, entrytime, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = '11df263d-51b6-4357-b353-2cbfca94b7ad' 
	and placementrevisionid 
		in (	'd52c73a8-7c75-44d3-bc80-3184c2b4e7c2',
				'bce09b98-f088-4324-b679-7313198ed92a'
			) ;	

update cjams.placementrevision  
set entrydate = '2019-05-23 00:00:00', 
	entrytime = '09:01',
	updatedon = now(), 
	updatedby = 'CDM-21405'
where placementid = '11df263d-51b6-4357-b353-2cbfca94b7ad' 
	and placementrevisionid 
		in (	'd52c73a8-7c75-44d3-bc80-3184c2b4e7c2',
				'bce09b98-f088-4324-b679-7313198ed92a'
			) ;	
			

-- Delete 
select entrydate, entrytime, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = '11df263d-51b6-4357-b353-2cbfca94b7ad' 
	and placementrevisionid 
		in (	'42eb83e0-e8e0-4c6d-9d31-3ceb4f6710b3',
				'a3d2bd86-ded9-4a0e-adda-1866a41d5ca2',
				'fa679c90-f0a3-4835-80d0-a55baad1119a',
				'd8974da6-60b2-4368-a372-91a7c02bd4f3'
			) ;	

Delete from cjams.placementrevision  
where placementid = '11df263d-51b6-4357-b353-2cbfca94b7ad' 
	and placementrevisionid 
		in (	'42eb83e0-e8e0-4c6d-9d31-3ceb4f6710b3',
				'a3d2bd86-ded9-4a0e-adda-1866a41d5ca2',
				'fa679c90-f0a3-4835-80d0-a55baad1119a',
				'd8974da6-60b2-4368-a372-91a7c02bd4f3'
			) ;	
			

-- Routing Delete 
select routingid, eventcode, routingstatustypeid, activeflag, updatedby, updatedon  
	from cjams.routing  
where objectid = '11df263d-51b6-4357-b353-2cbfca94b7ad'
	and eventcode = 'PLTR'
	and routingid 
		in (	'df3c82bb-0b7f-4778-94a7-8dc38f11382e',
				'02963bbd-d98c-4ff3-ade8-d594c2d47f79',
				'99342faa-5fd5-49a3-97b9-c5560e441952',
				'2332b9b3-0347-43ef-aa77-ad910f9a1dea'
			);	

Delete from cjams.routing  
where objectid = '11df263d-51b6-4357-b353-2cbfca94b7ad'
	and eventcode = 'PLTR'
	and routingid 
		in (	'df3c82bb-0b7f-4778-94a7-8dc38f11382e',
				'02963bbd-d98c-4ff3-ade8-d594c2d47f79',
				'99342faa-5fd5-49a3-97b9-c5560e441952',
				'2332b9b3-0347-43ef-aa77-ad910f9a1dea'
			);	

-- Update Entry date 
select placement_id, placement_entry_dt , placement_exit_dt,
	validation_start_dt, validation_end_dt, validation_status_cd,
	update_ts, update_user_id, delete_sw 
from cjams.tb_placement_validation 
where placement_id = 1569681 
	and delete_sw = 'N' ;

Update cjams.tb_placement_validation 
set placement_entry_dt = '2019-05-23'::date,
	-- placement_exit_dt = '2022-02-02'::date,
	update_ts = now(),
	update_user_id = 'CDM-21405'
where placement_id = 1569681 
	and delete_sw = 'N';

-- Call to generate missing Placement Vlaidations
select al_sqlcode, as_mess from cjams.sp_placement_validation_datafix(current_date, current_date, 'CDM-21405'::character varying ) ;
			
/*
-- To revert if needed
INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status)
VALUES('4e6b6034-a476-4b65-8882-00147b49e4ae'::uuid, '7faa6e1b-e978-4684-b89d-a4b97261619c'::uuid, '2022-03-16 00:00:00.000', '2021-05-23 00:00:00.000', '08:00', '2022-02-02 00:00:00.000', '08:00', NULL, 'CIPO', '', '3045', NULL, '1', '2022-03-16 15:30:25.107', 'afc92e34-98a3-412d-9ed0-9a83bd096df4', '2022-03-16 15:30:25.107', 'afc92e34-98a3-412d-9ed0-9a83bd096df4', 1, 1146890, NULL, NULL, NULL, NULL, 'CIP', 'Adoption ', 0, NULL, 'afc92e34-98a3-412d-9ed0-9a83bd096df4', '2022-03-16 15:30:25.107', NULL, NULL, NULL, NULL, NULL, 'Adoption placement ', 'Review');

INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status)
VALUES('ed003ea1-a0cf-4030-a0cb-977f3763d0f7'::uuid, '7faa6e1b-e978-4684-b89d-a4b97261619c'::uuid, '2022-03-16 00:00:00.000', '2021-05-23 00:00:00.000', '08:00', '2022-02-02 00:00:00.000', '08:00', NULL, 'CIPO', '', '3045', '2022-03-16 00:00:00.000', '1', '2022-03-16 15:28:00.738', 'afc92e34-98a3-412d-9ed0-9a83bd096df4', '2022-03-16 15:28:00.738', 'afc92e34-98a3-412d-9ed0-9a83bd096df4', 0, 1146887, NULL, NULL, NULL, NULL, 'CIP', 'Adoption ', 0, NULL, 'afc92e34-98a3-412d-9ed0-9a83bd096df4', '2022-03-16 15:28:00.738', NULL, NULL, NULL, NULL, NULL, 'Adoption placement ', 'Review');

INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status)
VALUES('4a7041d1-f664-4974-966d-6092117d995b'::uuid, '7faa6e1b-e978-4684-b89d-a4b97261619c'::uuid, '2022-03-16 00:00:00.000', '2021-05-23 00:00:00.000', '08:00', '2022-02-02 00:00:00.000', '08:00', NULL, 'CIPO', '', '3045', '2022-03-16 00:00:00.000', '1', '2022-03-16 11:16:15.420', 'afc92e34-98a3-412d-9ed0-9a83bd096df4', '2022-03-16 11:16:15.420', 'afc92e34-98a3-412d-9ed0-9a83bd096df4', 0, 1146790, NULL, NULL, NULL, NULL, 'CIP', 'Adoption ', 0, NULL, 'afc92e34-98a3-412d-9ed0-9a83bd096df4', '2022-03-16 11:16:15.420', NULL, NULL, NULL, NULL, NULL, 'Adoption placement ', 'Review');

INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status)
VALUES('318d0f53-ab1d-4958-8f94-0dfacc14fc13'::uuid, '7faa6e1b-e978-4684-b89d-a4b97261619c'::uuid, '2022-03-16 00:00:00.000', '2021-05-23 00:00:00.000', '08:00', '2022-02-02 00:00:00.000', '08:00', NULL, 'CIPO', '', '3281', '2022-03-16 00:00:00.000', '1', '2022-03-16 11:12:41.569', 'afc92e34-98a3-412d-9ed0-9a83bd096df4', '2022-03-16 11:12:41.569', 'afc92e34-98a3-412d-9ed0-9a83bd096df4', 0, 1146788, NULL, NULL, NULL, NULL, 'CIP', 'Adoption ', 0, NULL, 'afc92e34-98a3-412d-9ed0-9a83bd096df4', '2022-03-16 09:58:34.249', 'afc92e34-98a3-412d-9ed0-9a83bd096df4', '2022-03-16 11:12:41.569', NULL, NULL, NULL, NULL, 'Rejected');

INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status)
VALUES('d89f579e-6d54-4d91-ab92-ad295c2d917d'::uuid, '7faa6e1b-e978-4684-b89d-a4b97261619c'::uuid, '2022-03-16 00:00:00.000', '2021-05-23 00:00:00.000', '08:00', '2022-02-02 00:00:00.000', '08:00', NULL, 'CIPO', '', '3045', '2022-03-16 00:00:00.000', '1', '2022-03-16 09:58:34.249', 'afc92e34-98a3-412d-9ed0-9a83bd096df4', '2022-03-16 11:12:41.569', 'afc92e34-98a3-412d-9ed0-9a83bd096df4', 0, 1146760, NULL, NULL, NULL, NULL, 'CIP', 'Adoption ', 0, NULL, 'afc92e34-98a3-412d-9ed0-9a83bd096df4', '2022-03-16 09:58:34.249', 'afc92e34-98a3-412d-9ed0-9a83bd096df4', '2022-03-16 11:12:41.569', NULL, NULL, NULL, 'Adoption placement ', 'Rejected');

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('16e8659d-b576-4676-bee0-49ae03482415'::uuid, 'PLTR', 'afc92e34-98a3-412d-9ed0-9a83bd096df4', 'a53eb981-b61f-4942-8eda-8d56ad12df61', '92465090-c58e-46b6-8a5c-9d2f30aa64b1'::uuid, 'CWSP', 'CWSP', '7faa6e1b-e978-4684-b89d-a4b97261619c', 15, 0, 'afc92e34-98a3-412d-9ed0-9a83bd096df4', '2022-03-16 15:27:59.733', 'afc92e34-98a3-412d-9ed0-9a83bd096df4', '2022-03-16 15:30:24.056', true, '', NULL, 'Placement Exit Submitted for review', '3257129', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('b0f59406-26c7-4466-8d11-99dddf6cbde4'::uuid, 'PLTR', 'afc92e34-98a3-412d-9ed0-9a83bd096df4', 'a53eb981-b61f-4942-8eda-8d56ad12df61', '92465090-c58e-46b6-8a5c-9d2f30aa64b1'::uuid, 'CWSP', 'CWSP', '7faa6e1b-e978-4684-b89d-a4b97261619c', 15, 0, 'afc92e34-98a3-412d-9ed0-9a83bd096df4', '2022-03-16 11:16:13.563', 'afc92e34-98a3-412d-9ed0-9a83bd096df4', '2022-03-16 15:27:59.733', true, '', NULL, 'Placement Exit Submitted for review', '3257129', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('2d4eb854-977b-4f83-9f0c-f5986b23f73d'::uuid, 'PLTR', 'afc92e34-98a3-412d-9ed0-9a83bd096df4', 'a53eb981-b61f-4942-8eda-8d56ad12df61', '92465090-c58e-46b6-8a5c-9d2f30aa64b1'::uuid, 'CWSP', 'CWSP', '7faa6e1b-e978-4684-b89d-a4b97261619c', 15, 0, 'afc92e34-98a3-412d-9ed0-9a83bd096df4', '2022-03-16 09:58:33.223', 'afc92e34-98a3-412d-9ed0-9a83bd096df4', '2022-03-16 11:12:41.569', true, '', NULL, 'Placement Exit Submitted for review', '3257129', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('c5954c23-4d38-4ddd-99f5-e99eaa88b23b'::uuid, 'PLTR', 'afc92e34-98a3-412d-9ed0-9a83bd096df4', 'a53eb981-b61f-4942-8eda-8d56ad12df61', '92465090-c58e-46b6-8a5c-9d2f30aa64b1'::uuid, 'CWSP', 'CWSP', '7faa6e1b-e978-4684-b89d-a4b97261619c', 15, 1, 'afc92e34-98a3-412d-9ed0-9a83bd096df4', '2022-03-16 15:30:24.056', 'afc92e34-98a3-412d-9ed0-9a83bd096df4', '2022-03-16 15:30:24.056', true, '', NULL, 'Placement Exit Submitted for review', '3257129', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('7da5e399-84fa-43cc-a420-60bea6408f81'::uuid, 'PLTR', 'afc92e34-98a3-412d-9ed0-9a83bd096df4', 'afc92e34-98a3-412d-9ed0-9a83bd096df4', '92465090-c58e-46b6-8a5c-9d2f30aa64b1'::uuid, 'CWSP', 'CWSP', '7faa6e1b-e978-4684-b89d-a4b97261619c', 17, 1, 'afc92e34-98a3-412d-9ed0-9a83bd096df4', '2022-03-16 11:12:41.569', 'afc92e34-98a3-412d-9ed0-9a83bd096df4', '2022-03-16 11:12:41.569', true, 'Error', NULL, 'Child PlacementRejected', '3257129', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status)
VALUES('42eb83e0-e8e0-4c6d-9d31-3ceb4f6710b3'::uuid, '11df263d-51b6-4357-b353-2cbfca94b7ad'::uuid, '2022-03-16 00:00:00.000', '2022-02-02 00:00:00.000', '08:00', '2022-02-02 00:00:00.000', '08:00', NULL, 'CIPO', '', '3045', NULL, '1', '2022-03-16 15:26:53.004', 'afc92e34-98a3-412d-9ed0-9a83bd096df4', '2022-03-16 15:26:53.004', 'afc92e34-98a3-412d-9ed0-9a83bd096df4', 1, 1146886, NULL, NULL, NULL, NULL, 'CIP', 'Adoption', 0, NULL, 'afc92e34-98a3-412d-9ed0-9a83bd096df4', '2022-03-16 15:26:53.004', NULL, NULL, NULL, NULL, NULL, 'Adoption ', 'Review');

INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status)
VALUES('a3d2bd86-ded9-4a0e-adda-1866a41d5ca2'::uuid, '11df263d-51b6-4357-b353-2cbfca94b7ad'::uuid, '2022-03-16 00:00:00.000', '2022-02-02 00:00:00.000', '08:00', '2022-02-02 00:00:00.000', '08:00', NULL, 'CIPO', '', '3045', '2022-03-16 00:00:00.000', '1', '2022-03-16 11:17:01.395', 'afc92e34-98a3-412d-9ed0-9a83bd096df4', '2022-03-16 11:17:01.395', 'afc92e34-98a3-412d-9ed0-9a83bd096df4', 0, 1146791, NULL, NULL, NULL, NULL, 'CIP', 'Adoption', 0, NULL, 'afc92e34-98a3-412d-9ed0-9a83bd096df4', '2022-03-16 11:17:01.395', NULL, NULL, NULL, NULL, NULL, 'Adoption ', 'Review');

INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status)
VALUES('d8974da6-60b2-4368-a372-91a7c02bd4f3'::uuid, '11df263d-51b6-4357-b353-2cbfca94b7ad'::uuid, '2022-03-16 00:00:00.000', '2022-02-02 00:00:00.000', '08:00', '2022-02-02 00:00:00.000', '08:00', NULL, 'CIPO', '', '3045', '2022-03-16 00:00:00.000', '1', '2022-03-16 09:59:14.815', 'afc92e34-98a3-412d-9ed0-9a83bd096df4', '2022-03-16 11:11:45.864', 'afc92e34-98a3-412d-9ed0-9a83bd096df4', 0, 1146761, NULL, NULL, NULL, NULL, 'CIP', 'Adoption', 0, NULL, 'afc92e34-98a3-412d-9ed0-9a83bd096df4', '2022-03-16 09:59:14.815', 'afc92e34-98a3-412d-9ed0-9a83bd096df4', '2022-03-16 11:11:45.864', NULL, NULL, NULL, 'Adoption ', 'Rejected');

INSERT INTO cjams.placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypetypkey, exitreasontypkey, exitexplanation, approvalstatustypkey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, voidreasontypekey, voidremarks, enddate, endtime, exittypekey, remarks, isvoided, voiddate, requestedby, requesteddate, approvedby, approveddate, etl_userid, etl_load_date, ischangepreadoptive, justification, status)
VALUES('fa679c90-f0a3-4835-80d0-a55baad1119a'::uuid, '11df263d-51b6-4357-b353-2cbfca94b7ad'::uuid, '2022-03-16 00:00:00.000', '2022-02-02 00:00:00.000', '08:00', '2022-02-02 00:00:00.000', '08:00', NULL, 'CIPO', '', '3281', '2022-03-16 00:00:00.000', '1', '2022-03-16 11:11:45.864', 'afc92e34-98a3-412d-9ed0-9a83bd096df4', '2022-03-16 11:11:45.864', 'afc92e34-98a3-412d-9ed0-9a83bd096df4', 0, 1146787, NULL, NULL, NULL, NULL, 'CIP', 'Adoption', 0, NULL, 'afc92e34-98a3-412d-9ed0-9a83bd096df4', '2022-03-16 09:59:14.815', 'afc92e34-98a3-412d-9ed0-9a83bd096df4', '2022-03-16 11:11:45.864', NULL, NULL, NULL, NULL, 'Rejected');

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('02963bbd-d98c-4ff3-ade8-d594c2d47f79'::uuid, 'PLTR', 'afc92e34-98a3-412d-9ed0-9a83bd096df4', 'a53eb981-b61f-4942-8eda-8d56ad12df61', '92465090-c58e-46b6-8a5c-9d2f30aa64b1'::uuid, 'CWSP', 'CWSP', '11df263d-51b6-4357-b353-2cbfca94b7ad', 15, 0, 'afc92e34-98a3-412d-9ed0-9a83bd096df4', '2022-03-16 11:17:00.384', 'afc92e34-98a3-412d-9ed0-9a83bd096df4', '2022-03-16 15:26:51.710', true, '', NULL, 'Placement Exit Submitted for review', '3257129', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('2332b9b3-0347-43ef-aa77-ad910f9a1dea'::uuid, 'PLTR', 'afc92e34-98a3-412d-9ed0-9a83bd096df4', 'a53eb981-b61f-4942-8eda-8d56ad12df61', '92465090-c58e-46b6-8a5c-9d2f30aa64b1'::uuid, 'CWSP', 'CWSP', '11df263d-51b6-4357-b353-2cbfca94b7ad', 15, 0, 'afc92e34-98a3-412d-9ed0-9a83bd096df4', '2022-03-16 09:59:13.809', 'afc92e34-98a3-412d-9ed0-9a83bd096df4', '2022-03-16 11:11:45.864', true, '', NULL, 'Placement Exit Submitted for review', '3257129', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('df3c82bb-0b7f-4778-94a7-8dc38f11382e'::uuid, 'PLTR', 'afc92e34-98a3-412d-9ed0-9a83bd096df4', 'a53eb981-b61f-4942-8eda-8d56ad12df61', '92465090-c58e-46b6-8a5c-9d2f30aa64b1'::uuid, 'CWSP', 'CWSP', '11df263d-51b6-4357-b353-2cbfca94b7ad', 15, 1, 'afc92e34-98a3-412d-9ed0-9a83bd096df4', '2022-03-16 15:26:51.710', 'afc92e34-98a3-412d-9ed0-9a83bd096df4', '2022-03-16 15:26:51.710', true, '', NULL, 'Placement Exit Submitted for review', '3257129', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('99342faa-5fd5-49a3-97b9-c5560e441952'::uuid, 'PLTR', 'afc92e34-98a3-412d-9ed0-9a83bd096df4', 'afc92e34-98a3-412d-9ed0-9a83bd096df4', '92465090-c58e-46b6-8a5c-9d2f30aa64b1'::uuid, 'CWSP', 'CWSP', '11df263d-51b6-4357-b353-2cbfca94b7ad', 17, 1, 'afc92e34-98a3-412d-9ed0-9a83bd096df4', '2022-03-16 11:11:45.864', 'afc92e34-98a3-412d-9ed0-9a83bd096df4', '2022-03-16 11:11:45.864', true, 'Error ', NULL, 'Child PlacementRejected', '3257129', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/
