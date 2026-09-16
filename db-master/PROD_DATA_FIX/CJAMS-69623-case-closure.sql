/*
Issue Description:CJAMS-69623
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
	enddate = '2026-07-23 10:00:00', 
	updatedby = 'CJAMS-69623',
	updatedon = now() 
WHERE servicecaseid = '097990aa-8807-46df-83ab-d7be7d132c58';

update caseassignment
set enddate='2026-07-23 00:00:00', 
	updatedby='CJAMS-69623', 
	updatedon=now()
where caseassignmentid in ('47a23ba5-735f-46bd-9eee-eb58eed2ac57', 'b1f452f7-4c9b-47b8-b004-61d45d20637f') and activeflag=1;

INSERT INTO servicecasedisposition
    (servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES( gen_random_uuid(), '097990aa-8807-46df-83ab-d7be7d132c58', '2026-07-23 10:00:00', 'Closed', 'Closed','ROA- The youth made a plan to go with a relative in Texas. The Department helped facilitate this plan.', 
	   '2026-07-23 10:00:00', 1, '7037411b-2b8a-4297-9a47-e2c2add5e857', now(), 'CJAMS-69623', now());
	  	  
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '7037411b-2b8a-4297-9a47-e2c2add5e857', '9ebab84a-8f1d-4e43-9456-e1873e286808', '2083200e-1403-4c14-8788-0a6937c2122f', 
        'CWCW', 'CWSP', '', 15, 0, 'CJAMS-69623',now(), 'CJAMS-69623', now(), true, 'ROA- The youth made a plan to go with a relative in Texas. The Department helped facilitate this plan.', NULL, (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-69623'), '241030268009', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '9ebab84a-8f1d-4e43-9456-e1873e286808', '7037411b-2b8a-4297-9a47-e2c2add5e857', '2083200e-1403-4c14-8788-0a6937c2122f', 
        'CWSP', 'CWCW', (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-69623'), 16, 1, 'CJAMS-69623', now(), 'CJAMS-69623', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', '241030268009', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
