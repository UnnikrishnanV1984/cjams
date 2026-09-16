
/*
   Issue Description: CDM-21407
   Category/ Module  : Removing PCAUTH Records for case 211030012066
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

/*
 * 
 * 
 * INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('00619352-4df4-47a0-a502-c84b8491b08e'::uuid, 'PCAUTH', '9b9ecf80-d190-49e7-a06e-17674ef909e8', 'b60589bc-8886-40ef-a876-a5273ee42597', '77658fe0-e2f4-41d1-af4a-90ab3cb17ac8'::uuid, 'CWCW', 'CWSP', '1821355', 39, 1, '9b9ecf80-d190-49e7-a06e-17674ef909e8', '2022-03-03 15:49:42.749', '9b9ecf80-d190-49e7-a06e-17674ef909e8', '2022-03-03 15:49:42.749', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '211030012066', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
 * * INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('bf199734-704a-43a2-a760-9dddb5f77432'::uuid, 'PCAUTH', '9b9ecf80-d190-49e7-a06e-17674ef909e8', 'b60589bc-8886-40ef-a876-a5273ee42597', '77658fe0-e2f4-41d1-af4a-90ab3cb17ac8'::uuid, 'CWCW', 'CWSP', '1816704', 39, 1, '9b9ecf80-d190-49e7-a06e-17674ef909e8', '2022-02-01 11:26:12.333', '9b9ecf80-d190-49e7-a06e-17674ef909e8', '2022-02-01 11:26:12.333', true, 'Forwarded to Case Supervisor', NULL, 'Purchase Authorization Forwarded to Case Supervisor', '211030012066', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

 */

DELETE FROM cjams.routing
WHERE routingid='00619352-4df4-47a0-a502-c84b8491b08e'::uuid;
DELETE FROM cjams.routing
WHERE routingid='bf199734-704a-43a2-a760-9dddb5f77432'::uuid;
