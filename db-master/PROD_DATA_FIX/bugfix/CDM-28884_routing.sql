/*
   Issue Description: CDM-28884
   Category/ Module  :Routing 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('SCDR', '3b624981-6029-4eba-ba75-e6b3f5377333', '8d4df684-6912-4312-b929-06355ca7213f', NULL, 'CWSP', 'CWCW', '7cb7b459-28ef-4d02-b495-9e231aa79bbf', 16, 1, '3b624981-6029-4eba-ba75-e6b3f5377333', now(), 'CDM-28884', now(), false, NULL, '3144654', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
