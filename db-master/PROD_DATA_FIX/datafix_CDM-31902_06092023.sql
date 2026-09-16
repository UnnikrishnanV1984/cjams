-- CDM-31902 - Pending Approvals
/*
-- Issue Description: 
   Pending supervisory approvals that are no longer pending.

-- Baltimore County Supervisor: Megan Brasauskas
-- Auth ID: 2129501 & 1836751
-- Case ID: 3267776 - Guardianship Disclosure Review
-- Case ID: 202101905457 - Case Plan 2 Review

-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Data issue (duplicate multiple active records in routing table)
-- Fix Provided: Datafix has been promoted to remove the pending routing records 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Auth ID: 2129501
-- update activefalg = 0
-- 1	39	Forwarded to Case Supervisor	e44c5c1a-1a78-4373-9895-3b8c8f61c1fb

select objectid, objecttypekey, eventcode, routingstatustypeid, remarks, activeflag, updatedby, updatedon 
	from routing 
where routingid = 'e44c5c1a-1a78-4373-9895-3b8c8f61c1fb'
	and objectid = '2129501'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1;
	
update routing
set activeflag = 0, 
	updatedby = 'CDM-31902', 
	updatedon = now()
where routingid = 'e44c5c1a-1a78-4373-9895-3b8c8f61c1fb'
	and objectid = '2129501'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1;
	

-- Auth ID: 1836751 - Delete duplicate Pending routing records 
/*
-- Delete 
1	39	Forwarded to Case Supervisor	35017f33-9351-4da3-ac5b-52aaa46c4eb6
1	40	Forwarded to Funding Approval	5c8f91df-0ca2-456a-9c2e-817f0a5e0fb3
1	40	Forwarded to Funding Approval	bc0f29c6-8634-4ac8-80b3-0d6b9f14ad93

-- Update activeflag = 1
0	43	Approved	243bf200-f74f-452e-88de-3896f4aedc3a
*/

select *
	from routing 
where routingid 
	in (	'35017f33-9351-4da3-ac5b-52aaa46c4eb6',
			'5c8f91df-0ca2-456a-9c2e-817f0a5e0fb3',
			'bc0f29c6-8634-4ac8-80b3-0d6b9f14ad93'
		)	
	and objectid = '1836751'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	-- and activeflag = 1 
	;
	
delete from routing   
where routingid 
	in (	'35017f33-9351-4da3-ac5b-52aaa46c4eb6',
			'5c8f91df-0ca2-456a-9c2e-817f0a5e0fb3',
			'bc0f29c6-8634-4ac8-80b3-0d6b9f14ad93'
		)	
	and objectid = '1836751'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	-- and activeflag = 1 
	;

select objectid, objecttypekey, eventcode, routingstatustypeid, remarks, activeflag, updatedby, updatedon 
	from routing 
where routingid = '243bf200-f74f-452e-88de-3896f4aedc3a'
	and objectid = '1836751'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 0 ;
	
update routing
set activeflag = 1, 
	updatedby = 'CDM-31902', 
	updatedon = now()
where routingid = '243bf200-f74f-452e-88de-3896f4aedc3a'
	and objectid = '1836751'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 0 ;

-- Case ID: 3267776 - Guardianship Disclosure Review
-- Case ID: 202101905457 - Case Plan 2 Review
select routingstatustypeid, remarks, eventcode, tosecurityusersid, activeflag, updatedby , updatedon
	from routing
where routingid in ('3a8e038f-f69d-494f-bd89-d3cc073ff584',
					'97b65160-d4f3-465f-904e-77c7e71e2093')
	and activeflag = 1 ;
	
update routing
set activeflag = 0, 
	updatedby = 'CDM-31902', 
	updatedon = now()
where routingid in ('3a8e038f-f69d-494f-bd89-d3cc073ff584',
					'97b65160-d4f3-465f-904e-77c7e71e2093')
	and activeflag = 1 ;
	
/*
-- To Revert the data if needed 

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('35017f33-9351-4da3-ac5b-52aaa46c4eb6'::uuid, 'PCAUTH', 'b1605a6d-852f-4b59-a777-8e43290f4e13', 'ebb0f319-fdda-4ed3-bd27-3ba9ba2ea5a0', 'daf6ac19-05d9-4df9-959a-3dc7913fffbd'::uuid, 'CWCW', 'CWSP', '1836751', 39, 1, 'b1605a6d-852f-4b59-a777-8e43290f4e13', '2022-06-07 09:55:10.932', 'b1605a6d-852f-4b59-a777-8e43290f4e13', '2022-06-07 09:55:10.932', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '3099164', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('5c8f91df-0ca2-456a-9c2e-817f0a5e0fb3'::uuid, 'PCAUTHR', 'ebb0f319-fdda-4ed3-bd27-3ba9ba2ea5a0', NULL, '38cdec8a-7d34-4c43-9c04-bc0fcb644c6c'::uuid, 'CWSP', 'FNSFS', '1836751', 40, 1, 'ebb0f319-fdda-4ed3-bd27-3ba9ba2ea5a0', '2022-06-23 11:16:52.221', 'ebb0f319-fdda-4ed3-bd27-3ba9ba2ea5a0', '2022-06-23 11:16:52.221', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3099164', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('bc0f29c6-8634-4ac8-80b3-0d6b9f14ad93'::uuid, 'PCAUTHR', 'ebb0f319-fdda-4ed3-bd27-3ba9ba2ea5a0', NULL, '38cdec8a-7d34-4c43-9c04-bc0fcb644c6c'::uuid, 'CWSP', 'FNSFS', '1836751', 40, 1, 'ebb0f319-fdda-4ed3-bd27-3ba9ba2ea5a0', '2022-06-23 11:02:53.289', 'ebb0f319-fdda-4ed3-bd27-3ba9ba2ea5a0', '2022-06-23 11:02:53.289', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3099164', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

*/
