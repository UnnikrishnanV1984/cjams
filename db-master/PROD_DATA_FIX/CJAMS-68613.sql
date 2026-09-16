
/*
Issue Description:CJAMS-68613
Category/Module:Placement 
Root cause: This issue has ocuured due to a recenet SEN story implementation,Requested for datafix to close the active person programs, end date the assignmnet and insert a closure record in decision tab
Fix provided: Data fix has been done to close the case
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: 
*/


update personprogramarea
set enddate ='2026-06-29 13:59:22',
updatedby='CJAMS-68613',updatedon=now()
where objectid='90e056dd-4d79-49b1-9e6d-469831282901' and activeflag=1;

update caseassignment
set enddate ='2026-06-29 13:59:22',
updatedby='CJAMS-68613',updatedon=now()
where caseassignmentid='e665628c-3eef-44cc-b9f2-674487b61d7c' and activeflag=1;

UPDATE servicecase SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2026-06-29 13:59:22', updatedby = 'CJAMS-68613',updatedon = now() 
WHERE servicecaseid = '90e056dd-4d79-49b1-9e6d-469831282901';


INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date, supervisorcomment, reopenreasonkey)
VALUES(gen_random_uuid(), '90e056dd-4d79-49b1-9e6d-469831282901', '2026-06-29 13:59:22', 'Closed', 'Closed', 'Case is closed with ticket CJAMS-68613', '2026-06-29 13:59:22', 1, '811fc33e-3228-4a21-b459-fa330e353462',now(), 'CJAMS-68613', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '811fc33e-3228-4a21-b459-fa330e353462', '056865a7-2a58-494e-9993-ccc6fd9aae58', '7665ca54-5374-4174-be07-a687b811a82c', 'CWCW', 'CWSP', '', 15, 0, 'CJAMS-68613',now(), 'CJAMS-68613', now(), true, 'case is closed with ticket CJAMS-68613', NULL, (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68613'), '3292650', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '056865a7-2a58-494e-9993-ccc6fd9aae58', '811fc33e-3228-4a21-b459-fa330e353462','7665ca54-5374-4174-be07-a687b811a82c', 'CWSP', 'CWCW', (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68613'), 16, 1, 'CJAMS-68613', now(), 'CJAMS-68613', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', '3292650', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
