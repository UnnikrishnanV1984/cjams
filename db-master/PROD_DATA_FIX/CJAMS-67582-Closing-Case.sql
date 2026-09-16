/*
  Issue Description:  CJAMS-67582
   Category/ Module: Close case
   Root cause:  User expecting it the close the case by April 30th 2026 as user does not want to create contact Note , case worker as Ebony - supervisor Heidi Dearo, pls mention the comment that ticket is closed with this ticket 

      Please end case worker assignment 

      4443640 - CJAMS PID - Child with SEN history
   Fix Provided: Data fix has been provided by deleting the close case.
   Pull request# for code fix: 
   Reason why no related code fix:NA 
*/

update personprogramarea
set enddate ='2026-04-30 13:00:00',
updatedby='CJAMS-67582',updatedon=now()
where objectid='b744c538-4af7-4f78-a27e-f35fe4b87bcc' and enddate is null and activeflag=1;

update caseassignment
set enddate ='2026-04-30 13:00:00',
updatedby='CJAMS-67582',updatedon=now()
where caseassignmentid='e286f2b2-84b2-4fa7-bfaa-21f3279abe6e' and activeflag=1;

UPDATE servicecase SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2026-04-30 13:00:00', updatedby = 'CJAMS-67582',updatedon = now() 
WHERE servicecaseid = 'b744c538-4af7-4f78-a27e-f35fe4b87bcc';

INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date, supervisorcomment, reopenreasonkey)
VALUES(gen_random_uuid(), 'b744c538-4af7-4f78-a27e-f35fe4b87bcc', '2026-04-30 13:00:00', 'Closed', 'Closed', 'Case is closed with ticket CJAMS-67582', '2026-04-30 13:00:00', 1, '7ff02332-c363-4dd1-8840-600a3426e252',now(), 'CJAMS-67582', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '7ff02332-c363-4dd1-8840-600a3426e252', '7a8cd264-8789-4016-9bb1-353a27d24785', 'b8d4d6d4-bd06-4087-b38a-b085abb266db', 'CWCW', 'CWSP', '', 15, 0, 'CJAMS-67582',now(), 'CJAMS-67582', now(), true, 'case is closed with ticket CJAMS-67582', NULL, (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-67582'), '3292111', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '7a8cd264-8789-4016-9bb1-353a27d24785', '7ff02332-c363-4dd1-8840-600a3426e252','b8d4d6d4-bd06-4087-b38a-b085abb266db', 'CWSP', 'CWCW', (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-67582'), 16, 1, 'CJAMS-67582', now(), 'CJAMS-67582', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', '3292111', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);