/*
Issue Description:CJAMS-67430
Category/Module:Placement 
Root cause: Implementation of the recent SEN Untimely user story acceptance criteria logic,Requested for datafix to update 
1. Close the service case # 261030663846 on 04/20/26 with case worker name is MarissaSears and supervisor name is AprilBriddell and put the comment that the case is closed with ticket CJAMS-67430
2. Ended the worker Case Assignment.
Fix provided: Data fix has been done to close the case
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: 
*/




update caseassignment
set enddate ='2026-05-06 00:00:00.000',
updatedby='CJAMS-67430',updatedon=now()
where caseassignmentid='648afbf7-4c3b-4b3f-9d99-9463ff35fe59' and activeflag=1;

UPDATE servicecase SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2026-04-23 00:00:00', updatedby = 'CJAMS-67430',updatedon = now() 
WHERE servicecaseid = '50ef74d6-6363-44f7-9ff4-5ace6001f811';

INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date, supervisorcomment, reopenreasonkey)
VALUES(gen_random_uuid(), '50ef74d6-6363-44f7-9ff4-5ace6001f811', '2026-05-06 00:00:00.000', 'Closed', 'Closed', 'Case is closed with ticket CJAMS-67430', '2026-05-06 00:00:00.000', 1, 'd0178383-a2ad-4ea0-a5b3-da91fd0c1248',now(), 'CJAMS-67430', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', 'd0178383-a2ad-4ea0-a5b3-da91fd0c1248', 'f8ff2b3c-4ef1-452d-a465-eb73060dc870', '6b001ced-532b-4755-a0e8-5d2eb23b2bab', 'CWCW', 'CWSP', '', 15, 0, 'CJAMS-67430',now(), 'CJAMS-67430', now(), true, 'case is closed with ticket CJAMS-67430', NULL, (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-67430'), '261030666343', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', 'f8ff2b3c-4ef1-452d-a465-eb73060dc870', 'd0178383-a2ad-4ea0-a5b3-da91fd0c1248','6b001ced-532b-4755-a0e8-5d2eb23b2bab', 'CWSP', 'CWCW', (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-67430'), 16, 1, 'CJAMS-67430', now(), 'CJAMS-67430', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', '261030666343', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
