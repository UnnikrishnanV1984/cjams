/*
Issue Description:CJAMS-69652
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
	enddate = '2026-07-20 10:00:00', 
	updatedby = 'CJAMS-69652',
	updatedon = now() 
WHERE servicecaseid = 'b13db627-802c-4654-b7bc-87a3259f3710';

update caseassignment 
set enddate ='2026-07-20 10:00:00', 
	updatedby = 'CJAMS-69652',
	updatedon = now() 
where caseassignmentid in ('afed5a52-1219-4570-9f86-179bdf3c80c4', 'e2f4bf01-5b17-42d8-bbf5-a4f18645f89f') and activeflag =1;

update personprogramarea 
set enddate ='2026-07-20 10:00:00.000', endreasonkey ='3396', updatedby ='CJAMS-69652', updatedon =now()
where objectid ='b13db627-802c-4654-b7bc-87a3259f3710' and activeflag =1 and enddate is null;

INSERT INTO servicecasedisposition
    (servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES( gen_random_uuid(), 'b13db627-802c-4654-b7bc-87a3259f3710', '2026-07-20 10:00:00', 'Closed', 'Closed','Case is closed with ticket CJAMS-69652', 
	   '2026-07-20 10:00:00', 1, 'e26beba8-b43b-42f8-9904-3e9915ee561d', now(), 'CJAMS-69652', now());
	  	  	 
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', 'e26beba8-b43b-42f8-9904-3e9915ee561d', '8f1c9fd1-05ef-4a3c-8656-508297f5e494', '34760fc4-fade-40aa-82c5-3fc8273b2dc2', 
        'CWCW', 'CWSP', '', 15, 0, 'CJAMS-69652',now(), 'CJAMS-69652', now(), true, 'case is closed with ticket CJAMS-69652', NULL, (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-69652'), '251030458330', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '8f1c9fd1-05ef-4a3c-8656-508297f5e494', 'e26beba8-b43b-42f8-9904-3e9915ee561d', '34760fc4-fade-40aa-82c5-3fc8273b2dc2', 
        'CWSP', 'CWCW', (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-69652'), 16, 1, 'CJAMS-69652', now(), 'CJAMS-69652', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', '251030458330', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);