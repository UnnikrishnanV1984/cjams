
/*
Issue Description:CJAMS-68870
Category/Module:Placement 
Root cause: This issue has ocuured due to a recenet SEN story implementation,Requested for datafix to close the active person programs, end date the assignmnet and insert a closure record in decision tab
Fix provided: Data fix has been done to close the case
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: 
*/


update caseassignment
set enddate ='2026-05-31 13:59:22',
updatedby='CJAMS-68870',updatedon=now()
where caseassignmentid='029bb7a8-6a5b-499b-98f9-47c96545e649' and activeflag=1;

UPDATE servicecase SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2026-05-31 13:59:22', updatedby = 'CJAMS-68870',updatedon = now() 
WHERE servicecaseid = '2a3d11cf-f637-4022-a7d9-69623a6dd409';


INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date, supervisorcomment, reopenreasonkey)
VALUES(gen_random_uuid(), '2a3d11cf-f637-4022-a7d9-69623a6dd409', '2026-05-31 13:59:22', 'Closed', 'Closed', 'Case is closed with ticket CJAMS-68870', '2026-05-31 13:59:22', 1, '688443e3-a72e-44af-ae75-336da31ace0c',now(), 'CJAMS-68870', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '688443e3-a72e-44af-ae75-336da31ace0c', '03d9cd8c-6c21-4bff-bf9a-7ebfc5bcdfa0', '7665ca54-5374-4174-be07-a687b811a82c', 'CWCW', 'CWSP', '', 15, 0, 'CJAMS-68870',now(), 'CJAMS-68870', now(), true, 'case is closed with ticket CJAMS-68870', NULL, (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68870'), '261030698990', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '03d9cd8c-6c21-4bff-bf9a-7ebfc5bcdfa0', '688443e3-a72e-44af-ae75-336da31ace0c','7665ca54-5374-4174-be07-a687b811a82c', 'CWSP', 'CWCW', (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68870'), 16, 1, 'CJAMS-68870', now(), 'CJAMS-68870', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', '261030698990', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);