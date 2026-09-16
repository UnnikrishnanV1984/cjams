
	/*
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('6cff6b90-92dd-490d-8a74-2cc377ff6565', 'PCAUTH', '9667a3a4-5344-4a05-86e0-8b304d9f49f9', '33c6c8d1-e0b7-4227-99bf-6668db2f655e', 'a2311121-a429-497b-91ad-18fdc1574819', 'CWCW', 'CWSP', '1831005', 39, 1, '9667a3a4-5344-4a05-86e0-8b304d9f49f9', '2022-05-04 15:44:11.334', '9667a3a4-5344-4a05-86e0-8b304d9f49f9', '2022-05-04 15:44:11.334', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '221030013946', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/

delete from routing where routingid = '6cff6b90-92dd-490d-8a74-2cc377ff6565';