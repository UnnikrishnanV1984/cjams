/*
Issue Description:CJAMS-69460
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
	enddate = '2026-07-25 11:00:00', 
	updatedby = 'CJAMS-69460',
	updatedon = now() 
WHERE servicecaseid = '6c0ff6fe-0aee-4049-8d05-97f261a31cff';

update caseassignment 
set enddate ='2026-07-25 11:00:00', 
	updatedby = 'CJAMS-69460',
	updatedon = now() 
where caseassignmentid in ('3f98f2fe-f663-4413-a143-d0788dae15e9', 'c8e73795-ad31-4fd6-91c9-455af0b95c60') and activeflag =1;

update personprogramarea 
set enddate ='2026-07-25 00:00:00.000', endreasonkey ='3396', updatedby ='CJAMS-69460', updatedon =now()
where objectid ='6c0ff6fe-0aee-4049-8d05-97f261a31cff'  and activeflag =1;

INSERT INTO servicecasedisposition
    (servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES( gen_random_uuid(), '6c0ff6fe-0aee-4049-8d05-97f261a31cff', '2026-07-25 11:00:00', 'Closed', 'Closed','Case is closed with ticket CJAMS-69460', 
	   '2026-07-25 11:00:00', 1, '0d8e0e71-b4a1-4938-8d0a-433530034568', now(), 'CJAMS-69460', now());
	  	  
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '0d8e0e71-b4a1-4938-8d0a-433530034568', '732b097a-2a84-4c37-9851-8673d5a55da9', '98d369d5-c38d-4fc2-865b-87b2f5df4343', 
        'CWCW', 'CWSP', '', 15, 0, 'CJAMS-69460',now(), 'CJAMS-69460', now(), true, 'case is closed with ticket CJAMS-69460', NULL, (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-69460'), '3290576', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '732b097a-2a84-4c37-9851-8673d5a55da9', '0d8e0e71-b4a1-4938-8d0a-433530034568', '98d369d5-c38d-4fc2-865b-87b2f5df4343', 
        'CWSP', 'CWCW', (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-69460'), 16, 1, 'CJAMS-69460', now(), 'CJAMS-69460', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', '3290576', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
