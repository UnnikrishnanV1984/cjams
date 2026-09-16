/*
-- Category/ Module: Decision tab
-- Root cause: Worker Joshua Ridenour (200949216) got deactivated on 2025-05-20 14:01:40 and 
    case request closer was sent by Joshua on 2025-05-19 for cases 251023033056,251023035118 and 251023035116 to supervisor Monica Kiefer.
    When supervisor approved the request which is after the deactivation of the user it failed to create the routing record with the accepeted status 
    because the routing record insertion was looking for prior checks/joins for the caseworker information where it failed and leading to fail in creation
    of record inside the routing table. Hence Decision tab was missing the record for all of those CPS cases.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

--SP: for getting the decision records ->select * from getdispositionhistory('0ff5995b-a021-4567-b216-b93a3aac51db','0','20');
/*
 * for saving and updating the routing once supervisor approves the closer request
 SELECT * FROM routingintake('6b3b46db-558d-4da2-9a99-d61df3d7674d'
,'527e483b-5108-4906-b2bb-6fdbc317f03e'
,'INDR',16,'Disposition Approved'
,'',false,false,false,'Disposition Approved'
,'Disposition Approved','dcbb8be3-a137-4cd4-9451-0d339db44da7','',0
);
*/
-- 251023033056
INSERT INTO cjams.routing
( eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES( 'INDR', '5611b96f-733e-47a7-878b-f40b92d39f7c','b17e0ca8-b52a-490a-9ef3-0fe772a9e858', 'de12a5e3-d28e-4618-ad95-1b739145fc97'::uuid, 'CWSP','CWCW', '78a7d4ae-6f3c-4d83-8d22-4ccbfc542a2f', 16, 1, '5611b96f-733e-47a7-878b-f40b92d39f7c', '2025-05-22 17:03:43.318', '5611b96f-733e-47a7-878b-f40b92d39f7c', '2025-05-22 17:03:43.318', true, 'Disposition Approved', NULL, 'Disposition Approved', '251023033056', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

--251023035118 
INSERT INTO cjams.routing
( eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES( 'INDR', '5611b96f-733e-47a7-878b-f40b92d39f7c','b17e0ca8-b52a-490a-9ef3-0fe772a9e858', 'de12a5e3-d28e-4618-ad95-1b739145fc97'::uuid, 'CWSP','CWCW', '6b3b46db-558d-4da2-9a99-d61df3d7674d', 16, 1, '5611b96f-733e-47a7-878b-f40b92d39f7c', '2025-05-22 16:35:37.322', '5611b96f-733e-47a7-878b-f40b92d39f7c', '2025-05-22 16:35:37.322', true, 'Disposition Approved', NULL, 'Disposition Approved', '251023035118', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

--251023035116 

INSERT INTO cjams.routing
( eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES( 'INDR', '5611b96f-733e-47a7-878b-f40b92d39f7c','b17e0ca8-b52a-490a-9ef3-0fe772a9e858', 'de12a5e3-d28e-4618-ad95-1b739145fc97'::uuid, 'CWSP','CWCW', 'a7ec7114-045a-43db-8a13-305f349ac7a8', 16, 1, '5611b96f-733e-47a7-878b-f40b92d39f7c', '2025-05-27 15:52:28.565', '5611b96f-733e-47a7-878b-f40b92d39f7c', '2025-05-27 15:52:28.565', true, 'Disposition Approved', NULL, 'Disposition Approved', '251023035116', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

