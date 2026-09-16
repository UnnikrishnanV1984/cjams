/*
Issue Description:CJAMS-69630
Category/Module:Decision 
Root cause: User requested to close the case
Fix provided: Data fix has been done to close the case
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: 
*/

UPDATE servicecase 
SET statustypekey ='Closed', 
	dispositioncode = 'Closed', 
	enddate = '2026-06-23 10:00:00', 
	updatedby = 'CJAMS-69630',
	updatedon = now() 
WHERE servicecaseid = '4134aded-c65c-4424-a30f-4ddead67d621';

update caseassignment
set enddate='2026-06-23 00:00:00', 
	updatedby='CJAMS-69630', 
	updatedon=now()
where caseassignmentid in ('cbf9ba5f-e21f-4198-a5ef-fe4b58ac69c8', '2124ac16-8659-4f75-893b-3326b7cb9dc7') and activeflag=1;

INSERT INTO servicecasedisposition
    (servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES( gen_random_uuid(), '4134aded-c65c-4424-a30f-4ddead67d621', '2026-06-23 10:00:00', 'Closed', 'Closed','Case is closed with ticket CJAMS-69630', 
	   '2026-06-23 10:00:00', 1, 'cc84a589-645c-4f6a-8f06-6909cc4c0663', now(), 'CJAMS-69630', now());
	  	  
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', 'cc84a589-645c-4f6a-8f06-6909cc4c0663', '7e1eca67-344b-454e-9e62-cd013e8d4adb', 'da48843f-614e-4b84-a629-7a07cbb51cb8', 
        'CWCW', 'CWSP', '', 15, 0, 'CJAMS-69630',now(), 'CJAMS-69630', now(), true, 'case is closed with ticket CJAMS-69630.', NULL, (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-69630'), '241030412723', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '7e1eca67-344b-454e-9e62-cd013e8d4adb', 'cc84a589-645c-4f6a-8f06-6909cc4c0663', 'da48843f-614e-4b84-a629-7a07cbb51cb8', 
        'CWSP', 'CWCW', (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-69630'), 16, 1, 'CJAMS-69630', now(), 'CJAMS-69630', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', '241030412723', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
