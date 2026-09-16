/*
   Issue Description: CJAMS-63135
   Category/ Module  : Intake
   Root cause: User requested to data fix to displayed the closure record in the Decision tab
   Fix provided: Data fix to displayed the closure record in the Decision tab
   Pull request#
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
 Need to do data fix
*/

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES (gen_random_uuid(), 'INDR','073b2c53-5123-46a4-ae78-fba3bca7d114', '77c1d20d-c76d-4106-ab99-e751bafff384', 'dbdd91fd-21a9-499d-8654-96433cd2485d', 'CWSP', 'CWCW', '11a3c449-7911-42a7-a4aa-f28b30c66874', 16, 1, 'CJAMS-63135', '2025-09-11 16:55:29', 'CJAMS-63135', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', '251023096985', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);