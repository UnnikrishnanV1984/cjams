/*
-- CDM-23753-- 

-- Issue Description: 
 Unable to remove items from case pending approval inbox
  
-- Customer Email ID: sarah.utz@maryland.gov

-- Root cause: Data fix to delete duplicate purchase authorizatiom records
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Deleting Record with 39
--INSERT INTO cjams.routing
--(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
--VALUES('5d6af597-a3b6-4c25-93b0-3efecba4b216'::uuid, 'PCAUTH', 'a63cd2d1-5c74-43c8-a29e-82764ecbd60e', 'f292c712-26e7-43a5-9aaa-b81bc905f8f9', '60296e7e-5bb8-40b2-9bba-bb8a87a325c9'::uuid, 'CWCW', 'CWSP', '1842643', 39, 1, 'a63cd2d1-5c74-43c8-a29e-82764ecbd60e', '2022-07-14 08:19:10.882', 'a63cd2d1-5c74-43c8-a29e-82764ecbd60e', '2022-07-14 08:19:10.882', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '3284355', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- Deleting Record with status 42
--INSERT INTO cjams.routing
--(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
--VALUES('8c9aed18-a77b-46ac-b59b-2585fb8922a5'::uuid, 'PCAUTH', 'f292c712-26e7-43a5-9aaa-b81bc905f8f9', 'a26dcd1d-a287-43bb-afc9-da75f966f69b', '263e4d5d-cf6c-4e7d-8c35-394a62e46028'::uuid, 'CWSP', 'CWSP', '1842643', 42, 0, 'f292c712-26e7-43a5-9aaa-b81bc905f8f9', '2022-07-14 15:34:11.143', 'f292c712-26e7-43a5-9aaa-b81bc905f8f9', '2022-07-14 15:34:44.274', true, 'Forwarded to Director Approval', NULL, 'Purchase Authorization Forwarded to Director Approval', '3284355', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
--INSERT INTO cjams.routing
--(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
--VALUES('8ccaaffa-0135-450b-ab53-1fc43e93668b'::uuid, 'PCAUTH', 'f292c712-26e7-43a5-9aaa-b81bc905f8f9', 'a26dcd1d-a287-43bb-afc9-da75f966f69b', '263e4d5d-cf6c-4e7d-8c35-394a62e46028'::uuid, 'CWSP', 'CWSP', '1842643', 42, 0, 'f292c712-26e7-43a5-9aaa-b81bc905f8f9', '2022-07-14 15:34:44.274', 'f292c712-26e7-43a5-9aaa-b81bc905f8f9', '2022-07-14 15:40:26.587', true, 'Forwarded to Director Approval', NULL, 'Purchase Authorization Forwarded to Director Approval', '3284355', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

DELETE FROM cjams.routing
WHERE routingid in ('5d6af597-a3b6-4c25-93b0-3efecba4b216','8c9aed18-a77b-46ac-b59b-2585fb8922a5','8ccaaffa-0135-450b-ab53-1fc43e93668b');