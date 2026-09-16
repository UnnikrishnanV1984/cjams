-- Issue Description: 
--CDM-36024
-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Data issue (Routing table is having no active record)
-- Fix Provided: Datafix has been promoted to fix the routing data.				

--  update routing set activeflag=0, updatedby='CDM-36024',updatedon=now() where objectid='1849896'
--     and routingid='902865db-38cf-49fc-85b5-473122969cb8';

/*
 INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('902865db-38cf-49fc-85b5-473122969cb8', 'PCAUTH', '45391f16-58de-4b24-bd7e-12cdc4ff4335', '676ac1ec-f338-4646-a786-b3af379986f9', '6629c2a6-9d4d-4d3f-b6c2-0d842f161cc6', 'CWSP', 'CWSP', '1849896', 39, 0, '45391f16-58de-4b24-bd7e-12cdc4ff4335', '2023-12-18 13:40:17.329', 'CDM-36024', '2023-12-20 18:11:57.727', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '211030008202', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

*/
--select * from routing where  objectid='1849896' and routingid='902865db-38cf-49fc-85b5-473122969cb8';
delete FROM routing where  objectid='1849896' and routingid='902865db-38cf-49fc-85b5-473122969cb8';
delete FROM routing where  objectid='1849896' and routingid in('d2913249-09bc-4773-ad9f-094ae368b27f','7347dd6e-e550-42ee-9297-1fb835422e5e','ba0860d3-31ae-4f85-848b-04367207b320');


-- director 'amesham.smith@maryland.gov' '55cc5a5b-e268-4316-bffd-26e086d57285
--FNS 'aderemi.talabi@maryland.gov' '32414234-1c88-4bfd-b94e-7816d0003453
--case worker 'wanda.nolt@maryland.gov' d636ac2f-53ff-43e0-adbf-35c97e0427ec 
--supervisor 'sheritta.barr-stanley1@maryland.gov 056865a7-2a58-494e-9993-ccc6fd9aae58
-- insert from case worker to supervisor
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('d2913249-09bc-4773-ad9f-094ae368b27f', 'PCAUTH', 'd636ac2f-53ff-43e0-adbf-35c97e0427ec', '056865a7-2a58-494e-9993-ccc6fd9aae58', '6629c2a6-9d4d-4d3f-b6c2-0d842f161cc6', 'CWSP', 'CWSP', '1849896', 39, 0, 'd636ac2f-53ff-43e0-adbf-35c97e0427ec', '2022-08-31 00:00:00.000', '056865a7-2a58-494e-9993-ccc6fd9aae58', '2022-09-29 00:00:00.000', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '211030008202', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('7347dd6e-e550-42ee-9297-1fb835422e5e', 'PCAUTHR', '056865a7-2a58-494e-9993-ccc6fd9aae58', '32414234-1c88-4bfd-b94e-7816d0003453', '6629c2a6-9d4d-4d3f-b6c2-0d842f161cc6', 'CWSP', 'FNSFS', '1849896', 44, 0, '056865a7-2a58-494e-9993-ccc6fd9aae58', '2022-10-31 11:45:34.000', '32414234-1c88-4bfd-b94e-7816d0003453', '2022-10-31 00:00:00.000', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '211030008202', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

