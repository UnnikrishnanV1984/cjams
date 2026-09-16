/*
   Issue Description: CDM-16321
   Category/ Module  : payment approval
   Root cause: user wants to remove the pending approval for purchase authorization as its already approved
   Backup Query:
   
	INSERT INTO cjams.routing
	(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
	VALUES('4fa187bd-11eb-45db-85f2-6c8d84d8624b'::uuid, 'PCAUTHR', '5ad6741c-2fc0-4f0a-879a-0a2e9dfd173b', '2e9a186d-d7a9-4ba6-ada0-11a3ed5b0706', '5e18b80e-2526-4d14-a2aa-f23a853ceaa8'::uuid, 'CWSP', 'FNSFW', '1789680', 40, 1, '5ad6741c-2fc0-4f0a-879a-0a2e9dfd173b', '2021-08-17 10:29:24.687', '5ad6741c-2fc0-4f0a-879a-0a2e9dfd173b', '2021-08-17 10:29:24.687', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3301857', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
	INSERT INTO cjams.routing
	(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
	VALUES('1c507cd1-a4f2-4ba6-a419-cd50dfafa8a7'::uuid, 'PCAUTHR', '5ad6741c-2fc0-4f0a-879a-0a2e9dfd173b', '2e9a186d-d7a9-4ba6-ada0-11a3ed5b0706', '5e18b80e-2526-4d14-a2aa-f23a853ceaa8'::uuid, 'CWSP', 'FNSFW', '1789685', 40, 1, '5ad6741c-2fc0-4f0a-879a-0a2e9dfd173b', '2021-08-17 10:40:00.018', '5ad6741c-2fc0-4f0a-879a-0a2e9dfd173b', '2021-08-17 10:40:00.018', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3305794', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
	INSERT INTO cjams.routing
	(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
	VALUES('e2934886-4193-477d-8688-3c21d9933783'::uuid, 'PCAUTHR', '5ad6741c-2fc0-4f0a-879a-0a2e9dfd173b', '2e9a186d-d7a9-4ba6-ada0-11a3ed5b0706', '5e18b80e-2526-4d14-a2aa-f23a853ceaa8'::uuid, 'CWSP', 'FNSFS', '1789685', 40, 1, '5ad6741c-2fc0-4f0a-879a-0a2e9dfd173b', '2021-08-17 10:40:11.677', '5ad6741c-2fc0-4f0a-879a-0a2e9dfd173b', '2021-08-17 10:40:11.677', true, 'Forwarded to Funding Approval', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3305794', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

    INSERT INTO cjams.routing
    (routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
    VALUES('9ef303a7-d38f-4714-ab5b-edae8d886240'::uuid, 'PCAUTHR', '2e9a186d-d7a9-4ba6-ada0-11a3ed5b0706', '3ddf35b2-8657-4023-9d96-1f4163dcdb43', '5e18b80e-2526-4d14-a2aa-f23a853ceaa8'::uuid, 'FNSFS', 'FNSFS', '1789685', 43, 1, '2e9a186d-d7a9-4ba6-ada0-11a3ed5b0706', '2021-08-18 08:22:14.828', '2e9a186d-d7a9-4ba6-ada0-11a3ed5b0706', '2021-08-18 08:22:14.828', true, 'Approved', NULL, 'Purchase Authorization Forwarded to Payment Approval', NULL, 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
    INSERT INTO cjams.routing
    (routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
    VALUES('d60085a9-506f-49e8-a4d2-89b73c2de84c'::uuid, 'PCAUTHR', '2e9a186d-d7a9-4ba6-ada0-11a3ed5b0706', '3ddf35b2-8657-4023-9d96-1f4163dcdb43', '5e18b80e-2526-4d14-a2aa-f23a853ceaa8'::uuid, 'FNSFS', 'FNSFS', '1789685', 43, 1, '2e9a186d-d7a9-4ba6-ada0-11a3ed5b0706', '2021-08-18 10:36:04.249', '2e9a186d-d7a9-4ba6-ada0-11a3ed5b0706', '2021-08-18 10:36:04.249', true, 'Approved', NULL, 'Purchase Authorization Forwarded to Payment Approval', NULL, 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


*/

DELETE FROM routing 
WHERE routingid IN ('4fa187bd-11eb-45db-85f2-6c8d84d8624b','1c507cd1-a4f2-4ba6-a419-cd50dfafa8a7','e2934886-4193-477d-8688-3c21d9933783', '9ef303a7-d38f-4714-ab5b-edae8d886240', 'd60085a9-506f-49e8-a4d2-89b73c2de84c');