/*
   Issue Description: CDM-31211
   Category/ Module  :Routing 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('SCDR', '027ec556-25bb-41a2-8058-ead774a387a5', '027ec556-25bb-41a2-8058-ead774a387a5', NULL, 'CWSP', 'CWCW', '26a1b117-d41b-48dd-bd7e-34d7d5a52960', 16, 1, '027ec556-25bb-41a2-8058-ead774a387a5', now(), 'CDM-31211', now(), false, NULL, null, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);