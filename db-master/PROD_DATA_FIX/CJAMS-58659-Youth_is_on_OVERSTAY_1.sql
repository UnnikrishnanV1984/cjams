/*
   Issue Description: CJAMS-58659
   Category/ Module  : Placement end date
   Root cause: user wants to end date placement 
   Pull request# for code fix: 5410
   Reason why no related code fix: Code fix ticket - CIDM-10219
*/

-- deactivating current 17 record
update routing set activeflag = 0, updatedby ='CJAMS-58659', updatedon = now() where routingid ='e4e85dc3-42e3-48b2-a9da-451acaba8143';

--inserting new approval record with 16 with correct remarks and routeddescription 
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'PLTR', 'abf98747-6de5-4cd9-a5ac-8c0a736dd3e6', '45391f16-58de-4b24-bd7e-12cdc4ff4335', '6629c2a6-9d4d-4d3f-b6c2-0d842f161cc6'::uuid, 'CWSP', 'CWCW', '8c6f2846-1e62-4fc7-9651-e45011d85fd7', 16, 1, 'abf98747-6de5-4cd9-a5ac-8c0a736dd3e6', now(), 'CJAMS-58659', now(), true, '', NULL, 'Child PlacementApproved', '3097011', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


-- inserting new record with 16 for IVESV
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'PLTR', 'abf98747-6de5-4cd9-a5ac-8c0a736dd3e6', NULL, NULL, 'CWSP', 'IVESV', '8c6f2846-1e62-4fc7-9651-e45011d85fd7', 16, 1, 'abf98747-6de5-4cd9-a5ac-8c0a736dd3e6', now(), 'CJAMS-58659', now(), false, NULL, NULL, NULL, '3097011', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
