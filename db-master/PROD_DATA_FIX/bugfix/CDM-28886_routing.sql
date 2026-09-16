/*
   Issue Description: CDM-28886
   Category/ Module  :Routing 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('SCDR', '1d4436d9-cf29-4ffe-b792-8d9f2433d3dc', '272442f3-43b9-4734-be56-d138e1e7c2f0', NULL, 'CWSP', 'CWCW', 'c59e6b2b-4b86-43ea-a750-dcffe7551ad0', 16, 1, '1d4436d9-cf29-4ffe-b792-8d9f2433d3dc', now(), 'CDM-28886', now(), false, NULL, '3192462', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
