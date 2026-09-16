/*
   Issue Description: CDM-28748
   Category/ Module  :Routing 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('SCDR', 'cca91e91-1886-46c2-bcc6-76eb9dcfd3f2', 'fcb353c5-30db-4bb7-96fb-cdc67404c643', NULL, 'CWSP', 'CWCW', '7622aee3-e4d7-4c16-a72b-e0a2971e80de', 16, 1, 'cca91e91-1886-46c2-bcc6-76eb9dcfd3f2', now(), 'CDM-28748', now(), false, NULL, '3212177', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
