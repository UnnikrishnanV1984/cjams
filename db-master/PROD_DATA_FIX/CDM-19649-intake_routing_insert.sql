

/*
   Issue Description: CDM-19649
   Category/ Module  : Intake summary report
   Root cause:  User unable to see the case worker submission history
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

  
INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('XXXX', '7307d54b-5b85-433a-87d2-131972531ac6', 'cf1efb9e-4629-4858-b57d-282bca838560', 'c0b2059f-cd5c-49c5-a15d-a6c17a153788'::uuid, 'CWIW', 'CWSP', 'I211010217523', 1, 0, '7307d54b-5b85-433a-87d2-131972531ac6', '2021-12-01 10:58:12.001', 'CDM-19649', now(), true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('XXXX', '7307d54b-5b85-433a-87d2-131972531ac6', 'cf1efb9e-4629-4858-b57d-282bca838560', 'c0b2059f-cd5c-49c5-a15d-a6c17a153788'::uuid, 'CWIW', 'CWSP', 'I211010219750', 1, 0, '7307d54b-5b85-433a-87d2-131972531ac6', '2021-12-06 17:05:00.066', 'CDM-19649', now(), true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
