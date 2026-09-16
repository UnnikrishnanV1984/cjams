/*
-- CDM-21443 - 

-- Issue Description: 
 Delete Purchase Authorizations
  
-- Customer Email ID: tara.feldman@maryland.gov

-- Root cause: Data fix to delete purchase authorizations
-- Pull request#: N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select * from routing where objectid in ('1822687')
/*
 *
 * INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('3af7e40f-9cf1-46fa-b389-1b1cd1448618'::uuid, 'PCAUTHR', '33c6c8d1-e0b7-4227-99bf-6668db2f655e', NULL, '38cdec8a-7d34-4c43-9c04-bc0fcb644c6c'::uuid, 'CWSP', 'FNSFS', '1822687', 40, 1, '33c6c8d1-e0b7-4227-99bf-6668db2f655e', '2022-03-11 17:05:45.989', '33c6c8d1-e0b7-4227-99bf-6668db2f655e', '2022-03-11 17:05:45.989', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3296624', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('823c4420-b313-4850-b1cd-69924b41f7ad'::uuid, 'PCAUTHR', '33c6c8d1-e0b7-4227-99bf-6668db2f655e', NULL, '38cdec8a-7d34-4c43-9c04-bc0fcb644c6c'::uuid, 'CWSP', 'FNSFS', '1822687', 40, 1, '33c6c8d1-e0b7-4227-99bf-6668db2f655e', '2022-03-11 17:06:27.203', '33c6c8d1-e0b7-4227-99bf-6668db2f655e', '2022-03-11 17:06:27.203', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3296624', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('e8ff8c84-ddb0-4bd4-8eaa-09e637698071'::uuid, 'PCAUTH', '9667a3a4-5344-4a05-86e0-8b304d9f49f9', '33c6c8d1-e0b7-4227-99bf-6668db2f655e', 'a2311121-a429-497b-91ad-18fdc1574819'::uuid, 'CWCW', 'CWSP', '1822687', 39, 1, '9667a3a4-5344-4a05-86e0-8b304d9f49f9', '2022-03-10 13:46:50.359', '9667a3a4-5344-4a05-86e0-8b304d9f49f9', '2022-03-10 13:46:50.359', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '3296624', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

 *
 *
 */


DELETE FROM cjams.routing
WHERE routingid='e8ff8c84-ddb0-4bd4-8eaa-09e637698071'::uuid;
DELETE FROM cjams.routing
WHERE routingid='3af7e40f-9cf1-46fa-b389-1b1cd1448618'::uuid;


select * from routing where objectid in ('1818221')


/*
 * INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('c717cd39-4582-4583-9ab9-5d773dd9a396'::uuid, 'PCAUTHR', '33c6c8d1-e0b7-4227-99bf-6668db2f655e', NULL, '38cdec8a-7d34-4c43-9c04-bc0fcb644c6c'::uuid, 'CWSP', 'FNSFS', '1818221', 40, 1, '33c6c8d1-e0b7-4227-99bf-6668db2f655e', '2022-02-11 11:11:47.439', '33c6c8d1-e0b7-4227-99bf-6668db2f655e', '2022-02-11 11:11:47.439', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3296624', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('0a8f6ae7-c48d-4231-bd59-c7df862b7ada'::uuid, 'PCAUTHR', '33c6c8d1-e0b7-4227-99bf-6668db2f655e', NULL, '38cdec8a-7d34-4c43-9c04-bc0fcb644c6c'::uuid, 'CWSP', 'FNSFS', '1818221', 40, 1, '33c6c8d1-e0b7-4227-99bf-6668db2f655e', '2022-02-15 15:50:51.247', '33c6c8d1-e0b7-4227-99bf-6668db2f655e', '2022-02-15 15:50:51.247', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3296624', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('ba4d824e-e732-4fbd-ab21-97ae63e08a78'::uuid, 'PCAUTHR', '33c6c8d1-e0b7-4227-99bf-6668db2f655e', NULL, '38cdec8a-7d34-4c43-9c04-bc0fcb644c6c'::uuid, 'CWSP', 'FNSFS', '1818221', 40, 1, '33c6c8d1-e0b7-4227-99bf-6668db2f655e', '2022-02-24 14:10:02.981', '33c6c8d1-e0b7-4227-99bf-6668db2f655e', '2022-02-24 14:10:02.981', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3296624', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('a97a53a8-e18a-4d3f-933b-cc9a396e700d'::uuid, 'PCAUTH', '9667a3a4-5344-4a05-86e0-8b304d9f49f9', '33c6c8d1-e0b7-4227-99bf-6668db2f655e', 'a2311121-a429-497b-91ad-18fdc1574819'::uuid, 'CWCW', 'CWSP', '1818221', 39, 1, '9667a3a4-5344-4a05-86e0-8b304d9f49f9', '2022-02-09 13:10:40.291', '9667a3a4-5344-4a05-86e0-8b304d9f49f9', '2022-02-09 13:10:40.291', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '3296624', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

 *
 *
 */


DELETE FROM cjams.routing
WHERE routingid='0a8f6ae7-c48d-4231-bd59-c7df862b7ada'::uuid;
DELETE FROM cjams.routing
WHERE routingid='ba4d824e-e732-4fbd-ab21-97ae63e08a78'::uuid;
DELETE FROM cjams.routing
WHERE routingid='c717cd39-4582-4583-9ab9-5d773dd9a396'::uuid;
DELETE FROM cjams.routing
WHERE routingid='a97a53a8-e18a-4d3f-933b-cc9a396e700d'::uuid;