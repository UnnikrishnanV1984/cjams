/*
   Issue Description: CDM-29932
   Category/ Module  : approval screen 
   Root cause: user requeseted to remove pending  apporval 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



update routing set activeflag = 0 ,updatedby ='CDM-29932', updatedon = now() where routingid = 'a206c46f-7982-4324-b3a2-3148b9f9c2c7';

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES(cjams.gen_random_uuid(), 'CPLAN2', '7cf77857-7a72-4b32-999d-fd0eacf88f37', '056865a7-2a58-494e-9993-ccc6fd9aae58', '6629c2a6-9d4d-4d3f-b6c2-0d842f161cc6', 'CWSP', 'CWSP', 'f02b810e-2fa6-4728-a383-efa66c03e668', 16, 1, 'CDM-29932', now(), 'CDM-29932', now(), false, NULL, NULL, NULL, '211030008184', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
