/*
Issue Description:CJAMS-67335
Category/Module:Placement 
Root cause: Requested for datafix to update 
1. Close the service case # 261030662785 on 4/23/26 with case worker name is AnnMarie Hasson and supervisor name is Nancy Haines and put the comment that the case is closed with ticket CJAMS-67335
2. Ended the IHSFP / SFCI program assignment for three person in the Active In Household
3. Move the POSC record to Historic POSC
4. Ended the worker Case Assignment.
5. Mark the client ID# 204850111 as Historic SEN
Fix provided: Data fix has been done to close the case
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: 
*/


update personprogramarea
set enddate ='2026-04-23 00:00:00',
updatedby='CJAMS-67335',updatedon=now()
where objectid='c9efedfe-ac96-4512-a2ff-90bfd9ce2ca7' and activeflag=1;

update caseassignment
set enddate ='2026-04-23 00:00:00',
updatedby='CJAMS-67335',updatedon=now()
where caseassignmentid='4016892f-b211-4f43-a312-d84756d5f146' and activeflag=1;

UPDATE servicecase SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2026-04-23 00:00:00', updatedby = 'CJAMS-67335',updatedon = now() 
WHERE servicecaseid = 'c9efedfe-ac96-4512-a2ff-90bfd9ce2ca7';

INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date, supervisorcomment, reopenreasonkey)
VALUES(gen_random_uuid(), 'c9efedfe-ac96-4512-a2ff-90bfd9ce2ca7', '2026-04-23 00:00:00', 'Closed', 'Closed', 'Case is closed with ticket CJAMS-67335', '2026-04-23 00:00:00', 1, 'e2be6d6c-d9b5-4b2b-a008-3b3a2569b270',now(), 'CJAMS-67335', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', 'e2be6d6c-d9b5-4b2b-a008-3b3a2569b270', '12d0df4a-9b22-4f4d-a654-f8ecbbb5f85f', 'b69be476-b45f-4f60-a892-e4adcc5e38e8', 'CWCW', 'CWSP', '', 15, 0, 'CJAMS-67335',now(), 'CJAMS-67335', now(), true, 'case is closed with ticket CJAMS-67335', NULL, (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-67335'), '261030662785', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '12d0df4a-9b22-4f4d-a654-f8ecbbb5f85f', 'e2be6d6c-d9b5-4b2b-a008-3b3a2569b270','b69be476-b45f-4f60-a892-e4adcc5e38e8', 'CWSP', 'CWCW', (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-67335'), 16, 1, 'CJAMS-67335', now(), 'CJAMS-67335', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', '261030662785', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);