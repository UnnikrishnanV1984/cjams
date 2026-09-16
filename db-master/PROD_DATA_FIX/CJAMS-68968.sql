/*
Issue Description:CJAMS-68968
Category/Module:Decision
Root cause: This issue has ocuured due to a recenet SEN story implementation,Requested for datafix to  end date the assignment and insert a closure record in decision tab
Fix provided: Data fix has been done to close the case
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: 
*/

update caseassignment
set enddate ='2026-06-04 13:59:22',
updatedby='CJAMS-68968',updatedon=now()
where caseassignmentid='0badfe07-26ae-499b-b9b3-e27281bbf959' and activeflag=1;

UPDATE servicecase SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2026-06-04 13:59:22', updatedby = 'CJAMS-68968',updatedon = now() 
WHERE servicecaseid = '7401288e-318d-4dfb-b96d-e28d337713c0';


INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date, supervisorcomment, reopenreasonkey)
VALUES(gen_random_uuid(), '7401288e-318d-4dfb-b96d-e28d337713c0', '2026-06-04 13:59:22', 'Closed', 'Closed', 'Case is closed with ticket CJAMS-68968', '2026-06-04 13:59:22', 1, '5c6db281-5fd8-42c3-be81-d99c27c409ae',now(), 'CJAMS-68968', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '5c6db281-5fd8-42c3-be81-d99c27c409ae', '48602c12-8998-48d1-84e5-1aebbf761ceb', '7665ca54-5374-4174-be07-a687b811a82c', 'CWCW', 'CWSP', '', 15, 0, 'CJAMS-68968',now(), 'CJAMS-68968', now(), true, 'case is closed with ticket CJAMS-68968', NULL, (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68968'), '251030468665', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '48602c12-8998-48d1-84e5-1aebbf761ceb', '5c6db281-5fd8-42c3-be81-d99c27c409ae','7665ca54-5374-4174-be07-a687b811a82c', 'CWSP', 'CWCW', (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68968'), 16, 1, 'CJAMS-68968', now(), 'CJAMS-68968', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', '251030468665', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);