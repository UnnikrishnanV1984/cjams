-- CDM-15403 - Finance
/*
-- Issue Description: 
   Approved Purchase Authorization with Pending routing records 

-- Authorization ID: 1785490 
-- 9ce34557-c843-49de-9273-586b9bbeb378 - Forwarded to Funding Approval
    
-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Data issue (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
-- Backup Query
    INSERT INTO cjams.routing
	(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
	VALUES('9ce34557-c843-49de-9273-586b9bbeb378'::uuid, 'PCAUTHR', 'e1629c54-5b3c-4e77-ab4f-f076018d4bb1', '7ce4e320-310f-494b-9f43-82d38571d6c7', '38cdec8a-7d34-4c43-9c04-bc0fcb644c6c'::uuid, 'CWSP', 'FNSFS', '1785490', 40, 1, 'e1629c54-5b3c-4e77-ab4f-f076018d4bb1', '2021-07-15 14:14:43.837', 'e1629c54-5b3c-4e77-ab4f-f076018d4bb1', '2021-07-15 14:14:43.837', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3240220', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

    INSERT INTO cjams.routing
    (routingstatustypeid, routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
    VALUES(39, '21968eda-ccb0-44e7-971e-ad8919b4a007'::uuid, 'PCAUTH', '44a87d4b-ab4e-4ee8-9cdd-a78f3f615f68', 'e1629c54-5b3c-4e77-ab4f-f076018d4bb1', '945a7955-d865-4520-abb0-b908b31db7c8'::uuid, 'CWCW', 'CWSP', '1785490', 39, 1, '44a87d4b-ab4e-4ee8-9cdd-a78f3f615f68', '2021-07-15 13:33:16.147', '44a87d4b-ab4e-4ee8-9cdd-a78f3f615f68', '2021-07-15 13:33:16.147', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '3240220', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

    INSERT INTO cjams.routing
    (routingstatustypeid, routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
    VALUES(39, 'f7238fdf-c632-4c8a-88ce-d3ada4480e96'::uuid, 'PCAUTH', '44a87d4b-ab4e-4ee8-9cdd-a78f3f615f68', 'e1629c54-5b3c-4e77-ab4f-f076018d4bb1', '945a7955-d865-4520-abb0-b908b31db7c8'::uuid, 'CWCW', 'CWSP', '1785490', 39, 1, '44a87d4b-ab4e-4ee8-9cdd-a78f3f615f68', '2021-07-15 13:33:09.502', '44a87d4b-ab4e-4ee8-9cdd-a78f3f615f68', '2021-07-15 13:33:09.502', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '3240220', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/

delete from routing where routingid  in ('9ce34557-c843-49de-9273-586b9bbeb378', '21968eda-ccb0-44e7-971e-ad8919b4a007', 'f7238fdf-c632-4c8a-88ce-d3ada4480e96');
