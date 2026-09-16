/*
Issue Description:CJAMS-68115
Category/Module:Placement 
Root cause: This issue has ocuured due to a recenet SEN story implementation,Requested for datafix to close the active person programs, end date the assignmnet and insert a closure record in decision tab
Fix provided: Data fix has been done to close the case
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: 
*/



update caseassignment
set enddate ='2026-05-14 19:00:00.000',
updatedby='CJAMS-68115',updatedon=now()
where caseassignmentid ='b652dbf4-049c-4ac7-a1a7-663cb781b83d' and activeflag=1;

UPDATE servicecase SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2026-05-14 19:00:00.000', updatedby = 'CJAMS-68115',updatedon = now() 
WHERE servicecaseid = 'aa3dad11-2e30-4f8e-86af-f48bdb297369';


INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date, supervisorcomment, reopenreasonkey)
VALUES(gen_random_uuid(), 'aa3dad11-2e30-4f8e-86af-f48bdb297369', '2026-05-14 19:00:00.000', 'Closed', 'Closed', 'Case is closed with ticket CJAMS-68115', '2026-05-14 19:00:00.000', 1, '8cfdea99-2e4f-41b6-9b1d-bbc29062f52e',now(), 'CJAMS-68115', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '8cfdea99-2e4f-41b6-9b1d-bbc29062f52e', '3f2b7634-387a-43ba-bcba-9500194fd70b', '7665ca54-5374-4174-be07-a687b811a82c', 'CWCW', 'CWSP', '', 15, 0, 'CJAMS-68115',now(), 'CJAMS-68115', now(), true, 'case is closed with ticket CJAMS-68115', NULL, (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68115'), '231030248210', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '3f2b7634-387a-43ba-bcba-9500194fd70b', '8cfdea99-2e4f-41b6-9b1d-bbc29062f52e','7665ca54-5374-4174-be07-a687b811a82c', 'CWSP', 'CWCW', (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68115'), 16, 1, 'CJAMS-68115', now(), 'CJAMS-68115', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', '231030248210', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);