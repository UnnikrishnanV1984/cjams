
/*
Issue Description:CJAMS-68745
Category/Module:Placement 
Root cause: This issue has ocuured due to a recenet SEN story implementation,Requested for datafix to close the active person programs, end date the assignmnet and insert a closure record in decision tab
Fix provided: Data fix has been done to close the case
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: 
*/


update caseassignment
set enddate ='2026-07-02 13:59:22',
updatedby='CJAMS-68745',updatedon=now()
where caseassignmentid='435f56db-aeb8-4cf1-b188-2c6637049d7e' and activeflag=1;

UPDATE servicecase SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2026-07-02 13:59:22', updatedby = 'CJAMS-68745',updatedon = now() 
WHERE servicecaseid = 'dc01426c-7c0f-4c5c-b561-7e5691c1e183';


INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date, supervisorcomment, reopenreasonkey)
VALUES(gen_random_uuid(), 'dc01426c-7c0f-4c5c-b561-7e5691c1e183', '2026-07-02 13:59:22', 'Closed', 'Closed', 'Case is closed with ticket CJAMS-68745', '2026-07-02 13:59:22', 1, '688443e3-a72e-44af-ae75-336da31ace0c',now(), 'CJAMS-68745', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '688443e3-a72e-44af-ae75-336da31ace0c', '056865a7-2a58-494e-9993-ccc6fd9aae58', '7665ca54-5374-4174-be07-a687b811a82c', 'CWCW', 'CWSP', '', 15, 0, 'CJAMS-68745',now(), 'CJAMS-68745', now(), true, 'case is closed with ticket CJAMS-68745', NULL, (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68745'), '261030702682', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '056865a7-2a58-494e-9993-ccc6fd9aae58', '688443e3-a72e-44af-ae75-336da31ace0c','7665ca54-5374-4174-be07-a687b811a82c', 'CWSP', 'CWCW', (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68745'), 16, 1, 'CJAMS-68745', now(), 'CJAMS-68745', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', '261030702682', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);