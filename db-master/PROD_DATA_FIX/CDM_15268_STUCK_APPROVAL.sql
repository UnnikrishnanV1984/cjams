/*
   Issue Description: CDM-15268
   Category/ Module  :  Stuck approval 
   Root cause: user wants to remove the pending approval records
   Pull request# for code fix: 
   
*/

/*
 INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('22dd5c53-048d-43de-97bf-b9f5dcd3bea1'::uuid, 'PCAUTH', 'e3f8e695-0db3-4d62-942c-e50f782dd664', 'd7e29f2c-c055-4000-ad21-fd5ba783525c', '887a9853-369f-4cf5-bde2-908322c0785d'::uuid, 'CWCW', 'CWSP', '1785903', 39, 1, 'e3f8e695-0db3-4d62-942c-e50f782dd664', '2021-07-16 11:51:13.210', 'e3f8e695-0db3-4d62-942c-e50f782dd664', '2021-07-16 11:51:13.210', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '3303793', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('233f1866-ec28-4ddb-811e-0f119774ac7f'::uuid, 'PCAUTHR', 'd7e29f2c-c055-4000-ad21-fd5ba783525c', '194def4d-9603-4b10-87eb-c7242ddaa119', '94195b2e-5043-4293-b60f-8d3c719b8bbe'::uuid, 'CWSP', 'FNSFS', '1785903', 40, 1, 'd7e29f2c-c055-4000-ad21-fd5ba783525c', '2021-07-16 11:53:49.969', 'd7e29f2c-c055-4000-ad21-fd5ba783525c', '2021-07-16 11:53:49.969', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3303793', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('257c79ef-027a-493c-af2d-6a3079b36f76'::uuid, 'PCAUTHR', '194def4d-9603-4b10-87eb-c7242ddaa119', 'adc5892a-0392-4ae8-b74e-d389b4bbcf15', '94195b2e-5043-4293-b60f-8d3c719b8bbe'::uuid, 'FNSFS', 'FNSFS', '1785903', 43, 1, '194def4d-9603-4b10-87eb-c7242ddaa119', '2021-07-16 12:27:49.834', '194def4d-9603-4b10-87eb-c7242ddaa119', '2021-07-16 12:27:49.834', true, 'Approved', NULL, 'Purchase Authorization Forwarded to Payment Approval', NULL, 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('385dd0b2-a416-41cd-9d80-c355d81b2b06'::uuid, 'PCAUTHR', 'd7e29f2c-c055-4000-ad21-fd5ba783525c', NULL, '94195b2e-5043-4293-b60f-8d3c719b8bbe'::uuid, 'CWSP', 'FNSFS', '1785903', 40, 1, 'd7e29f2c-c055-4000-ad21-fd5ba783525c', '2021-07-20 14:23:07.257', 'd7e29f2c-c055-4000-ad21-fd5ba783525c', '2021-07-20 14:23:07.257', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3303793', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('3f7c936c-2cc9-46fa-ba12-6aff053aa0f3'::uuid, 'PCAUTHR', 'd7e29f2c-c055-4000-ad21-fd5ba783525c', NULL, '94195b2e-5043-4293-b60f-8d3c719b8bbe'::uuid, 'CWSP', 'FNSFS', '1785903', 40, 1, 'd7e29f2c-c055-4000-ad21-fd5ba783525c', '2021-07-16 15:09:02.594', 'd7e29f2c-c055-4000-ad21-fd5ba783525c', '2021-07-16 15:09:02.594', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3303793', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('64d60ab0-f47a-4053-9def-8eef4d754ca0'::uuid, 'PCAUTHR', 'd7e29f2c-c055-4000-ad21-fd5ba783525c', '194def4d-9603-4b10-87eb-c7242ddaa119', '94195b2e-5043-4293-b60f-8d3c719b8bbe'::uuid, 'CWSP', 'FNSFS', '1785903', 40, 1, 'd7e29f2c-c055-4000-ad21-fd5ba783525c', '2021-07-16 11:54:39.315', 'd7e29f2c-c055-4000-ad21-fd5ba783525c', '2021-07-16 11:54:39.315', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3303793', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('be4f0a15-2ab3-4556-84d1-c040b8cb3686'::uuid, 'PCAUTHR', 'd7e29f2c-c055-4000-ad21-fd5ba783525c', NULL, '94195b2e-5043-4293-b60f-8d3c719b8bbe'::uuid, 'CWSP', 'FNSFS', '1785903', 40, 1, 'd7e29f2c-c055-4000-ad21-fd5ba783525c', '2021-07-16 12:33:02.250', 'd7e29f2c-c055-4000-ad21-fd5ba783525c', '2021-07-16 12:33:02.250', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3303793', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('d108c101-db1f-4333-b992-13470f135bcf'::uuid, 'PCAUTHR', 'd7e29f2c-c055-4000-ad21-fd5ba783525c', NULL, '94195b2e-5043-4293-b60f-8d3c719b8bbe'::uuid, 'CWSP', 'FNSFS', '1785903', 40, 1, 'd7e29f2c-c055-4000-ad21-fd5ba783525c', '2021-07-28 10:39:52.975', 'd7e29f2c-c055-4000-ad21-fd5ba783525c', '2021-07-28 10:39:52.975', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3303793', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('d7ef4a50-b173-4746-820a-1227481d89e2'::uuid, 'PCAUTHR', 'd7e29f2c-c055-4000-ad21-fd5ba783525c', NULL, '94195b2e-5043-4293-b60f-8d3c719b8bbe'::uuid, 'CWSP', 'FNSFS', '1785903', 40, 1, 'd7e29f2c-c055-4000-ad21-fd5ba783525c', '2021-08-31 13:21:52.400', 'd7e29f2c-c055-4000-ad21-fd5ba783525c', '2021-08-31 13:21:52.400', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3303793', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
 */

 
delete from routing where routingid in ('d7ef4a50-b173-4746-820a-1227481d89e2',
'22dd5c53-048d-43de-97bf-b9f5dcd3bea1', 
'233f1866-ec28-4ddb-811e-0f119774ac7f', 
'64d60ab0-f47a-4053-9def-8eef4d754ca0', 
'257c79ef-027a-493c-af2d-6a3079b36f76',
'd108c101-db1f-4333-b992-13470f135bcf',
'385dd0b2-a416-41cd-9d80-c355d81b2b06',
'3f7c936c-2cc9-46fa-ba12-6aff053aa0f3',
'be4f0a15-2ab3-4556-84d1-c040b8cb3686');

