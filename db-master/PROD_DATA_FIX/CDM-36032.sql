-- Issue Description: 
--CDM-36032
-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Data issue (Routing table is having no active record)
-- Fix Provided: Datafix has been promoted to fix the routing data.	

--INSERT INTO cjams.routing
--(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
--VALUES('c8b5bdaa-ee30-4cb2-ae09-efadfeaf7d53', 'PCAUTH', '45391f16-58de-4b24-bd7e-12cdc4ff4335', '676ac1ec-f338-4646-a786-b3af379986f9', '6629c2a6-9d4d-4d3f-b6c2-0d842f161cc6', 'CWSP', 'CWSP', '2654065', 39, 0, '45391f16-58de-4b24-bd7e-12cdc4ff4335', '2023-12-18 14:48:04.177', 'CDM-36032', '2023-12-21 12:21:40.946', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '2020024502756', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

delete FROM routing where  objectid='2654065' and routingid='c8b5bdaa-ee30-4cb2-ae09-efadfeaf7d53';

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('9405a6f3-6065-4e71-99bc-ea48b31e6b3d', 'PCAUTH', '45391f16-58de-4b24-bd7e-12cdc4ff4335', 'd636ac2f-53ff-43e0-adbf-35c97e0427ec', '6629c2a6-9d4d-4d3f-b6c2-0d842f161cc6', 'CWSP', 'CWSP', '2654065', 39, 0, '45391f16-58de-4b24-bd7e-12cdc4ff4335', '2023-10-27 00:00:00.000', 'd636ac2f-53ff-43e0-adbf-35c97e0427ec', '2023-10-27 00:00:00.000', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '211030008202', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('dc15ed23-a38b-4011-ad13-dd924850f16f', 'PCAUTHR', 'd636ac2f-53ff-43e0-adbf-35c97e0427ec', 'ba2dbc8f-3213-4b1b-9905-d643e1692db1', '6629c2a6-9d4d-4d3f-b6c2-0d842f161cc6', 'CWSP', 'CWSP', '2654065', 42, 0, 'd636ac2f-53ff-43e0-adbf-35c97e0427ec', '2023-10-27 00:00:00.000', 'ba2dbc8f-3213-4b1b-9905-d643e1692db1', '2023-10-27 00:00:00.000', true, 'Forwarded to Director Approval', NULL, 'Purchase Authorization Forwarded to Director Approval', '211030008202', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('4603527e-cd47-48be-87f5-50a90f8d6f63', 'PCAUTHR', 'ba2dbc8f-3213-4b1b-9905-d643e1692db1', '32414234-1c88-4bfd-b94e-7816d0003453', '6629c2a6-9d4d-4d3f-b6c2-0d842f161cc6', 'CWSP', 'FNSFS', '2654065', 44, 0, 'ba2dbc8f-3213-4b1b-9905-d643e1692db1', '2023-10-31 00:00:00.000', '32414234-1c88-4bfd-b94e-7816d0003453', '2023-10-31 14:51:12.000', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '211030008202', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);




