/*
   Issue Description: CDM-28887
   Category/ Module  :Routing 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('SCDR', 'f156b6d0-67af-404f-bf79-d4fbd737716c', 'ed0e73cd-e7e3-45a0-986e-f978150ea860', NULL, 'CWSP', 'CWCW', 'd3eb259f-3eb9-4eb2-ae90-cc7c934d71da', 16, 1, 'f156b6d0-67af-404f-bf79-d4fbd737716c', now(), 'CDM-28887', now(), false, NULL, '3256095', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
