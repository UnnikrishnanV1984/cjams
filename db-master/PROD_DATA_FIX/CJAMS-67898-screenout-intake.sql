/*
   Issue Description: CJAMS-67898
   Category/ Module  : Update Supervisor Decision
   Root cause: Supervisor wants to screenout the intake as user not able to update it and delete review records from submission history
   Fix Provided: Data fx was provided by updating the superviosr decision to screenout as requested by userand deleted review records from submission history
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update 	intakedastaging 
SET 	updatedby = 'CJAMS-67898', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
        jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
        jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
        jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE 	intakenumber = 'I261014033320' and activeflag = 1;


-- INSERT INTO cjams.routing
-- (routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
-- VALUES('1b1fc186-cb75-4548-922d-0cad61def935'::uuid, 'XXXX', 'd6c2ad8f-ab3f-4420-9287-2aab0c338f48', '41d2c97d-a7fd-404d-a659-b34392ddcb21', '3ab65420-fab6-4064-a3b2-c019a76171e4'::uuid, 'CWCW', 'CWSP', 'I261014033320', 1, 0, 'd6c2ad8f-ab3f-4420-9287-2aab0c338f48', '2026-05-15 13:46:14.104', 'd6c2ad8f-ab3f-4420-9287-2aab0c338f48', '2026-05-19 10:11:00.292', true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Scrnin', '', NULL);
-- INSERT INTO cjams.routing
-- (routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
-- VALUES('9b95a443-7d51-4d70-b2a0-89d00b550a42'::uuid, 'XXXX', 'ab22b575-0910-4392-8eb4-d1591ba1beed', '5b2bcf41-0610-4b6c-b62e-250d714750b5', 'b70ab9c8-0cdb-4c71-a0a7-5af7e623d406'::uuid, 'CWIW', 'CWSP', 'I261014033320', 1, 0, 'ab22b575-0910-4392-8eb4-d1591ba1beed', '2026-05-15 16:17:02.994', 'ab22b575-0910-4392-8eb4-d1591ba1beed', '2026-05-19 10:11:00.292', true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Scrnin', '', NULL);
-- INSERT INTO cjams.routing
-- (routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
-- VALUES('57fcf217-b11f-4ca6-8999-c81a9477868f'::uuid, 'XXXX', 'ab22b575-0910-4392-8eb4-d1591ba1beed', 'd86bb458-2309-4182-b155-ae22d36cf9d6', '4f6ea4e7-5eca-48cb-be75-ab8bcb0cc9e5'::uuid, 'CWIW', 'CWSP', 'I261014033320', 1, 0, 'ab22b575-0910-4392-8eb4-d1591ba1beed', '2026-05-15 16:26:35.626', 'ab22b575-0910-4392-8eb4-d1591ba1beed', '2026-05-19 10:11:00.292', true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Scrnin', '', NULL);
-- INSERT INTO cjams.routing
-- (routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
-- VALUES('97ba2e44-9d07-48d1-894b-a3cf6508b035'::uuid, 'XXXX', 'a28308ae-8989-4f66-b47c-f26db59c1118', 'b3b22c73-2132-4a64-bfff-7f353dea75a1', 'd9d7a2e7-e4ce-4eb7-a2d9-aefc0c8a390b'::uuid, 'CWIW', 'CWSP', 'I261014033320', 1, 0, 'a28308ae-8989-4f66-b47c-f26db59c1118', '2026-05-15 16:49:38.906', 'a28308ae-8989-4f66-b47c-f26db59c1118', '2026-05-19 10:11:00.292', true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Scrnin', '', NULL);
-- INSERT INTO cjams.routing
-- (routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
-- VALUES('3bee5895-5c04-452e-ba04-63454a7df5cd'::uuid, 'XXXX', 'd6c2ad8f-ab3f-4420-9287-2aab0c338f48', 'd86bb458-2309-4182-b155-ae22d36cf9d6', '4f6ea4e7-5eca-48cb-be75-ab8bcb0cc9e5'::uuid, 'CWIW', 'CWSP', 'I261014033320', 1, 0, 'd6c2ad8f-ab3f-4420-9287-2aab0c338f48', '2026-05-15 12:46:59.658', 'd6c2ad8f-ab3f-4420-9287-2aab0c338f48', '2026-05-19 10:11:00.292', true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ScreenOUT', '', NULL);
-- INSERT INTO cjams.routing
-- (routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
-- VALUES('9d0b3b09-d5e8-4a90-8a53-80acdd8d714e'::uuid, 'XXXX', 'b3b22c73-2132-4a64-bfff-7f353dea75a1', 'a28308ae-8989-4f66-b47c-f26db59c1118', 'd9d7a2e7-e4ce-4eb7-a2d9-aefc0c8a390b'::uuid, 'CWIW', 'CWSP', 'I261014033320', 1, 0, 'b3b22c73-2132-4a64-bfff-7f353dea75a1', '2026-05-15 16:54:48.692', 'b3b22c73-2132-4a64-bfff-7f353dea75a1', '2026-05-19 10:11:00.292', true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Scrnin', '', NULL);
-- INSERT INTO cjams.routing
-- (routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
-- VALUES('c5502914-6ee9-4978-bbea-94fe4c514682', 'INTR', 'a28308ae-8989-4f66-b47c-f26db59c1118', 'b3b22c73-2132-4a64-bfff-7f353dea75a1', 'd9d7a2e7-e4ce-4eb7-a2d9-aefc0c8a390b', 'CWCW', 'CWSP', 'I261014033320', 1, 1, 'a28308ae-8989-4f66-b47c-f26db59c1118', '2026-05-19 10:11:00.292', 'a28308ae-8989-4f66-b47c-f26db59c1118', '2026-05-19 10:11:00.292', true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Scrnin', '', NULL);
-- INSERT INTO cjams.routing
-- (routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
-- VALUES('9bb8ccde-aa38-492e-8156-0cb152acc5d3'::uuid, 'XXXX', 'ab22b575-0910-4392-8eb4-d1591ba1beed', '5b2bcf41-0610-4b6c-b62e-250d714750b5', 'b70ab9c8-0cdb-4c71-a0a7-5af7e623d406'::uuid, 'CWIW', 'CWSP', 'I261014033320', 1, 0, 'ab22b575-0910-4392-8eb4-d1591ba1beed', '2026-05-15 15:30:56.320', 'ab22b575-0910-4392-8eb4-d1591ba1beed', '2026-05-19 10:11:00.292', true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Scrnin', '', NULL);


DELETE FROM cjams.routing
WHERE routingid='1b1fc186-cb75-4548-922d-0cad61def935'::uuid;
DELETE FROM cjams.routing
WHERE routingid='9b95a443-7d51-4d70-b2a0-89d00b550a42'::uuid;
DELETE FROM cjams.routing
WHERE routingid='57fcf217-b11f-4ca6-8999-c81a9477868f'::uuid;
DELETE FROM cjams.routing
WHERE routingid='97ba2e44-9d07-48d1-894b-a3cf6508b035'::uuid;
DELETE FROM cjams.routing
WHERE routingid='3bee5895-5c04-452e-ba04-63454a7df5cd'::uuid;
DELETE FROM cjams.routing
WHERE routingid='9d0b3b09-d5e8-4a90-8a53-80acdd8d714e'::uuid;
DELETE FROM cjams.routing
WHERE routingid='c5502914-6ee9-4978-bbea-94fe4c514682'::uuid;
DELETE FROM cjams.routing
WHERE routingid='9bb8ccde-aa38-492e-8156-0cb152acc5d3'::uuid;
