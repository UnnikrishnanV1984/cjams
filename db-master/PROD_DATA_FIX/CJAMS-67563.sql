/*
Issue Description:CJAMS-67563
Category/Module:Placement 
Root cause: This issue has ocuured due to a recenet SEN story implementation,Requested for datafix to close the active person programs, end date the assignmnet and insert a closure record in decision tab
Fix provided: Data fix has been done to close the case
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: 
*/

update caseassignment
set enddate ='2025-09-19 00:00:00.000',
updatedby='CJAMS-67563',updatedon=now()
where caseassignmentid ='98a192ff-5f40-4d11-92d0-c8c9053705a4' and activeflag=1;

UPDATE servicecase SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2025-09-19 00:00:00.000', updatedby = 'CJAMS-67563',updatedon = now() 
WHERE servicecaseid = 'a150726f-1734-4e6a-950c-1acd799fa8af';


INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date, supervisorcomment, reopenreasonkey)
VALUES(gen_random_uuid(), 'a150726f-1734-4e6a-950c-1acd799fa8af', '2025-09-19 00:00:00.000', 'Closed', 'Closed', 'Case is closed with ticket CJAMS-67563', '2025-09-19 00:00:00.000', 1, '2b024e8c-6178-4de4-ab68-bbf4d4d47007',now(), 'CJAMS-67563', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '2b024e8c-6178-4de4-ab68-bbf4d4d47007', '8f1c9fd1-05ef-4a3c-8656-508297f5e494', '1b7ae41e-e77a-4a1e-a0a3-cda5292cde0b', 'CWCW', 'CWSP', '', 15, 0, 'CJAMS-67563',now(), 'CJAMS-67563', now(), true, 'case is closed with ticket CJAMS-67563', NULL, (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-67563'), '211030011977', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '8f1c9fd1-05ef-4a3c-8656-508297f5e494', '2b024e8c-6178-4de4-ab68-bbf4d4d47007','1b7ae41e-e77a-4a1e-a0a3-cda5292cde0b', 'CWSP', 'CWCW', (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-67563'), 16, 1, 'CJAMS-67563', now(), 'CJAMS-67563', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', '211030011977', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);