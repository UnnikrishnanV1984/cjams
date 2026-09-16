/*
   Issue Description: CJAMS-68947
   Category/ Module  :  Case Issue
   Root cause: 231030192707:This case is ready for closure
       Case closing Date - May 11 2026
       Case worker - joanna.jackson@maryland.gov
       Supervisor - sara.glover@maryland.gov
   Fix: Deleted service case, servicecasedisposition, routing and caseassginment
   Pull request# for code fix: 
   Reason why no related code fix: 
*/


update personprogramarea
set enddate ='2026-05-11 00:00:00',
updatedby='CJAMS-68947',updatedon=now()
where objectid='7abd55c8-1ff0-4392-a4fb-e7b2ab956d01' and enddate is null and activeflag=1;

update caseassignment
set enddate ='2026-05-11 00:00:00',
updatedby='CJAMS-68947',updatedon=now()
where objectid='7abd55c8-1ff0-4392-a4fb-e7b2ab956d01' and enddate is null and activeflag=1;

UPDATE servicecase 
SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2026-05-11 00:00:00', updatedby = 'CJAMS-68947',updatedon = now() 
WHERE servicecaseid = '7abd55c8-1ff0-4392-a4fb-e7b2ab956d01' and activeflag = 1;


INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date, supervisorcomment, reopenreasonkey)
VALUES(gen_random_uuid(), '7abd55c8-1ff0-4392-a4fb-e7b2ab956d01', '2026-05-11 00:00:00', 'Closed', 'Closed', 'Case is closed with ticket CJAMS-68947', '2026-05-11 00:00:00', 1, '5f10b165-2a80-494f-bd4e-e324165529d1',now(), 'CJAMS-68947', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '5f10b165-2a80-494f-bd4e-e324165529d1', '7476006c-1958-4c31-9f15-f9e6ad15dbb9', '5c0dcfd4-59bc-4280-8bc2-fd2f724389b7', 'CWCW', 'CWSP', '', 15, 0, 'CJAMS-68947',now(), 'CJAMS-68947', now(), true, 'case is closed with ticket CJAMS-68947', NULL, (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68947'), '231030192707', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '7476006c-1958-4c31-9f15-f9e6ad15dbb9', '5f10b165-2a80-494f-bd4e-e324165529d1','5c0dcfd4-59bc-4280-8bc2-fd2f724389b7', 'CWSP', 'CWCW', (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68947'), 16, 1, 'CJAMS-68947', now(), 'CJAMS-68947', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', '231030192707', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);