
/*
Issue Description:CJAMS-68674
Category/Module:Placement 
Root cause: This issue has ocuured due to a recenet SEN story implementation,Requested for datafix to close the active person programs, end date the assignmnet and insert a closure record in decision tab
Fix provided: Data fix has been done to close the case
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: 
*/



update personprogramarea
set enddate ='2026-07-01 13:59:22',
updatedby='CJAMS-68674',updatedon=now()
where objectid='94a7db4f-c398-44a4-b89d-8a194635a31a' and activeflag=1;

update caseassignment
set enddate ='2026-07-01 13:59:22',
updatedby='CJAMS-68674',updatedon=now()
where caseassignmentid='b4a9cf5e-8097-4520-8b08-98ca219440bd' and activeflag=1;

UPDATE servicecase SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2026-07-01 13:59:22', updatedby = 'CJAMS-68674',updatedon = now() 
WHERE servicecaseid = '94a7db4f-c398-44a4-b89d-8a194635a31a';


INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date, supervisorcomment, reopenreasonkey)
VALUES(gen_random_uuid(), '94a7db4f-c398-44a4-b89d-8a194635a31a', '2026-07-01 13:59:22', 'Closed', 'Closed', 'Case is closed with ticket CJAMS-68674', '2026-07-01 13:59:22', 1, '0d8e0e71-b4a1-4938-8d0a-433530034568',now(), 'CJAMS-68674', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '0d8e0e71-b4a1-4938-8d0a-433530034568', '056865a7-2a58-494e-9993-ccc6fd9aae58', '7665ca54-5374-4174-be07-a687b811a82c', 'CWCW', 'CWSP', '', 15, 0, 'CJAMS-68674',now(), 'CJAMS-68674', now(), true, 'case is closed with ticket CJAMS-68674', NULL, (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68674'), '221030026095', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '056865a7-2a58-494e-9993-ccc6fd9aae58', '0d8e0e71-b4a1-4938-8d0a-433530034568','7665ca54-5374-4174-be07-a687b811a82c', 'CWSP', 'CWCW', (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68674'), 16, 1, 'CJAMS-68674', now(), 'CJAMS-68674', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', '221030026095', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
