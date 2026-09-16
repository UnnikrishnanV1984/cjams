/*
   Issue Description: CDM-28877
   Category/ Module  :Routing 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('SCDR', 'e4bcec66-b8ef-476f-915c-375f6c71a5d1', '8d4df684-6912-4312-b929-06355ca7213f', NULL, 'CWSP', 'CWCW', '94e8890a-ae8b-42c2-8d72-b29544624596', 16, 1, 'e4bcec66-b8ef-476f-915c-375f6c71a5d1', now(), 'CDM-28877', now(), false, NULL, '3211506', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
