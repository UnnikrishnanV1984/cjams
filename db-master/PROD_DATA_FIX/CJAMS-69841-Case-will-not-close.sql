
/*
Issue Description:CJAMS-69841
Root cause: 
3278516
Please carry out data fix to close the case.  New case closure record should be inserted in Decision tab as per below input. 
Status/Decision should be Closed/Close Case in blue ribbon
Requested Date         8/11/26 
Status            Closed
Recommendation        Close Case
User            Anna Green
Role            Case Worker
Reviewer comments    Case is closed with ticket CJAMS-69841
Approval Status        Approved 
Approved By         Jaime Martin
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: 
*/


update personprogramarea
set enddate ='2026-08-11 10:00:00',
updatedby='CJAMS-69841',updatedon=now()
where objectid='3b7f5392-c10d-47f4-80ea-29cc0619bbe8' and enddate is null and activeflag=1;

update caseassignment
set enddate ='2026-08-11 10:00:00',
updatedby='CJAMS-69841',updatedon=now()
where objectid='3b7f5392-c10d-47f4-80ea-29cc0619bbe8' and enddate is null and activeflag=1;

UPDATE servicecase 
SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2026-08-11 10:00:00', updatedby = 'CJAMS-69841',updatedon = now() 
WHERE servicecaseid = '3b7f5392-c10d-47f4-80ea-29cc0619bbe8' and activeflag = 1;


INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date, supervisorcomment, reopenreasonkey)
VALUES(gen_random_uuid(), '3b7f5392-c10d-47f4-80ea-29cc0619bbe8', '2026-08-11 10:00:00', 'Closed', 'Closed', 'Case is closed with ticket CJAMS-69841', '2026-08-11 10:00:00', 1, '4f787e95-616a-4353-8212-113617ac0cf6',now(), 'CJAMS-69841', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '4f787e95-616a-4353-8212-113617ac0cf6', '0f902b1c-bf32-4bfa-a223-c60727979297', 'b8d4d6d4-bd06-4087-b38a-b085abb266db', 'CWCW', 'CWSP', '', 15, 0, 'CJAMS-69841',now(), 'CJAMS-69841', now(), true, 'case is closed with ticket CJAMS-69841', NULL, (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-69841'), '3278516', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '0f902b1c-bf32-4bfa-a223-c60727979297', '4f787e95-616a-4353-8212-113617ac0cf6','b8d4d6d4-bd06-4087-b38a-b085abb266db', 'CWSP', 'CWCW', (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-69841'), 16, 1, 'CJAMS-69841', now(), 'CJAMS-69841', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', '3278516', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);