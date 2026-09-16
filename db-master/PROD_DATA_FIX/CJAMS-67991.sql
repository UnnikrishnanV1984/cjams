/*
Issue Description:CJAMS-67991
Category/Module:Placement 
Root cause: This issue has ocuured due to a recenet SEN story implementation,Requested for datafix to close the active person programs, end date the assignmnet and insert a closure record in decision tab
Fix provided: Data fix has been done to close the case
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: 
*/


update caseassignment
set enddate ='2026-05-18 00:00:00.000',
updatedby='CJAMS-67991',updatedon=now()
where caseassignmentid ='9afd59aa-387f-4d54-96e0-b262991d1a14' and activeflag=1;

UPDATE servicecase SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2026-05-18 00:00:00.000', updatedby = 'CJAMS-67991',updatedon = now() 
WHERE servicecaseid = 'd310711d-3d71-4ed4-8886-6b8dd75289e5';


INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date, supervisorcomment, reopenreasonkey)
VALUES(gen_random_uuid(), 'd310711d-3d71-4ed4-8886-6b8dd75289e5', '2026-05-18 00:00:00.000', 'Closed', 'Closed', 'Case is closed with ticket CJAMS-67991', '2026-05-18 00:00:00.000', 1, 'd2ccefc5-4ee2-473b-8978-67cc60ea9a90',now(), 'CJAMS-67991', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', 'd2ccefc5-4ee2-473b-8978-67cc60ea9a90', 'bd2be887-3873-4ff2-b6a9-8bafa585aba0', 'f5214cb2-953e-41a9-a4ad-71341501e2ad', 'CWCW', 'CWSP', '', 15, 0, 'CJAMS-67991',now(), 'CJAMS-67991', now(), true, 'case is closed with ticket CJAMS-67991', NULL, (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-67991'), '3280897', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', 'bd2be887-3873-4ff2-b6a9-8bafa585aba0', 'd2ccefc5-4ee2-473b-8978-67cc60ea9a90','f5214cb2-953e-41a9-a4ad-71341501e2ad', 'CWSP', 'CWCW', (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-67991'), 16, 1, 'CJAMS-67991', now(), 'CJAMS-67991', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', '3280897', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);