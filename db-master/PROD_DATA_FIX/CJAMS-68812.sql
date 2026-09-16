
/*
Issue Description:CJAMS-68812
Category/Module:Placement 
Root cause: This issue has ocuured due to a recenet SEN story implementation,Requested for datafix to close the active person programs, end date the assignmnet and insert a closure record in decision tab
Fix provided: Data fix has been done to close the case
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: 
*/


update personprogramarea
set enddate ='2026-07-08 13:59:22',
updatedby='CJAMS-68812',updatedon=now()
where objectid='b70032ed-4107-4002-ab13-0d20b2b00c03' and activeflag=1;

update caseassignment
set enddate ='2026-07-08 13:59:22',
updatedby='CJAMS-68812',updatedon=now()
where caseassignmentid='97f27ea4-8ca4-410d-bbd2-4296d818c783' and activeflag=1;

UPDATE servicecase SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2026-07-08 13:59:22', updatedby = 'CJAMS-68812',updatedon = now() 
WHERE servicecaseid = 'b70032ed-4107-4002-ab13-0d20b2b00c03';


INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date, supervisorcomment, reopenreasonkey)
VALUES(gen_random_uuid(), 'b70032ed-4107-4002-ab13-0d20b2b00c03', '2026-07-08 13:59:22', 'Closed', 'Closed', 'Case is closed with ticket CJAMS-68812', '2026-07-08 13:59:22', 1, '8d4df684-6912-4312-b929-06355ca7213f',now(), 'CJAMS-68812', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '8d4df684-6912-4312-b929-06355ca7213f', 'b4d781df-520b-41f5-b294-654f8d9bf141', '7665ca54-5374-4174-be07-a687b811a82c', 'CWCW', 'CWSP', '', 15, 0, 'CJAMS-68812',now(), 'CJAMS-68812', now(), true, 'case is closed with ticket CJAMS-68812', NULL, (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68812'), '261030694485', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', 'b4d781df-520b-41f5-b294-654f8d9bf141', '8d4df684-6912-4312-b929-06355ca7213f','7665ca54-5374-4174-be07-a687b811a82c', 'CWSP', 'CWCW', (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68812'), 16, 1, 'CJAMS-68812', now(), 'CJAMS-68812', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', '261030694485', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);