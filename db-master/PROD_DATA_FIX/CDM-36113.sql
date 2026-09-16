--CDM-36113
-- Root cause: Data issue (Routing table is having no active record)
-- Fix Provided: Datafix has been promoted to fix the routing data.	
/*
updated  -39
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('042a2e8f-62a5-4e5a-af9d-00ad4e545626', 'PCAUTH', 'eb66e18a-872a-4a5d-9e7e-d1ff8d8c8ad3', '8302bc5c-35f0-4a49-a397-361305939deb', '60296e7e-5bb8-40b2-9bba-bb8a87a325c9', 'CWCW', 'CWSP', '1857742', 39, 1, 'eb66e18a-872a-4a5d-9e7e-d1ff8d8c8ad3', '2023-12-21 13:15:25.925', 'eb66e18a-872a-4a5d-9e7e-d1ff8d8c8ad3', '2023-12-21 13:15:25.925', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '3177705', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

43

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('db94abdd-b4ec-4373-880c-31437f4f40b4', 'PCAUTHR', '8ba0f2d2-c56d-4dee-a2f8-616f6d09ed40', '8302bc5c-35f0-4a49-a397-361305939deb', 'b1de819d-0f16-4f9e-a86d-d1b89d0474da', 'FNSFS', 'FNSFS', '1857742', 43, 1, '8ba0f2d2-c56d-4dee-a2f8-616f6d09ed40', '2022-10-14 15:29:56.991', '8ba0f2d2-c56d-4dee-a2f8-616f6d09ed40', '2022-10-14 15:29:56.991', true, 'Approved', NULL, 'Purchase Authorization Forwarded to Payment Approval', NULL, 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


*/
delete from routing where routingid='042a2e8f-62a5-4e5a-af9d-00ad4e545626';

delete from routing where routingid='ac759ed5-9abc-4b99-8e5c-122548ae8c38';

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('ac759ed5-9abc-4b99-8e5c-122548ae8c38', 'PCAUTH', 'eb66e18a-872a-4a5d-9e7e-d1ff8d8c8ad3', 'f292c712-26e7-43a5-9aaa-b81bc905f8f9', '60296e7e-5bb8-40b2-9bba-bb8a87a325c9', 'CWCW', 'CWSP', '1857742', 39, 0, 'eb66e18a-872a-4a5d-9e7e-d1ff8d8c8ad3', '2022-10-14 11:19:58.889', 'eb66e18a-872a-4a5d-9e7e-d1ff8d8c8ad3', '2022-10-14 13:50:43.672', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '3177705', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

update cjams.routing set 
insertedon='2022-10-17 15:29:56' , updatedby='CDM-36113',updatedon=now() where routingid='db94abdd-b4ec-4373-880c-31437f4f40b4';

delete from routing where routingid='7dcf3868-20f0-496a-9ff1-3e0b0153d253';

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('7dcf3868-20f0-496a-9ff1-3e0b0153d253', 'PCAUTHR', 'f292c712-26e7-43a5-9aaa-b81bc905f8f9', '8ba0f2d2-c56d-4dee-a2f8-616f6d09ed40', 'b1de819d-0f16-4f9e-a86d-d1b89d0474da', 'CWSP', 'FNSFS', '1857742', 40, 0, 'f292c712-26e7-43a5-9aaa-b81bc905f8f9', '2022-10-14 13:50:43.672', 'f292c712-26e7-43a5-9aaa-b81bc905f8f9', '2022-10-14 15:29:56.991', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3177705', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
