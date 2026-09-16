/*
   Issue Description: CDM-29828
   Category/ Module  : Service log
   Root cause:  

   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Data fix: Updating activeflag to 0 in the routing table for the servicerequest
*/



delete from routing   
where routingid in ('de29beff-3037-4466-9dd4-8011f77fa6e9',
'9055ef93-5839-4bf2-9641-224bd1b2a1aa',
'125baa82-41b7-465d-9c28-d8ff6083ec1c',
'6823b924-0b16-4b82-824c-a297bfa241fb',
'333db63c-a8db-4b27-bfff-a613a5c76c8b',
'c89d337d-0db6-478c-9428-9941d0a2c6bc',
'57ae377a-e5c2-4494-ac58-863b16244fbd',
'57ef49d0-c2c5-4832-b257-7fb51dc43b87') and objectid='1821224';

/*To revert the data 

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('125baa82-41b7-465d-9c28-d8ff6083ec1c', 'PCAUTHR', '36dadacc-bec3-4157-bc63-6ff67dbd5ae4', NULL, '31eabbb0-f686-41dc-94d3-a3c26b12043a', 'CWSP', 'FNSFW', '1821224', 40, 1, '36dadacc-bec3-4157-bc63-6ff67dbd5ae4', '2022-04-07 14:44:27.820', '36dadacc-bec3-4157-bc63-6ff67dbd5ae4', '2022-04-07 14:44:27.820', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3279102', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('333db63c-a8db-4b27-bfff-a613a5c76c8b', 'PCAUTH', 'df4e91fc-5824-45b0-baae-788cacf3bc79', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '31eabbb0-f686-41dc-94d3-a3c26b12043a', 'FNSFS', 'FNSFS', '1821224', 43, 0, 'df4e91fc-5824-45b0-baae-788cacf3bc79', '2022-03-04 15:41:07.935', 'df4e91fc-5824-45b0-baae-788cacf3bc79', '2022-03-07 12:30:59.435', true, 'Approved', NULL, 'Purchase Authorization Forwarded to Payment Approval', NULL, 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('57ae377a-e5c2-4494-ac58-863b16244fbd', 'PCAUTHR', '36dadacc-bec3-4157-bc63-6ff67dbd5ae4', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '31eabbb0-f686-41dc-94d3-a3c26b12043a', 'CWSP', 'FNSFS', '1821224', 43, 1, '36dadacc-bec3-4157-bc63-6ff67dbd5ae4', '2022-03-03 17:11:50.029', '36dadacc-bec3-4157-bc63-6ff67dbd5ae4', '2022-03-03 17:11:50.029', true, 'Approved', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3279102', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('57ef49d0-c2c5-4832-b257-7fb51dc43b87', 'PCAUTHR', '36dadacc-bec3-4157-bc63-6ff67dbd5ae4', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '31eabbb0-f686-41dc-94d3-a3c26b12043a', 'CWSP', 'FNSFS', '1821224', 43, 1, '36dadacc-bec3-4157-bc63-6ff67dbd5ae4', '2022-03-03 17:09:04.727', '36dadacc-bec3-4157-bc63-6ff67dbd5ae4', '2022-03-03 17:09:04.727', true, 'Approved', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3279102', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('6823b924-0b16-4b82-824c-a297bfa241fb', 'PCAUTHR', '36dadacc-bec3-4157-bc63-6ff67dbd5ae4', NULL, '31eabbb0-f686-41dc-94d3-a3c26b12043a', 'CWSP', 'FNSFS', '1821224', 40, 1, '36dadacc-bec3-4157-bc63-6ff67dbd5ae4', '2022-03-09 12:09:15.839', '36dadacc-bec3-4157-bc63-6ff67dbd5ae4', '2022-03-09 12:09:15.839', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3279102', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('9055ef93-5839-4bf2-9641-224bd1b2a1aa', 'PCAUTHR', '36dadacc-bec3-4157-bc63-6ff67dbd5ae4', NULL, '31eabbb0-f686-41dc-94d3-a3c26b12043a', 'CWSP', 'FNSFS', '1821224', 40, 1, '36dadacc-bec3-4157-bc63-6ff67dbd5ae4', '2022-03-07 12:30:59.435', '36dadacc-bec3-4157-bc63-6ff67dbd5ae4', '2022-03-07 12:30:59.435', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3279102', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('c89d337d-0db6-478c-9428-9941d0a2c6bc', 'PCAUTHR', '36dadacc-bec3-4157-bc63-6ff67dbd5ae4', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '31eabbb0-f686-41dc-94d3-a3c26b12043a', 'CWSP', 'FNSFS', '1821224', 43, 1, '36dadacc-bec3-4157-bc63-6ff67dbd5ae4', '2022-03-03 17:12:46.970', '36dadacc-bec3-4157-bc63-6ff67dbd5ae4', '2022-03-03 17:12:46.970', true, 'Approved', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3279102', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('de29beff-3037-4466-9dd4-8011f77fa6e9', 'PCAUTH', '1e60bdbb-6d9e-430a-9877-3311e0ef0bd1', '36dadacc-bec3-4157-bc63-6ff67dbd5ae4', '70c5f926-488c-44ec-a363-29ab1c8bf749', 'CWSP', 'CWSP', '1821224', 39, 1, '1e60bdbb-6d9e-430a-9877-3311e0ef0bd1', '2022-03-03 11:43:09.762', '1e60bdbb-6d9e-430a-9877-3311e0ef0bd1', '2022-03-03 11:43:09.762', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '3279102', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/