
/*
Issue Description:CJAMS-68354
Category/Module:Placement 
Root cause: This issue has ocuured due to a recenet SEN story implementation,Requested for datafix to close the active person programs, end date the assignmnet and insert a closure record in decision tab
Fix provided: Data fix has been done to close the case
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: 
*/

update tb_service_purchase_authorization set delete_sw='Y',update_user_id ='CJAMS-68354', update_ts =now() where service_log_id='3538533' and authorization_id='3674462';

update caseassignment
set enddate ='2026-04-06 00:00:00',
updatedby='CJAMS-68354',updatedon=now()
where caseassignmentid='883769ba-156a-411c-9938-845d9e6e72a3' and activeflag=1;

UPDATE servicecase SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2026-04-06 00:00:00', updatedby = 'CJAMS-68354',updatedon = now() 
WHERE servicecaseid = '2d77ae7c-43c4-4831-a425-a62ad49151ff';


INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date, supervisorcomment, reopenreasonkey)
VALUES(gen_random_uuid(), '2d77ae7c-43c4-4831-a425-a62ad49151ff', '2026-04-06 00:00:00', 'Closed', 'Closed', 'Case is closed with ticket CJAMS-68354', '2026-04-06 00:00:00', 1, '9b41a7ca-d247-4577-8f0c-b2337d2d48d7',now(), 'CJAMS-68354', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '9b41a7ca-d247-4577-8f0c-b2337d2d48d7', 'c237f718-5ab0-491d-8e01-f243c90493b4', '7665ca54-5374-4174-be07-a687b811a82c', 'CWCW', 'CWSP', '', 15, 0, 'CJAMS-68354',now(), 'CJAMS-68354', now(), true, 'case is closed with ticket CJAMS-68354', NULL, (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68354'), '3259645', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', 'c237f718-5ab0-491d-8e01-f243c90493b4', '9b41a7ca-d247-4577-8f0c-b2337d2d48d7','7665ca54-5374-4174-be07-a687b811a82c', 'CWSP', 'CWCW', (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68354'), 16, 1, 'CJAMS-68354', now(), 'CJAMS-68354', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', '3259645', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);