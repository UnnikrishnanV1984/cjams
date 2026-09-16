
/*
Issue Description:CJAMS-67550
Category/Module:Placement 
Root cause: This issue has ocuured due to a recenet SEN story implementation,Requested for datafix to close the active person programs, end date the assignmnet and insert a closure record in decision tab
Fix provided: Data fix has been done to close the case
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: 
*/


update personprogramarea
set enddate ='2025-12-11 00:00:00.000',
updatedby='CJAMS-67550',updatedon=now()
where personprogramid in ('9313ac22-2481-47b9-a1ea-bcf71c2c1363','2e2712ba-297f-4c08-b7ea-5233b056244c','bf834694-8bd8-4f11-842b-c914663cce66','fe83ed38-13bb-4778-b56c-5fb6b74edbc4',
'f1017b33-0fe8-487f-9087-cadbd9ad5482','2b6c4ee6-0e0b-4e7d-ae5b-74e7dab481c0') and enddate is null and activeflag=1;

update caseassignment
set enddate ='2025-12-11 00:00:00.000',
updatedby='CJAMS-67550',updatedon=now()
where caseassignmentid in ('a3bd5666-018d-47a6-93a0-ff9a91aceebd','0c3f6c77-54bc-4696-9ee4-1164c74a0445') and activeflag=1;

UPDATE servicecase SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2025-12-11 00:00:00.000', updatedby = 'CJAMS-67550',updatedon = now() 
WHERE servicecaseid = 'f288f4bb-b550-4b0f-a6e7-17df69619db0';


INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date, supervisorcomment, reopenreasonkey)
VALUES(gen_random_uuid(), 'f288f4bb-b550-4b0f-a6e7-17df69619db0', '2025-12-11 00:00:00.000', 'Closed', 'Closed', 'Case is closed with ticket CJAMS-67550', '2025-12-11 00:00:00.000', 1, '415e105c-c194-4f2a-b96f-d7f97823f0e1',now(), 'CJAMS-67550', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '415e105c-c194-4f2a-b96f-d7f97823f0e1', 'e1629c54-5b3c-4e77-ab4f-f076018d4bb1', '1b7ae41e-e77a-4a1e-a0a3-cda5292cde0b', 'CWCW', 'CWSP', '', 15, 0, 'CJAMS-67550',now(), 'CJAMS-67550', now(), true, 'case is closed with ticket CJAMS-67550', NULL, (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-67550'), '3279795', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', 'e1629c54-5b3c-4e77-ab4f-f076018d4bb1', '415e105c-c194-4f2a-b96f-d7f97823f0e1','1b7ae41e-e77a-4a1e-a0a3-cda5292cde0b', 'CWSP', 'CWCW', (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-67550'), 16, 1, 'CJAMS-67550', now(), 'CJAMS-67550', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', '3279795', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);