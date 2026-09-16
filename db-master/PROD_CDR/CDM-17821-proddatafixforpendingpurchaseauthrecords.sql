
/*
   Issue Description: CDM-17821
   Category/ Module  :  Removing purchase pending records
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


--INSERT INTO cjams.routing
--(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
--VALUES('7bbada20-c8c0-49f3-8be6-7d0d8c5c0043'::uuid, 'PCAUTHR', 'cca91e91-1886-46c2-bcc6-76eb9dcfd3f2', NULL, 'abf11605-707e-457d-9f07-6a31abca13d7'::uuid, 'CWSP', 'FNSFS', '1800154', 40, 1, 'cca91e91-1886-46c2-bcc6-76eb9dcfd3f2', '2021-10-22 10:04:11.798', 'cca91e91-1886-46c2-bcc6-76eb9dcfd3f2', '2021-10-22 10:04:11.798', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3304052', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
--INSERT INTO cjams.routing
--(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
--VALUES('8b74db34-00be-42c3-9d2b-8836599a9ffd'::uuid, 'PCAUTHR', 'cca91e91-1886-46c2-bcc6-76eb9dcfd3f2', NULL, 'abf11605-707e-457d-9f07-6a31abca13d7'::uuid, 'CWSP', 'FNSFS', '1800154', 40, 1, 'cca91e91-1886-46c2-bcc6-76eb9dcfd3f2', '2021-10-22 10:03:22.411', 'cca91e91-1886-46c2-bcc6-76eb9dcfd3f2', '2021-10-22 10:03:22.411', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3304052', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
--INSERT INTO cjams.routing
--(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
--VALUES('e7c54181-e7b4-4f27-86f8-78db1e792395'::uuid, 'PCAUTH', 'fcb353c5-30db-4bb7-96fb-cdc67404c643', 'cca91e91-1886-46c2-bcc6-76eb9dcfd3f2', 'c9b3e450-39fc-4f06-941f-3fc8d89f8ce3'::uuid, 'CWCW', 'CWSP', '1800154', 39, 1, 'fcb353c5-30db-4bb7-96fb-cdc67404c643', '2021-10-19 14:31:24.386', 'fcb353c5-30db-4bb7-96fb-cdc67404c643', '2021-10-19 14:31:24.386', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '3304052', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


delete routing where routingid in ('7bbada20-c8c0-49f3-8be6-7d0d8c5c0043','8b74db34-00be-42c3-9d2b-8836599a9ffd','e7c54181-e7b4-4f27-86f8-78db1e792395');