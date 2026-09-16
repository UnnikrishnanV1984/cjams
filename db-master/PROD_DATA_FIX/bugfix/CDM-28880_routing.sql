/*
   Issue Description: CDM-28880
   Category/ Module  :Routing 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('SCDR', '5615a929-114a-4ab1-9df5-3ce61bb661e4', 'c27174f0-6cd7-4aa9-b7b6-6c53831e6f39', NULL, 'CWSP', 'CWCW', 'a62a073c-4e51-41f2-8481-993cee3b6481', 16, 1, '5615a929-114a-4ab1-9df5-3ce61bb661e4', now(), 'CDM-28880', now(), false, NULL, '3299311', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
