/*
   Issue Description: CDM-28885
   Category/ Module  :Routing 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('SCDR', '6f547db3-ae7c-4c01-9499-4e4bba47a64c', 'f3921204-e9e0-481d-9261-9e626eaa0dd6', NULL, 'CWSP', 'CWCW', 'd1d56f0c-9634-440f-b9a4-c28ab12db2d0', 16, 1, '6f547db3-ae7c-4c01-9499-4e4bba47a64c', now(), 'CDM-28885', now(), false, NULL, '3305684', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
