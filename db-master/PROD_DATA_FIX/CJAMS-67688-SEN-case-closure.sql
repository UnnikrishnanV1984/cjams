/*
  Issue Description:  CJAMS-67688
   Category/ Module: Close case
   Root cause:  1. Close the service case # 261030684250 on 5/4/2026 with case worker name is Tracey Hongtong and supervisor name is Amanda Reiblich and put the comment that the case is closed with ticket CJAMS-67688
                2. End the worker Case Assignment.
                3. Mark the client ID# 204894515 as Historic SEN
   Fix Provided: Data fix has been provided by deleting the close case.
   Pull request# for code fix: 
   Reason why no related code fix:NA 
*/

update personprogramarea
set enddate ='2026-05-04 13:00:00',
updatedby='CJAMS-67688',updatedon=now()
where objectid='aa1f5209-84e6-4296-9423-8707f39d4f9d' and enddate is null and activeflag=1;

update caseassignment
set enddate ='2026-05-04 13:00:00',
updatedby='CJAMS-67688',updatedon=now()
where caseassignmentid='41ec8a43-2d59-4820-b1ff-a9ba427f4b8b' and activeflag=1;

UPDATE servicecase SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2026-05-04 13:00:00', updatedby = 'CJAMS-67688',updatedon = now() 
WHERE servicecaseid = 'aa1f5209-84e6-4296-9423-8707f39d4f9d';

INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date, supervisorcomment, reopenreasonkey)
VALUES(gen_random_uuid(), 'aa1f5209-84e6-4296-9423-8707f39d4f9d', '2026-05-04 13:00:00', 'Closed', 'Closed', 'Case is closed with ticket CJAMS-67688', '2026-05-04 13:00:00', 1, 'fa738012-2613-4ad2-bec2-5178d67a76b6',now(), 'CJAMS-67688', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', 'fa738012-2613-4ad2-bec2-5178d67a76b6', '8cb570ed-39e2-4a95-8089-76f5951d3c33', 'd53e2cfe-d831-40a7-bcf1-73670c0293db', 'CWCW', 'CWSP', '', 15, 0, 'CJAMS-67688',now(), 'CJAMS-67688', now(), true, 'case is closed with ticket CJAMS-67688', NULL, (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-67688'), '261030684250', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '8cb570ed-39e2-4a95-8089-76f5951d3c33', 'fa738012-2613-4ad2-bec2-5178d67a76b6','d53e2cfe-d831-40a7-bcf1-73670c0293db', 'CWSP', 'CWCW', (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-67688'), 16, 1, 'CJAMS-67688', now(), 'CJAMS-67688', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', '261030684250', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
