/*
   Issue Description: CDM-10299 --Purchase Auth showing as pending
   Category/ Module  :  servicelog
   Root cause: Unable to reproduce it. Asked QA team to reproduce this.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup: Backup before deletion.
  
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('0ccfcbc2-0c1e-405a-9373-343494bd65b2', 'PCAUTHR', 'fbd90a98-e840-4c32-8fd9-55f94384da21', '6ad7ee88-8ef9-498e-9e71-8909c215614b', '5e18b80e-2526-4d14-a2aa-f23a853ceaa8', 'CWSP', 'FNSFW', '1761697', 40, 1, 'fbd90a98-e840-4c32-8fd9-55f94384da21', '2021-02-08 10:21:22.469', 'fbd90a98-e840-4c32-8fd9-55f94384da21', '2021-02-08 10:21:22.469', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '202103305723', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('95596baa-c8f6-46fc-b375-4e49a9d352ef', 'PCAUTHR', '6ad7ee88-8ef9-498e-9e71-8909c215614b', '622c14e1-2208-4575-b260-d75b8b11d3e5', '5e18b80e-2526-4d14-a2aa-f23a853ceaa8', 'FNSFW', 'FNSFS', '1761697', 43, 1, '6ad7ee88-8ef9-498e-9e71-8909c215614b', '2021-02-09 09:21:52.131', '6ad7ee88-8ef9-498e-9e71-8909c215614b', '2021-02-09 09:21:52.131', true, 'Approved', NULL, 'Purchase Authorization Forwarded to Payment Approval', NULL, 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('8fe61e70-9629-4086-8466-ee3eac0fa93e', 'PCAUTHR', '6ad7ee88-8ef9-498e-9e71-8909c215614b', '622c14e1-2208-4575-b260-d75b8b11d3e5', '5e18b80e-2526-4d14-a2aa-f23a853ceaa8', 'FNSFW', 'FNSFS', '1761697', 43, 1, '6ad7ee88-8ef9-498e-9e71-8909c215614b', '2021-02-08 10:36:02.475', '6ad7ee88-8ef9-498e-9e71-8909c215614b', '2021-02-08 10:36:02.475', true, 'Approved', NULL, 'Purchase Authorization Forwarded to Payment Approval', NULL, 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('dbaa4aaa-154f-42ff-8094-b26051617018', 'PCAUTHR', '6ad7ee88-8ef9-498e-9e71-8909c215614b', '622c14e1-2208-4575-b260-d75b8b11d3e5', '5e18b80e-2526-4d14-a2aa-f23a853ceaa8', 'FNSFW', 'FNSFS', '1761697', 43, 1, '6ad7ee88-8ef9-498e-9e71-8909c215614b', '2021-02-08 10:35:32.076', '6ad7ee88-8ef9-498e-9e71-8909c215614b', '2021-02-08 10:35:32.076', true, 'Approved', NULL, 'Purchase Authorization Forwarded to Payment Approval', NULL, 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/
delete from routing where objectid=1761697 and 
routingid in ('0ccfcbc2-0c1e-405a-9373-343494bd65b2',
'95596baa-c8f6-46fc-b375-4e49a9d352ef',
'8fe61e70-9629-4086-8466-ee3eac0fa93e',
'dbaa4aaa-154f-42ff-8094-b26051617018');