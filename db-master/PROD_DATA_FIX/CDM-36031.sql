-- Issue Description: 
--CDM-36031
-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Data issue (Routing table is having no active record)
-- Fix Provided: Datafix has been promoted to fix the routing data.	
/*
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('2ab2bbcb-5cef-473c-9452-03e53a3c9d92', 'PCAUTH', '45391f16-58de-4b24-bd7e-12cdc4ff4335', '676ac1ec-f338-4646-a786-b3af379986f9', '6629c2a6-9d4d-4d3f-b6c2-0d842f161cc6', 'CWSP', 'CWSP', '1832554', 39, 0, '45391f16-58de-4b24-bd7e-12cdc4ff4335', '2023-12-18 14:18:38.448', 'CDM-36031', '2023-12-21 10:15:39.087', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '3215035', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/
delete FROM routing where  objectid='1832554' and routingid='2ab2bbcb-5cef-473c-9452-03e53a3c9d92';

delete FROM routing where  objectid='1832554' and routingid in('f19e7454-6ca7-46bf-acd3-fcada32e4512','47ed1eba-3b1c-4d39-bdf5-56585af0cc93','ee572f7b-62f9-4fa4-a414-184fd92ca9d7');

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('f19e7454-6ca7-46bf-acd3-fcada32e4512', 'PCAUTH', '7f7a58e2-4847-4642-801a-f0b2a7c37cfa', '4b8d30e9-1b01-47cb-9cdf-9308451bf98a', '6629c2a6-9d4d-4d3f-b6c2-0d842f161cc6', 'CWSP', 'CWSP', '1832554', 39, 0, '7f7a58e2-4847-4642-801a-f0b2a7c37cfa', '2022-05-19 00:00:00.000', '55cc5a5b-e268-4316-bffd-26e086d57285', '2022-06-03 00:00:00.000', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '211030008202', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('ee572f7b-62f9-4fa4-a414-184fd92ca9d7', 'PCAUTHR', '4b8d30e9-1b01-47cb-9cdf-9308451bf98a', '32414234-1c88-4bfd-b94e-7816d0003453', '6629c2a6-9d4d-4d3f-b6c2-0d842f161cc6', 'CWSP', 'FNSFS', '1832554', 44, 0, '55cc5a5b-e268-4316-bffd-26e086d57285', '2022-06-03 00:00:00.000', '32414234-1c88-4bfd-b94e-7816d0003453', '2022-06-03 14:07:51.000', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '211030008202', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

