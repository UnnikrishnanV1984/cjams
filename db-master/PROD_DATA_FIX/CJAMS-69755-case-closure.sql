/*
Issue Description:CJAMS-69755
Category/Module: Decision 
Root cause: User requested to close the case
Fix provided: Data fix has been done to close the case
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: 
*/


update caseassignment
set enddate ='2026-07-15 00:00:00.000', updatedby ='CJAMS-69755', updatedon =now()
where caseassignmentid ='9f1b6e06-95f7-4c53-a98a-6c6aa6f15949' and activeflag =1;

INSERT INTO servicecasedisposition
    (servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES( gen_random_uuid(), 'e1bf4a6d-71ee-43bf-b397-0cc95cf27be7', '2026-07-15 11:00:00', 'Closed', 'Closed','Family linked to applicable community resources and supports. Services no longer needed.', 
	   '2026-07-15 11:00:00', 1, '612579c4-d4d5-4d0c-aa9b-c674a0625b80', now(), 'CJAMS-69755', now());
	  	  
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '612579c4-d4d5-4d0c-aa9b-c674a0625b80', 'b6284b7f-7b36-46c4-8b1a-29d8d9834d8c', '406c0f48-4048-490a-a834-3a00e8382e1b', 
        'CWCW', 'CWSP', (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-69755'), 15, 0, 'CJAMS-69755',now(), 'CJAMS-69755', now(), true, 'Family linked to applicable community resources and supports. Services no longer needed.', NULL, (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68973'), '3147375', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', 'b6284b7f-7b36-46c4-8b1a-29d8d9834d8c', '612579c4-d4d5-4d0c-aa9b-c674a0625b80', '406c0f48-4048-490a-a834-3a00e8382e1b', 
        'CWSP', 'CWCW', (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-69755'), 16, 1, 'CJAMS-69755', now(), 'CJAMS-69755', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', '3147375', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
