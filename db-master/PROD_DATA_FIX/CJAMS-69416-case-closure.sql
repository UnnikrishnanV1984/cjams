/*
Issue Description:CJAMS-69416
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
	enddate = '2026-07-23 11:00:00', 
	updatedby = 'CJAMS-69416',
	updatedon = now() 
WHERE servicecaseid = '21c2ecc6-782e-4af4-86e5-aa601c831d34';

update caseassignment 
set enddate ='2026-07-23 11:00:00', 
	updatedby = 'CJAMS-69416',
	updatedon = now() 
where caseassignmentid ='bee073eb-5c67-44bd-aadd-9ab566f6ba1c' and activeflag =1;

update personprogramarea 
set enddate ='2026-07-23 00:00:00.000', endreasonkey ='3396', updatedby ='CJAMS-69416', updatedon =now()
where objectid ='21c2ecc6-782e-4af4-86e5-aa601c831d34' and activeflag =1;

INSERT INTO servicecasedisposition
    (servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES( gen_random_uuid(), '21c2ecc6-782e-4af4-86e5-aa601c831d34', '2026-07-23 11:00:00', 'Closed', 'Closed','Case is closed with ticket CJAMS-69416', 
	   '2026-07-23 11:00:00', 1, '0d8e0e71-b4a1-4938-8d0a-433530034568', now(), 'CJAMS-69416', now());
	  	  
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', 'd68ae3b2-3f7f-4b23-9233-e549224ce4e1', '7a8cd264-8789-4016-9bb1-353a27d24785', 'b8d4d6d4-bd06-4087-b38a-b085abb266db', 
        'CWCW', 'CWSP', '', 15, 0, 'CJAMS-69416',now(), 'CJAMS-69416', now(), true, 'case is closed with ticket CJAMS-69416', NULL, (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-69460'), '261030706377', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '7a8cd264-8789-4016-9bb1-353a27d24785', 'd68ae3b2-3f7f-4b23-9233-e549224ce4e1', 'b8d4d6d4-bd06-4087-b38a-b085abb266db', 
        'CWSP', 'CWCW', (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-69416'), 16, 1, 'CJAMS-69416', now(), 'CJAMS-69416', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', '261030706377', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
