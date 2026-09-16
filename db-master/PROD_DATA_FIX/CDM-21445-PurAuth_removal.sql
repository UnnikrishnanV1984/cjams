/*
   Issue Description: CDM-21445
   Category/ Module  : purchase auth won't go away
   Root cause: Case shows pending in approval box
   Pull request# for code fix:  N/A
   Reason why no related code fix:  N/A
   Status of the code fix if already submitted and expected prod fix date: 

   select * from tb_service_purchase_authorization where authorization_id=1821160;
   select * from routing where objectid=1821160 order by insertedon desc ;
   
   INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('b2a6dd51-4440-448f-b36b-e97c6d17400d'::uuid, 'PCAUTHR', '33c6c8d1-e0b7-4227-99bf-6668db2f655e', '474229ae-a4d6-4857-8c68-569349ec9552', '38cdec8a-7d34-4c43-9c04-bc0fcb644c6c'::uuid, 'CWSP', 'FNSFS', '1821160', 43, 1, '33c6c8d1-e0b7-4227-99bf-6668db2f655e', '2022-03-04 08:46:06.465', '33c6c8d1-e0b7-4227-99bf-6668db2f655e', '2022-03-04 08:46:06.465', true, 'Approved', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3198903', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('54ffaa08-1300-45e6-9117-21722d6a84fb'::uuid, 'PCAUTHR', '33c6c8d1-e0b7-4227-99bf-6668db2f655e', '474229ae-a4d6-4857-8c68-569349ec9552', '38cdec8a-7d34-4c43-9c04-bc0fcb644c6c'::uuid, 'CWSP', 'FNSFS', '1821160', 43, 1, '33c6c8d1-e0b7-4227-99bf-6668db2f655e', '2022-03-08 09:40:43.845', '33c6c8d1-e0b7-4227-99bf-6668db2f655e', '2022-03-08 09:40:43.845', true, 'Approved', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3198903', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('b4f874b5-bf9e-48ec-8101-1abfc5a85606'::uuid, 'PCAUTHR', '33c6c8d1-e0b7-4227-99bf-6668db2f655e', '474229ae-a4d6-4857-8c68-569349ec9552', '38cdec8a-7d34-4c43-9c04-bc0fcb644c6c'::uuid, 'CWSP', 'FNSFS', '1821160', 43, 1, '33c6c8d1-e0b7-4227-99bf-6668db2f655e', '2022-03-08 09:42:39.040', '33c6c8d1-e0b7-4227-99bf-6668db2f655e', '2022-03-08 09:42:39.040', true, 'Approved', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3198903', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('db2ba15c-ed8b-4afc-82c9-493582c57c7b'::uuid, 'PCAUTHR', '33c6c8d1-e0b7-4227-99bf-6668db2f655e', '474229ae-a4d6-4857-8c68-569349ec9552', '38cdec8a-7d34-4c43-9c04-bc0fcb644c6c'::uuid, 'CWSP', 'FNSFS', '1821160', 43, 1, '33c6c8d1-e0b7-4227-99bf-6668db2f655e', '2022-03-08 09:44:00.413', '33c6c8d1-e0b7-4227-99bf-6668db2f655e', '2022-03-08 09:44:00.413', true, 'Approved', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3198903', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('3b5a05cc-ca88-45d5-b228-488c9076eb5c'::uuid, 'PCAUTH', '888cf446-3d17-4366-9b51-85449317f2e6', '33c6c8d1-e0b7-4227-99bf-6668db2f655e', 'a2311121-a429-497b-91ad-18fdc1574819'::uuid, 'CWCW', 'CWSP', '1821160', 39, 1, '888cf446-3d17-4366-9b51-85449317f2e6', '2022-03-03 09:11:00.226', '888cf446-3d17-4366-9b51-85449317f2e6', '2022-03-03 09:11:00.226', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '3198903', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('a56fa642-2f04-4802-9466-22912ad632a9'::uuid, 'PCAUTHR', '33c6c8d1-e0b7-4227-99bf-6668db2f655e', '474229ae-a4d6-4857-8c68-569349ec9552', '38cdec8a-7d34-4c43-9c04-bc0fcb644c6c'::uuid, 'CWSP', 'FNSFS', '1821160', 43, 1, '33c6c8d1-e0b7-4227-99bf-6668db2f655e', '2022-03-04 08:41:47.511', '33c6c8d1-e0b7-4227-99bf-6668db2f655e', '2022-03-04 08:41:47.511', true, 'Approved', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3198903', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

   
*/

DELETE FROM cjams.routing 
 where objectid = '1821160' 
and routingid  in 
('3b5a05cc-ca88-45d5-b228-488c9076eb5c',
'db2ba15c-ed8b-4afc-82c9-493582c57c7b',
'b4f874b5-bf9e-48ec-8101-1abfc5a85606',
'54ffaa08-1300-45e6-9117-21722d6a84fb',
'b2a6dd51-4440-448f-b36b-e97c6d17400d',
'a56fa642-2f04-4802-9466-22912ad632a9');
