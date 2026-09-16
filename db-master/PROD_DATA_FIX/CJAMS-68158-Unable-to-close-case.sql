/*
   Issue Description: CJAMS-68158
   Category/ Module  :  Case Issue
   Root cause: 3283259 :This case is ready for closure
           Approval received - case needs to be closed on June 3rd, Jessica - supervisor , case worker - jeremy Burrier ,
   Fix: Deleted service case, servicecasedisposition, routing and caseassginment
   Pull request# for code fix: 
   Reason why no related code fix: 
*/


update personprogramarea
set enddate ='2026-06-03 00:00:00',
updatedby='CJAMS-68158',updatedon=now()
where objectid='38bd0d9e-9bfe-4d5e-a652-74130564ae7a' and enddate is null and activeflag=1;

update caseassignment
set enddate ='2026-06-03 00:00:00',
updatedby='CJAMS-68158',updatedon=now()
where objectid='38bd0d9e-9bfe-4d5e-a652-74130564ae7a' and enddate is null and activeflag=1;

UPDATE servicecase 
SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2026-06-03 00:00:00', updatedby = 'CJAMS-68158',updatedon = now() 
WHERE servicecaseid = '38bd0d9e-9bfe-4d5e-a652-74130564ae7a' and activeflag = 1;


INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date, supervisorcomment, reopenreasonkey)
VALUES(gen_random_uuid(), '38bd0d9e-9bfe-4d5e-a652-74130564ae7a', '2026-06-03 00:00:00', 'Closed', 'Closed', 'Case is closed with ticket CJAMS-68158', '2026-06-03 00:00:00', 1, 'a3525d44-f3c4-4d2a-9a6e-a1ffa5e8c82b',now(), 'CJAMS-68158', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', 'a3525d44-f3c4-4d2a-9a6e-a1ffa5e8c82b', 'fbd90a98-e840-4c32-8fd9-55f94384da21', 'ec34ee52-00ce-498d-a19f-017b102942c0', 'CWCW', 'CWSP', '', 15, 0, 'CJAMS-68158',now(), 'CJAMS-68158', now(), true, 'case is closed with ticket CJAMS-68158', NULL, (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68158'), '3283259', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', 'fbd90a98-e840-4c32-8fd9-55f94384da21', 'a3525d44-f3c4-4d2a-9a6e-a1ffa5e8c82b','ec34ee52-00ce-498d-a19f-017b102942c0', 'CWSP', 'CWCW', (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68158'), 16, 1, 'CJAMS-68158', now(), 'CJAMS-68158', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', '3283259', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);