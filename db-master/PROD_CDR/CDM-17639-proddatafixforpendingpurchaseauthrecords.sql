
/*
   Issue Description: CDM-17639
   Category/ Module  :  Removing purchase pending records
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- INSERT INTO cjams.routing
-- (routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
-- VALUES('19c3faeb-7b64-403c-8526-3260e008b8c7'::uuid, 'PCAUTHR', 'dfdc212e-0829-4b69-beae-72e34226bb03', NULL, '38cdec8a-7d34-4c43-9c04-bc0fcb644c6c'::uuid, 'CWSP', 'FNSFS', '1800065', 40, 1, 'dfdc212e-0829-4b69-beae-72e34226bb03', '2021-10-19 11:10:53.718', 'dfdc212e-0829-4b69-beae-72e34226bb03', '2021-10-19 11:10:53.718', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3174148', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
-- INSERT INTO cjams.routing
-- (routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
-- VALUES('5a0a3b98-9a9b-431c-b431-adde5b74a3a6'::uuid, 'PCAUTHR', 'dfdc212e-0829-4b69-beae-72e34226bb03', NULL, '38cdec8a-7d34-4c43-9c04-bc0fcb644c6c'::uuid, 'CWSP', 'FNSFS', '1800065', 40, 1, 'dfdc212e-0829-4b69-beae-72e34226bb03', '2021-10-19 11:05:54.827', 'dfdc212e-0829-4b69-beae-72e34226bb03', '2021-10-19 11:05:54.827', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3174148', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
-- INSERT INTO cjams.routing
-- (routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
-- VALUES('12d512b2-0a4f-468d-859e-f3b50bdfe90c'::uuid, 'PCAUTH', '0858c7a9-77e1-4d6c-850b-9fe77259dbf7', 'dfdc212e-0829-4b69-beae-72e34226bb03', '40311c96-8b26-4585-9785-1be6f84c3c04'::uuid, 'CWCW', 'CWSP', '1800065', 39, 1, '0858c7a9-77e1-4d6c-850b-9fe77259dbf7', '2021-10-19 10:30:25.935', '0858c7a9-77e1-4d6c-850b-9fe77259dbf7', '2021-10-19 10:30:25.935', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '3174148', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);



delete routing where routingid in  ('12d512b2-0a4f-468d-859e-f3b50bdfe90c','19c3faeb-7b64-403c-8526-3260e008b8c7'
,'5a0a3b98-9a9b-431c-b431-adde5b74a3a6');