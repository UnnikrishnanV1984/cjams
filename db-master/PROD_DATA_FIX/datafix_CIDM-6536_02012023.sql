-- CIDM-6536-1 - Case Closure Data Fix
/*
-- Issue Description: 
  User request to Close below 2 CPS Cases

-- CPS-AR: 2020051015881 - a7e0be1c-78db-4a26-8128-6cbbeb2f1203
-- Requested by: Maureen Wahl - 1f56edc2-357f-44eb-b07e-c3bdb21aface
-- Approved by: Tracy Enriquez - f758b860-0a83-4aac-8157-87267159abcf
-- Case Closure Date & Time: 2/24/2020

-- Category/ Module: GAP (Case Management) 
-- Root cause: Flaw in the code, code fix has been promoted as a part of this defect. 
-- Fix Provided: Datafix has been promoted to Close the requested CPS cases
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- Delete  
select count(*) from routing where insertedby = 'CIDM-6536' and servicerequestnumber = '2020051015881';
delete from routing where insertedby = 'CIDM-6536' and servicerequestnumber = '2020051015881';

select count(*) from routing where insertedby = 'CIDM-6536-1';
delete from routing where insertedby = 'CIDM-6536-1';

-- CPS-AR: 2020051015881 - a7e0be1c-78db-4a26-8128-6cbbeb2f1203
-- Requested by: Maureen Wahl - 1f56edc2-357f-44eb-b07e-c3bdb21aface
-- Approved by: Tracy Enriquez - f758b860-0a83-4aac-8157-87267159abcf
-- Case Closure Date & Time: 2/24/2020

select intakeserviceid, exitdate, updatedon, updatedby
	from intakeservicerequest 
where servicerequestnumber  = '2020051015881' ;

update intakeservicerequest
set exitdate = '2020-02-24 21:22:02.563',
	updatedon = now(),
	updatedby = 'CIDM-6536-1' 
where servicerequestnumber  = '2020051015881' ;	

-- d90db0d3-f665-49db-b3ad-0edb468bc02d	Recommend for closure
INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, 
		tosecurityusersid, teamid, 
		fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, 
		objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, 
		etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	cjams.gen_random_uuid(), 'INDR', '1f56edc2-357f-44eb-b07e-c3bdb21aface', 
		'f758b860-0a83-4aac-8157-87267159abcf', '5da69eb1-7274-4bb5-82ac-dfdc962c9e9a'::uuid, 
		'CWCW', 'CWSP', '6bb37306-d563-4172-a693-e1dd1c8ece15', 15, 0, 
		'CIDM-6536-1', '2020-02-24 13:15:31.000', 'CIDM-6536-1', '2020-02-24 13:15:31.000', 
		true, 'Disposition Request', NULL, 'Disposition Request', '2020051015881', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL
	);

INSERT INTO cjams.routing
	(	routingid, eventcode, fromsecurityusersid, 
		tosecurityusersid, teamid, 
		fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, 
		isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, 
		objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, 
		etl_userid, etl_load_date, entityid, reassignnotes
	)
VALUES
	(	cjams.gen_random_uuid(), 'INDR', 'f758b860-0a83-4aac-8157-87267159abcf', 
		'1f56edc2-357f-44eb-b07e-c3bdb21aface', '1be296ef-d018-4c25-ad8a-9f5070f5b115'::uuid, 
		'CWSP', 'CWCW', '6bb37306-d563-4172-a693-e1dd1c8ece15', 16, 1, 
		'CIDM-6536-1', '2020-02-24 21:22:02.563', 'CIDM-6536-1', '2020-02-24 21:22:02.563', 
		true, 'Disposition Approved', NULL, 'Disposition Approved', '2020051015881', 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL
	);

