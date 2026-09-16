/*
   Issue Description: CJAMS-67942
   Category/ Module  :  Case Issue
   Root cause: 261030649154:This case is ready for closure
   Fix: Deleted service case, servicecasedisposition, routing and caseassginment
   Pull request# for code fix: 
   Reason why no related code fix: 
*/


update personprogramarea
set enddate ='2026-06-30 00:00:00',
updatedby='CJAMS-67942',updatedon=now()
where objectid='99b95b13-ac7d-41fc-b3c2-b858af0ee51f' and enddate is null and activeflag=1;

update caseassignment
set enddate ='2026-06-30 00:00:00',
updatedby='CJAMS-67942',updatedon=now()
where objectid='99b95b13-ac7d-41fc-b3c2-b858af0ee51f' and enddate is null and activeflag=1;

UPDATE servicecase 
SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2026-06-30 00:00:00', updatedby = 'CJAMS-67942',updatedon = now() 
WHERE servicecaseid = '99b95b13-ac7d-41fc-b3c2-b858af0ee51f' and activeflag = 1;


INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date, supervisorcomment, reopenreasonkey)
VALUES(gen_random_uuid(), '99b95b13-ac7d-41fc-b3c2-b858af0ee51f', '2026-06-30 00:00:00', 'Closed', 'Closed', 'Case is closed with ticket CJAMS-67942', '2026-06-30 00:00:00', 1, '5929958a-86a4-4b31-b34d-82134f7df97e',now(), 'CJAMS-67942', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '5929958a-86a4-4b31-b34d-82134f7df97e', '732b097a-2a84-4c37-9851-8673d5a55da9', 'ec34ee52-00ce-498d-a19f-017b102942c0', 'CWCW', 'CWSP', '', 15, 0, 'CJAMS-67942',now(), 'CJAMS-67942', now(), true, 'case is closed with ticket CJAMS-67942', NULL, (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-67942'), '261030649154', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '732b097a-2a84-4c37-9851-8673d5a55da9', '5929958a-86a4-4b31-b34d-82134f7df97e','ec34ee52-00ce-498d-a19f-017b102942c0', 'CWSP', 'CWCW', (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-67942'), 16, 1, 'CJAMS-67942', now(), 'CJAMS-67942', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', '261030649154', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);