/*
Issue Description:CJAMS-68973
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
	enddate = '2026-07-22 11:00:00', 
	updatedby = 'CJAMS-68973',
	updatedon = now() 
WHERE servicecaseid = '51fffadd-8128-41bb-9d23-f9bc22b349d0';

update caseassignment 
set enddate ='2026-07-22 11:00:00', 
	updatedby = 'CJAMS-68973',
	updatedon = now() 
where caseassignmentid ='62efdb90-7238-4f6b-9f2d-7da01a844dfe' and activeflag =1;

update tb_service_log 
set end_dt ='2026-07-22', end_service_reason_cd ='1824', update_user_id ='CJAMS-68973', update_ts =now()
where service_log_id = 4233360 and delete_sw = 'N' and end_dt is null;

update personprogramarea 
set enddate ='2026-07-22 00:00:00.000', endreasonkey ='3396', updatedby ='CJAMS-68973', updatedon =now()
where objectid ='51fffadd-8128-41bb-9d23-f9bc22b349d0' and personprogramid ='cd580c9a-8def-4539-b671-233558b1960f' and activeflag =1;

INSERT INTO servicecasedisposition
    (servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES( gen_random_uuid(), '51fffadd-8128-41bb-9d23-f9bc22b349d0', '2026-07-22 11:00:00', 'Closed', 'Closed','Case is closed with ticket CJAMS-68973', 
	   '2026-07-22 11:00:00', 1, '87f2acf4-c44a-49f2-84b1-08f61cef4067', now(), 'CJAMS-68973', now());
	  	  
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '87f2acf4-c44a-49f2-84b1-08f61cef4067', '5611b96f-733e-47a7-878b-f40b92d39f7c', '406c0f48-4048-490a-a834-3a00e8382e1b', 
        'CWCW', 'CWSP', '', 15, 0, 'CJAMS-68973',now(), 'CJAMS-68973', now(), true, 'case is closed with ticket CJAMS-68973', NULL, (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68973'), '3147375', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '5611b96f-733e-47a7-878b-f40b92d39f7c', '87f2acf4-c44a-49f2-84b1-08f61cef4067', '406c0f48-4048-490a-a834-3a00e8382e1b', 
        'CWSP', 'CWCW', (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68973'), 16, 1, 'CJAMS-68973', now(), 'CJAMS-68973', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', '3147375', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
