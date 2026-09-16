/* 
    Issue Description: CDM-38510
  Category/ Module  : Decision
  Root cause: User request to remove the required details
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: 
  Backup before update/ delete: 
*/

DELETE FROM cjams.routing
WHERE routingid='82a46f5e-e0a4-44a3-8526-7e867e429853';

DELETE FROM cjams.routing
WHERE routingid='b7c8ea65-e4f7-4c54-8b42-ac432b8a2ab5';
/*
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('82a46f5e-e0a4-44a3-8526-7e867e429853', 'INTR', '309d6683-8cbe-4d52-8c6f-7035bc0f1db9', 'fb8de525-4d56-414c-bf9c-35cf11179d7c', '4ceadfd4-2858-4dd5-896a-2a470c668c02', 'CWSP', 'CWIW', 'I241012135499', 861, 0, '309d6683-8cbe-4d52-8c6f-7035bc0f1db9', '2024-04-22 15:50:57.717', 'd86bb458-2309-4182-b155-ae22d36cf9d6', '2024-04-23 09:55:58.503', false, 'Return to worker', NULL, 'Return to Worker', ' ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Scrnin', 'Return to Worker', NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('b7c8ea65-e4f7-4c54-8b42-ac432b8a2ab5', 'INTR', 'd86bb458-2309-4182-b155-ae22d36cf9d6', '309d6683-8cbe-4d52-8c6f-7035bc0f1db9', '4ceadfd4-2858-4dd5-896a-2a470c668c02', 'CWIW', 'CWSP', 'I241012135499', 861, 1, 'd86bb458-2309-4182-b155-ae22d36cf9d6', '2024-04-23 09:55:58.503', 'd86bb458-2309-4182-b155-ae22d36cf9d6', '2024-04-23 09:55:58.503', false, 'Return to worker', NULL, 'Return to Worker', ' ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Scrnin', 'Return to Worker', NULL);
*/

update IntakeDAStaging set insertedby = '309d6683-8cbe-4d52-8c6f-7035bc0f1db9', status ='Complete', updatedon = now(), updatedby = 'CDM-38510' where intakenumber = 'I241012135499' and activeflag =1;
update intakeDAStatus set status = 2, updatedon = now(), updatedby = 'CDM-38510'  where intakenumber = 'I241012135499' and activeflag =1;
update intakeservicerequest  set activeflag =1, updatedon = now(), updatedby = 'CDM-38510'where intakenumber = 'I241012135499';
update routing set tosecurityusersid = '309d6683-8cbe-4d52-8c6f-7035bc0f1db9', updatedon = now(), updatedby = '309d6683-8cbe-4d52-8c6f-7035bc0f1db9' where routingid = '6d9d5c5f-5f25-48fb-83d5-7c91b01052a5' and objectid = 'I241012135499' and activeflag =1;

UPDATE intakesnapshot SET updatedby = 'CDM-38510', updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}', jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"Scrnin"')))) 
WHERE intakenumber = 'I241012135499' AND activeflag=1; 
