/*
  Issue Description:CJAMS-68384
Category/ Module:Application
Root cause: User requested to close the case as they no longer needed it and there is no data present in the case and it was created in 2020.
Fix provided: Data fix has been done to close the case
Is code fix required: N 
Pull request# for code fix:
Reason why no related code fix:user error 
Status of the code fix if already submitted and expected prod fix date:
   Backup before update/ delete: 
*/


UPDATE servicecase SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2020-05-29 00:00:00', updatedby = 'CJAMS-68384',updatedon = now() 
WHERE servicecaseid = '52b1ecd3-3d65-422a-a1fa-67b5279c178b';


INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date, supervisorcomment, reopenreasonkey)
VALUES(gen_random_uuid(), '52b1ecd3-3d65-422a-a1fa-67b5279c178b', '2020-05-29 19:00:00', 'Closed', 'Closed', 'Case is closed with ticket CJAMS-68384', '2020-05-29 19:00:00', 1, '293dc438-7f04-41f7-8845-e87304274c6c',now(), 'CJAMS-68384', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '293dc438-7f04-41f7-8845-e87304274c6c', 'cc32a738-0985-4ac9-8497-cd6b48ba2938', '267d147a-d51c-42d0-9998-90f60b8e3453', 'CWCW', 'CWSP', '', 15, 0, 'CJAMS-68384',now(), 'CJAMS-68384', now(), true, 'case is closed with ticket CJAMS-68384', NULL, (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68384'), '2020015001340', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', 'cc32a738-0985-4ac9-8497-cd6b48ba2938', '293dc438-7f04-41f7-8845-e87304274c6c','267d147a-d51c-42d0-9998-90f60b8e3453', 'CWSP', 'CWCW', (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68384'), 16, 1, 'CJAMS-68384', now(), 'CJAMS-68384', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', '2020015001340', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);