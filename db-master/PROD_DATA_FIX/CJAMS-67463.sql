
/*
Issue Description:CJAMS-67463
Category/Module:Placement 
Root cause: This issue has ocuured due to a recenet SEN story implementation,Requested for datafix to close the active person programs, end date the assignmnet and insert a closure record in decision tab
Fix provided: Data fix has been done to close the case
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: 
*/


update personprogramarea
set enddate ='2026-03-30 00:00:00',
updatedby='CJAMS-67463',updatedon=now()
where objectid='6a4bc420-55f1-4c6d-9c81-872c37d07d9b' and activeflag=1;

update caseassignment
set enddate ='2026-03-30 00:00:00',
updatedby='CJAMS-67463',updatedon=now()
where caseassignmentid='9b558736-fc41-4896-9692-403b7010d3ba' and activeflag=1;

UPDATE servicecase SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2026-03-30 00:00:00', updatedby = 'CJAMS-67463',updatedon = now() 
WHERE servicecaseid = '6a4bc420-55f1-4c6d-9c81-872c37d07d9b';


INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date, supervisorcomment, reopenreasonkey)
VALUES(gen_random_uuid(), '6a4bc420-55f1-4c6d-9c81-872c37d07d9b', '2026-03-30 00:00:00', 'Closed', 'Closed', 'Case is closed with ticket CJAMS-67463', '2026-03-30 00:00:00', 1, 'a238ffca-e9d6-49ef-bf6e-a73eb47ff8e4',now(), 'CJAMS-67463', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', 'a238ffca-e9d6-49ef-bf6e-a73eb47ff8e4', 'fa6c7906-97af-4f35-8987-dbc6add7090d', 'f701408a-e888-4f22-97e5-3cc6363df239', 'CWCW', 'CWSP', '', 15, 0, 'CJAMS-67463',now(), 'CJAMS-67463', now(), true, 'case is closed with ticket CJAMS-67463', NULL, (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-67463'), '3267931', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', 'fa6c7906-97af-4f35-8987-dbc6add7090d', 'a238ffca-e9d6-49ef-bf6e-a73eb47ff8e4','f701408a-e888-4f22-97e5-3cc6363df239', 'CWSP', 'CWCW', (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-67463'), 16, 1, 'CJAMS-67463', now(), 'CJAMS-67463', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', '3267931', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);