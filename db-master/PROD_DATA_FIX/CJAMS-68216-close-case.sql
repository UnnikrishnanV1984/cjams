/*
Issue Description:CJAMS-68216
Category/Module:Placement 
Root cause: This issue has ocuured due to a recenet SEN story implementation,Requested for datafix to close the active person programs, end date the assignmnet and insert a closure record in decision tab
Fix provided: Data fix has been done to close the case
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: 
*/


update caseassignment
set enddate ='2023-10-16 00:00:00',
updatedby='CJAMS-68216', updatedon=now()
where caseassignmentid in('d9f1f85d-8e6d-4d3f-a73a-36ec26eec41c', '01436e59-928a-4aa1-999c-654aada1b635') and activeflag=1;

UPDATE servicecase 
SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2023-10-16 00:00:00', updatedby = 'CJAMS-68216', updatedon = now() 
WHERE servicecaseid = 'c95a1c0d-bbf8-4902-8d88-ba378e2bc418';

INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date, supervisorcomment, reopenreasonkey)
VALUES(gen_random_uuid(), 'c95a1c0d-bbf8-4902-8d88-ba378e2bc418', '2023-10-16 00:00:00', 'Closed', 'Closed', 'Case is closed with ticket CJAMS-68216', '2023-10-16 00:00:00', 1, '45391f16-58de-4b24-bd7e-12cdc4ff4335',now(), 'CJAMS-68216', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '45391f16-58de-4b24-bd7e-12cdc4ff4335', 'fab84a8e-2e81-4699-a435-285c577e008b', '8e711955-f8a1-488c-b5bb-7c4c29943b22', 'CWCW', 'CWSP', '', 15, 0, 'CJAMS-68216',now(), 'CJAMS-68216', now(), true, 'case is closed with ticket CJAMS-68216', NULL, (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68216'), '221030016973', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', 'fab84a8e-2e81-4699-a435-285c577e008b', '45391f16-58de-4b24-bd7e-12cdc4ff4335','8e711955-f8a1-488c-b5bb-7c4c29943b22', 'CWSP', 'CWCW', (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68216'), 16, 1, 'CJAMS-68216', now(), 'CJAMS-68216', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', '221030016973', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);