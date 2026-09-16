/*
   Issue Description: CDM-21444
   Category/ Module  : purchase auth won't go away
   Root cause: Case shows pending in approval box
   Pull request# for code fix:  N/A
   Reason why no related code fix:  N/A
   Status of the code fix if already submitted and expected prod fix date: 

   select * from tb_service_purchase_authorization where authorization_id=1822687;
   select * from routing where objectid=1822687 order by insertedon desc ;
   
   INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('3af7e40f-9cf1-46fa-b389-1b1cd1448618'::uuid, 'PCAUTHR', '33c6c8d1-e0b7-4227-99bf-6668db2f655e', NULL, '38cdec8a-7d34-4c43-9c04-bc0fcb644c6c'::uuid, 'CWSP', 'FNSFS', '1822687', 40, 1, '33c6c8d1-e0b7-4227-99bf-6668db2f655e', '2022-03-11 17:05:45.989', '33c6c8d1-e0b7-4227-99bf-6668db2f655e', '2022-03-11 17:05:45.989', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3296624', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('e8ff8c84-ddb0-4bd4-8eaa-09e637698071'::uuid, 'PCAUTH', '9667a3a4-5344-4a05-86e0-8b304d9f49f9', '33c6c8d1-e0b7-4227-99bf-6668db2f655e', 'a2311121-a429-497b-91ad-18fdc1574819'::uuid, 'CWCW', 'CWSP', '1822687', 39, 1, '9667a3a4-5344-4a05-86e0-8b304d9f49f9', '2022-03-10 13:46:50.359', '9667a3a4-5344-4a05-86e0-8b304d9f49f9', '2022-03-10 13:46:50.359', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '3296624', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
   
*/

DELETE FROM cjams.routing 
where objectid = '1822687' 
and routingid in 
('3af7e40f-9cf1-46fa-b389-1b1cd1448618',
'e8ff8c84-ddb0-4bd4-8eaa-09e637698071');
