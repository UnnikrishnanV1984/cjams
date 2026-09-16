
/*
Issue Description:CJAMS-68045
Category/Module:Placement 
Root cause: This issue has ocuured due to a recenet SEN story implementation,Requested for datafix to close the active person programs, end date the assignmnet and insert a closure record in decision tab
Fix provided: Data fix has been done to close the case
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: 
*/


update personprogramarea
set enddate ='2026-05-28 00:00:00',
updatedby='CJAMS-68045',updatedon=now()
where objectid='fe165791-3605-4088-a005-1a7ffbfe9722' and enddate is null and activeflag=1;

update caseassignment
set enddate ='2026-05-28 00:00:00',
updatedby='CJAMS-68045',updatedon=now()
where caseassignmentid='380dc2a0-5525-4dcd-8ad1-d29ae39b5c50' and activeflag=1;

UPDATE servicecase SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2026-05-28 00:00:00', updatedby = 'CJAMS-68045',updatedon = now() 
WHERE servicecaseid = 'fe165791-3605-4088-a005-1a7ffbfe9722';


INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date, supervisorcomment, reopenreasonkey)
VALUES(gen_random_uuid(), 'fe165791-3605-4088-a005-1a7ffbfe9722', '2026-05-28 00:00:00', 'Closed', 'Closed', 'Case is closed with ticket CJAMS-68045', '2026-05-28 00:00:00', 1, '55386709-a1d8-49ee-9ee3-2fdf70cad758',now(), 'CJAMS-68045', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '55386709-a1d8-49ee-9ee3-2fdf70cad758', '040da3c2-849f-4816-9bd5-febc0649e170', '2c8afb14-eff1-49da-b1ee-926f6a9f0314', 'CWCW', 'CWSP', '', 15, 0, 'CJAMS-68045',now(), 'CJAMS-68045', now(), true, 'case is closed with ticket CJAMS-68045', NULL, (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68045'), '3271640', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '040da3c2-849f-4816-9bd5-febc0649e170', '55386709-a1d8-49ee-9ee3-2fdf70cad758','2c8afb14-eff1-49da-b1ee-926f6a9f0314', 'CWSP', 'CWCW', (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68045'), 16, 1, 'CJAMS-68045', now(), 'CJAMS-68045', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', '3271640', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);