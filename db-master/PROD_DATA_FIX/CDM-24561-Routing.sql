/*
   Issue Description: CDM-24561
   Category/ Module  : Approved Inbox 
   Root cause: 
   Pull request# for code fix: 4235
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update cjams.routing set activeflag =0, updatedby='CDM-24561', updatedon=now()
where routingid ='d6b6fdde-841e-43bc-bc68-e87eb3b74bd6';


INSERT INTO cjams.routing (routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes) 
VALUES('506c91f2-0985-45ae-9536-b05fd6481d03'::uuid, 'GADR', 'ebb0f319-fdda-4ed3-bd27-3ba9ba2ea5a0', '362086ed-9366-451c-b7c1-b623d6de193b', 'daf6ac19-05d9-4df9-959a-3dc7913fffbd'::uuid, 'CWSP', 'CWSP', '821893c2-8a43-42f3-a4cb-340542195588', 16, 1, 'ebb0f319-fdda-4ed3-bd27-3ba9ba2ea5a0', now(), 'CDM-24561', now(), false, '', NULL, '', '2020030203867', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

