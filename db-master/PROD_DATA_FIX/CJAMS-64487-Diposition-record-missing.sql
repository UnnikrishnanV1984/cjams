/*
Issue: CJAMS-64487 Case Closure
Category/Module: CPS AR/ Diposition
Root cause: Disposition record missing as the case worker who created the case is deactivated in 
Fix provided:  Data fix has been done to assign the case to corresponsding Supervisor of the case worker
                Case Worker: 029eb4d0-cf4e-4d80-bd4a-0ae6f12f6468 (AlexandriaAdams)
                Supervisor : 8c27171c-3dc5-4b93-8d18-52b63c489075 (Holly Naff)
Data/Code fix ticket#: CJAMS-64487
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: We are unable to replicate this issue in stage-3 and will monitor it for future occurences
*/



INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'INDR', '77c1d20d-c76d-4106-ab99-e751bafff384','029eb4d0-cf4e-4d80-bd4a-0ae6f12f6468','dbdd91fd-21a9-499d-8654-96433cd2485d'::uuid, 'CWSP', 'CWCW', 'b1338a43-4221-48ef-8639-e846acc5b92c', 16, 1, '029eb4d0-cf4e-4d80-bd4a-0ae6f12f6468', '2025-12-03 10:32:55.603', '77c1d20d-c76d-4106-ab99-e751bafff384', '2025-12-05 12:39:39.612', true, '', NULL, '', '251023170528', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
