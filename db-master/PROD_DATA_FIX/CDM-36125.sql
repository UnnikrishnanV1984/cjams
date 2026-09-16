--CDM-36125
-- Root cause: Data issue (Routing table is having  record)
-- Fix Provided: Datafix has been promoted to fix the routing data.	

/*
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('2bd574f4-72cb-440c-9fb9-117faa4e7279', 'PCAUTH', '45391f16-58de-4b24-bd7e-12cdc4ff4335', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '6629c2a6-9d4d-4d3f-b6c2-0d842f161cc6', 'CWSP', 'CWSP', '2558078', 39, 1, '45391f16-58de-4b24-bd7e-12cdc4ff4335', '2023-12-20 14:17:25.772', '45391f16-58de-4b24-bd7e-12cdc4ff4335', '2023-12-20 14:17:25.772', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '3121145', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/

delete from cjams.routing where  routingid='2bd574f4-72cb-440c-9fb9-117faa4e7279';

--39
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('b893edd5-d910-4ec1-91b8-78a228d04105', 'PCAUTH', '45391f16-58de-4b24-bd7e-12cdc4ff4335', 'd636ac2f-53ff-43e0-adbf-35c97e0427ec', '6629c2a6-9d4d-4d3f-b6c2-0d842f161cc6', 'CWSP', 'CWSP', '2558078', 39, 0, '45391f16-58de-4b24-bd7e-12cdc4ff4335', '2023-09-22 09:53:17.179', '45391f16-58de-4b24-bd7e-12cdc4ff4335', '2023-09-22 11:05:26.883', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '3121145', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

--44
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('1101b2d6-8a6e-44fc-bd7f-4421ab4d19a6', 'PCAUTHR', 'd636ac2f-53ff-43e0-adbf-35c97e0427ec', '32414234-1c88-4bfd-b94e-7816d0003453', '31eabbb0-f686-41dc-94d3-a3c26b12043a', 'CWSP', 'FNSFS', '2558078', 44, 0, 'd636ac2f-53ff-43e0-adbf-35c97e0427ec', '2023-09-25 11:21:04.000', 'ba2dbc8f-3213-4b1b-9905-d643e1692db1', '2023-09-25 15:38:44.535', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3121145', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


