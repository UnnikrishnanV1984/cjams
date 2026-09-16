
/*
Issue Description:CJAMS-69820
Root cause: 
241030361018    Last name is Gyles.   This is a Kinship Navigation but it is asking for a MFIRA and SAFE C for a SEN.  The children are 6 and 12.   Thank you so much
1. Date by which the case needs to be closed-Date/Time-8/10/2026 10 am
2. Who will be the supervisor to approve the case closure?melissa.curtis-cherry@maryland.gov
Fix provided: Data fix has been done to close the case
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: 
*/


update personprogramarea
set enddate ='2026-08-10 10:00:00',
updatedby='CJAMS-69820',updatedon=now()
where objectid='d4de9a24-d353-4d72-ba44-50c834c88d20' and enddate is null and activeflag=1;

update caseassignment
set enddate ='2026-08-10 10:00:00',
updatedby='CJAMS-69820',updatedon=now()
where objectid='d4de9a24-d353-4d72-ba44-50c834c88d20' and enddate is null and activeflag=1;

UPDATE servicecase 
SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2026-08-10 10:00:00', updatedby = 'CJAMS-69820',updatedon = now() 
WHERE servicecaseid = 'd4de9a24-d353-4d72-ba44-50c834c88d20' and activeflag = 1;


INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date, supervisorcomment, reopenreasonkey)
VALUES(gen_random_uuid(), 'd4de9a24-d353-4d72-ba44-50c834c88d20', '2026-08-10 10:00:00', 'Closed', 'Closed', 'Case is closed with ticket CJAMS-69820', '2026-08-10 10:00:00', 1, '3328e486-e80b-4f3b-a7cc-9632eb44afde',now(), 'CJAMS-69820', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '3328e486-e80b-4f3b-a7cc-9632eb44afde', '283833f5-8bd9-4da6-947b-780f9adadd32', '6aff3a45-6218-4937-b0b6-485fc0be9373', 'CWCW', 'CWSP', '', 15, 0, 'CJAMS-69820',now(), 'CJAMS-69820', now(), true, 'case is closed with ticket CJAMS-69820', NULL, (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-69820'), '241030361018', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '283833f5-8bd9-4da6-947b-780f9adadd32', '3328e486-e80b-4f3b-a7cc-9632eb44afde','6aff3a45-6218-4937-b0b6-485fc0be9373', 'CWSP', 'CWCW', (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-69820'), 16, 1, 'CJAMS-69820', now(), 'CJAMS-69820', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', '241030361018', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);