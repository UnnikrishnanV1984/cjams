/*
Issue Description:CJAMS-68891
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
	enddate = '2026-07-10 11:00:00', 
	updatedby = 'CJAMS-68891',
	updatedon = now() 
WHERE servicecaseid = '53c9f6b7-097f-46da-849b-746f6666b0b9';

update caseassignment 
set enddate ='2026-07-10 11:00:00', 
	updatedby = 'CJAMS-68891',
	updatedon = now() 
where caseassignmentid ='884d113d-1af8-4cbe-8c73-7efc6fe312b8' and activeflag =1;

INSERT INTO servicecasedisposition
    (servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES( gen_random_uuid(), '53c9f6b7-097f-46da-849b-746f6666b0b9', '2026-07-10 11:00:00', 'Closed', 'Closed','Case is closed with ticket CJAMS-68891', 
	   '2026-07-10 11:00:00', 1, '24c5823a-0737-4126-add0-f1cf97965dbf', now(), 'CJAMS-68891', now());
	  
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '24c5823a-0737-4126-add0-f1cf97965dbf', 'b6284b7f-7b36-46c4-8b1a-29d8d9834d8c', 'af69904f-dfd3-4793-9f07-d186f7760cb8', 'CWCW', 'CWSP', '', 15, 0, 'CJAMS-68891',now(), 'CJAMS-68891', now(), true, 'case is closed with ticket CJAMS-68891', NULL, (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68891'), '3287702', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', 'b6284b7f-7b36-46c4-8b1a-29d8d9834d8c', '24c5823a-0737-4126-add0-f1cf97965dbf','af69904f-dfd3-4793-9f07-d186f7760cb8', 'CWSP', 'CWCW', (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68891'), 16, 1, 'CJAMS-68891', now(), 'CJAMS-68891', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', '3287702', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);