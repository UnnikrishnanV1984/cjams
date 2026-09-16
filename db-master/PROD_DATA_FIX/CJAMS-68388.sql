/*
  Issue Description:CJAMS-68388
Category/ Module:Application
Root cause: User requested to close all the cases as they do not contain any information like person cards and those are very old cases
Fix provided: Datafix has been done to close the cases as requested by user
Is code fix required: N 
Pull request# for code fix:
Reason why no related code fix:User error
Status of the code fix if already submitted and expected prod fix date:
   Backup before update/ delete: 
*/



--20200370930 
UPDATE servicecase SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2020-02-06 15:00:00', updatedby = 'CJAMS-68388',updatedon = now() 
WHERE servicecaseid = '57d483f8-4e59-4ffc-a1ef-17f704ad366d';

INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date, supervisorcomment, reopenreasonkey)
VALUES(gen_random_uuid(), '57d483f8-4e59-4ffc-a1ef-17f704ad366d', '2020-02-06 15:00:00', 'Closed', 'Closed', 'Case is closed with ticket CJAMS-68388', '2020-02-06 15:00:00', 1, '293dc438-7f04-41f7-8845-e87304274c6c',now(), 'CJAMS-68388', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '293dc438-7f04-41f7-8845-e87304274c6c', 'cc32a738-0985-4ac9-8497-cd6b48ba2938', '267d147a-d51c-42d0-9998-90f60b8e3453', 'CWCW', 'CWSP', '', 15, 0, 'CJAMS-68388',now(), 'CJAMS-68388', now(), true, 'case is closed with ticket CJAMS-68388', NULL, (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68388'), '20200370930', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', 'cc32a738-0985-4ac9-8497-cd6b48ba2938', '293dc438-7f04-41f7-8845-e87304274c6c','267d147a-d51c-42d0-9998-90f60b8e3453', 'CWSP', 'CWCW', (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68388'), 16, 1, 'CJAMS-68388', now(), 'CJAMS-68388', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', '20200370930', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


--2020036605115

UPDATE servicecase SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2020-12-31 15:00:00', updatedby = 'CJAMS-68388',updatedon = now() 
WHERE servicecaseid = '38ce2c69-b34c-48ad-a9a7-3bf667abf8dc';

INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date, supervisorcomment, reopenreasonkey)
VALUES(gen_random_uuid(), '38ce2c69-b34c-48ad-a9a7-3bf667abf8dc', '2020-12-31 15:00:00', 'Closed', 'Closed', 'Case is closed with ticket CJAMS-68388', '2020-12-31 15:00:00', 1, '293dc438-7f04-41f7-8845-e87304274c6c',now(), 'CJAMS-68388', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '293dc438-7f04-41f7-8845-e87304274c6c', 'cc32a738-0985-4ac9-8497-cd6b48ba2938', '267d147a-d51c-42d0-9998-90f60b8e3453', 'CWCW', 'CWSP', '', 15, 0, 'CJAMS-68388',now(), 'CJAMS-68388', now(), true, 'case is closed with ticket CJAMS-68388', NULL, (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68388' and servicecaseid='38ce2c69-b34c-48ad-a9a7-3bf667abf8dc'), '2020036605115', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', 'cc32a738-0985-4ac9-8497-cd6b48ba2938', '293dc438-7f04-41f7-8845-e87304274c6c','267d147a-d51c-42d0-9998-90f60b8e3453', 'CWSP', 'CWCW', (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68388' and servicecaseid='38ce2c69-b34c-48ad-a9a7-3bf667abf8dc'), 16, 1, 'CJAMS-68388', now(), 'CJAMS-68388', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', '2020036605115', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

----231030115536

UPDATE servicecase SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2023-05-17 15:00:00', updatedby = 'CJAMS-68388',updatedon = now() 
WHERE servicecaseid = '6380727c-2a30-416c-8194-b0e425ec5775';

INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date, supervisorcomment, reopenreasonkey)
VALUES(gen_random_uuid(), '6380727c-2a30-416c-8194-b0e425ec5775', '2023-05-17 15:00:00', 'Closed', 'Closed', 'Case is closed with ticket CJAMS-68388', '2023-05-17 15:00:00', 1, '293dc438-7f04-41f7-8845-e87304274c6c',now(), 'CJAMS-68388', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '293dc438-7f04-41f7-8845-e87304274c6c', 'cc32a738-0985-4ac9-8497-cd6b48ba2938', '267d147a-d51c-42d0-9998-90f60b8e3453', 'CWCW', 'CWSP', '', 15, 0, 'CJAMS-68388',now(), 'CJAMS-68388', now(), true, 'case is closed with ticket CJAMS-68388', NULL, (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68388' and servicecaseid='6380727c-2a30-416c-8194-b0e425ec5775'), '231030115536', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', 'cc32a738-0985-4ac9-8497-cd6b48ba2938', '293dc438-7f04-41f7-8845-e87304274c6c','267d147a-d51c-42d0-9998-90f60b8e3453', 'CWSP', 'CWCW', (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68388' and servicecaseid='6380727c-2a30-416c-8194-b0e425ec5775'), 16, 1, 'CJAMS-68388', now(), 'CJAMS-68388', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', '231030115536', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

---2020013901225

UPDATE servicecase SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2020-05-18 15:00:00', updatedby = 'CJAMS-68388',updatedon = now() 
WHERE servicecaseid = '5c68d3e9-ba42-479a-b0b4-778695d6cde7';

INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date, supervisorcomment, reopenreasonkey)
VALUES(gen_random_uuid(), '5c68d3e9-ba42-479a-b0b4-778695d6cde7', '2020-05-18 15:00:00', 'Closed', 'Closed', 'Case is closed with ticket CJAMS-68388', '2020-05-18 15:00:00', 1, '293dc438-7f04-41f7-8845-e87304274c6c',now(), 'CJAMS-68388', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '293dc438-7f04-41f7-8845-e87304274c6c', 'cc32a738-0985-4ac9-8497-cd6b48ba2938', '267d147a-d51c-42d0-9998-90f60b8e3453', 'CWCW', 'CWSP', '', 15, 0, 'CJAMS-68388',now(), 'CJAMS-68388', now(), true, 'case is closed with ticket CJAMS-68388', NULL, (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68388' and servicecaseid='5c68d3e9-ba42-479a-b0b4-778695d6cde7'), '2020013901225', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', 'cc32a738-0985-4ac9-8497-cd6b48ba2938', '293dc438-7f04-41f7-8845-e87304274c6c','267d147a-d51c-42d0-9998-90f60b8e3453', 'CWSP', 'CWCW', (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68388' and servicecaseid='5c68d3e9-ba42-479a-b0b4-778695d6cde7'), 16, 1, 'CJAMS-68388', now(), 'CJAMS-68388', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', '2020013901225', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

---2020016301461

UPDATE servicecase SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2020-06-11 19:00:00', updatedby = 'CJAMS-68388',updatedon = now() 
WHERE servicecaseid = '2994612c-164e-4af5-85f2-5a418f53740b';

INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date, supervisorcomment, reopenreasonkey)
VALUES(gen_random_uuid(), '2994612c-164e-4af5-85f2-5a418f53740b', '2020-06-11 19:00:00', 'Closed', 'Closed', 'Case is closed with ticket CJAMS-68388', '2020-06-11 19:00:00', 1, '293dc438-7f04-41f7-8845-e87304274c6c',now(), 'CJAMS-68388', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '293dc438-7f04-41f7-8845-e87304274c6c', 'cc32a738-0985-4ac9-8497-cd6b48ba2938', '267d147a-d51c-42d0-9998-90f60b8e3453', 'CWCW', 'CWSP', '', 15, 0, 'CJAMS-68388',now(), 'CJAMS-68388', now(), true, 'case is closed with ticket CJAMS-68388', NULL, (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68388' and servicecaseid='2994612c-164e-4af5-85f2-5a418f53740b'), '2020016301461', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', 'cc32a738-0985-4ac9-8497-cd6b48ba2938', '293dc438-7f04-41f7-8845-e87304274c6c','267d147a-d51c-42d0-9998-90f60b8e3453', 'CWSP', 'CWCW', (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68388' and servicecaseid='2994612c-164e-4af5-85f2-5a418f53740b'), 16, 1, 'CJAMS-68388', now(), 'CJAMS-68388', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', '2020016301461', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

---202106306381
UPDATE servicecase SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2021-03-04 19:00:00', updatedby = 'CJAMS-68388',updatedon = now() 
WHERE servicecaseid = 'f8840dd7-3288-47c3-a952-34e15c07db93';

INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date, supervisorcomment, reopenreasonkey)
VALUES(gen_random_uuid(), 'f8840dd7-3288-47c3-a952-34e15c07db93', '2021-03-04 19:00:00', 'Closed', 'Closed', 'Case is closed with ticket CJAMS-68388', '2021-03-04 19:00:00', 1, '293dc438-7f04-41f7-8845-e87304274c6c',now(), 'CJAMS-68388', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '293dc438-7f04-41f7-8845-e87304274c6c', 'cc32a738-0985-4ac9-8497-cd6b48ba2938', '267d147a-d51c-42d0-9998-90f60b8e3453', 'CWCW', 'CWSP', '', 15, 0, 'CJAMS-68388',now(), 'CJAMS-68388', now(), true, 'case is closed with ticket CJAMS-68388', NULL, (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68388' and servicecaseid='f8840dd7-3288-47c3-a952-34e15c07db93'), '202106306381', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', 'cc32a738-0985-4ac9-8497-cd6b48ba2938', '293dc438-7f04-41f7-8845-e87304274c6c','267d147a-d51c-42d0-9998-90f60b8e3453', 'CWSP', 'CWCW', (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68388' and servicecaseid='f8840dd7-3288-47c3-a952-34e15c07db93'), 16, 1, 'CJAMS-68388', now(), 'CJAMS-68388', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', '202106306381', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

--211030008922

UPDATE servicecase SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2021-06-24 19:00:00', updatedby = 'CJAMS-68388',updatedon = now() 
WHERE servicecaseid = '31332f82-e58c-452c-8ad8-71357379d988';

INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date, supervisorcomment, reopenreasonkey)
VALUES(gen_random_uuid(), '31332f82-e58c-452c-8ad8-71357379d988', '2021-06-24 19:00:00', 'Closed', 'Closed', 'Case is closed with ticket CJAMS-68388', '2021-06-24 19:00:00', 1, '293dc438-7f04-41f7-8845-e87304274c6c',now(), 'CJAMS-68388', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '293dc438-7f04-41f7-8845-e87304274c6c', 'cc32a738-0985-4ac9-8497-cd6b48ba2938', '267d147a-d51c-42d0-9998-90f60b8e3453', 'CWCW', 'CWSP', '', 15, 0, 'CJAMS-68388',now(), 'CJAMS-68388', now(), true, 'case is closed with ticket CJAMS-68388', NULL, (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68388' and servicecaseid='31332f82-e58c-452c-8ad8-71357379d988'), '211030008922', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', 'cc32a738-0985-4ac9-8497-cd6b48ba2938', '293dc438-7f04-41f7-8845-e87304274c6c','267d147a-d51c-42d0-9998-90f60b8e3453', 'CWSP', 'CWCW', (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68388' and servicecaseid='31332f82-e58c-452c-8ad8-71357379d988'), 16, 1, 'CJAMS-68388', now(), 'CJAMS-68388', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', '211030008922', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


---202009901110
UPDATE servicecase SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2020-04-08 19:00:00', updatedby = 'CJAMS-68388',updatedon = now() 
WHERE servicecaseid = 'a56ddab7-6969-49e1-8cbc-31d08caf2934';

INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date, supervisorcomment, reopenreasonkey)
VALUES(gen_random_uuid(), 'a56ddab7-6969-49e1-8cbc-31d08caf2934', '2020-04-08 19:00:00', 'Closed', 'Closed', 'Case is closed with ticket CJAMS-68388', '2020-04-08 19:00:00', 1, '293dc438-7f04-41f7-8845-e87304274c6c',now(), 'CJAMS-68388', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '293dc438-7f04-41f7-8845-e87304274c6c', 'cc32a738-0985-4ac9-8497-cd6b48ba2938', '267d147a-d51c-42d0-9998-90f60b8e3453', 'CWCW', 'CWSP', '', 15, 0, 'CJAMS-68388',now(), 'CJAMS-68388', now(), true, 'case is closed with ticket CJAMS-68388', NULL, (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68388' and servicecaseid='a56ddab7-6969-49e1-8cbc-31d08caf2934'), '202009901110', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', 'cc32a738-0985-4ac9-8497-cd6b48ba2938', '293dc438-7f04-41f7-8845-e87304274c6c','267d147a-d51c-42d0-9998-90f60b8e3453', 'CWSP', 'CWCW', (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68388' and servicecaseid='a56ddab7-6969-49e1-8cbc-31d08caf2934'), 16, 1, 'CJAMS-68388', now(), 'CJAMS-68388', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', '202009901110', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


---20200450964 

UPDATE servicecase SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2020-02-14 19:00:00', updatedby = 'CJAMS-68388',updatedon = now() 
WHERE servicecaseid = '2a7e1746-099c-4d97-b810-082228881f0c';

INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date, supervisorcomment, reopenreasonkey)
VALUES(gen_random_uuid(), '2a7e1746-099c-4d97-b810-082228881f0c', '2020-02-14 19:00:00', 'Closed', 'Closed', 'Case is closed with ticket CJAMS-68388', '2020-02-14 19:00:00', 1, '293dc438-7f04-41f7-8845-e87304274c6c',now(), 'CJAMS-68388', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '293dc438-7f04-41f7-8845-e87304274c6c', 'cc32a738-0985-4ac9-8497-cd6b48ba2938', '267d147a-d51c-42d0-9998-90f60b8e3453', 'CWCW', 'CWSP', '', 15, 0, 'CJAMS-68388',now(), 'CJAMS-68388', now(), true, 'case is closed with ticket CJAMS-68388', NULL, (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68388' and servicecaseid='2a7e1746-099c-4d97-b810-082228881f0c'), '20200450964', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', 'cc32a738-0985-4ac9-8497-cd6b48ba2938', '293dc438-7f04-41f7-8845-e87304274c6c','267d147a-d51c-42d0-9998-90f60b8e3453', 'CWSP', 'CWCW', (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68388' and servicecaseid='2a7e1746-099c-4d97-b810-082228881f0c'), 16, 1, 'CJAMS-68388', now(), 'CJAMS-68388', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', '20200450964', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

--211030008234 

UPDATE servicecase SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2021-05-25 19:00:00', updatedby = 'CJAMS-68388',updatedon = now() 
WHERE servicecaseid = 'ff3236b1-06c5-4e04-89fa-15284b65b3b4';

INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date, supervisorcomment, reopenreasonkey)
VALUES(gen_random_uuid(), 'ff3236b1-06c5-4e04-89fa-15284b65b3b4', '2021-05-25 19:00:00', 'Closed', 'Closed', 'Case is closed with ticket CJAMS-68388', '2021-05-25 19:00:00', 1, '293dc438-7f04-41f7-8845-e87304274c6c',now(), 'CJAMS-68388', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '293dc438-7f04-41f7-8845-e87304274c6c', 'cc32a738-0985-4ac9-8497-cd6b48ba2938', '267d147a-d51c-42d0-9998-90f60b8e3453', 'CWCW', 'CWSP', '', 15, 0, 'CJAMS-68388',now(), 'CJAMS-68388', now(), true, 'case is closed with ticket CJAMS-68388', NULL, (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68388' and servicecaseid='ff3236b1-06c5-4e04-89fa-15284b65b3b4'), '211030008234', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', 'cc32a738-0985-4ac9-8497-cd6b48ba2938', '293dc438-7f04-41f7-8845-e87304274c6c','267d147a-d51c-42d0-9998-90f60b8e3453', 'CWSP', 'CWCW', (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68388' and servicecaseid='ff3236b1-06c5-4e04-89fa-15284b65b3b4'), 16, 1, 'CJAMS-68388', now(), 'CJAMS-68388', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', '211030008234', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

--221030018960

UPDATE servicecase SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2022-10-11 19:00:00', updatedby = 'CJAMS-68388',updatedon = now() 
WHERE servicecaseid = 'd96bec8c-4df7-4c35-b582-f553a72bb242';

INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date, supervisorcomment, reopenreasonkey)
VALUES(gen_random_uuid(), 'd96bec8c-4df7-4c35-b582-f553a72bb242', '2022-10-11 19:00:00', 'Closed', 'Closed', 'Case is closed with ticket CJAMS-68388', '2022-10-11 19:00:00', 1, '293dc438-7f04-41f7-8845-e87304274c6c',now(), 'CJAMS-68388', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', '293dc438-7f04-41f7-8845-e87304274c6c', 'cc32a738-0985-4ac9-8497-cd6b48ba2938', '267d147a-d51c-42d0-9998-90f60b8e3453', 'CWCW', 'CWSP', '', 15, 0, 'CJAMS-68388',now(), 'CJAMS-68388', now(), true, 'case is closed with ticket CJAMS-68388', NULL, (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68388' and servicecaseid='d96bec8c-4df7-4c35-b582-f553a72bb242'), '221030018960', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(gen_random_uuid(), 'SCDR', 'cc32a738-0985-4ac9-8497-cd6b48ba2938', '293dc438-7f04-41f7-8845-e87304274c6c','267d147a-d51c-42d0-9998-90f60b8e3453', 'CWSP', 'CWCW', (select servicecasedispositionid from servicecasedisposition where updatedby='CJAMS-68388' and servicecaseid='d96bec8c-4df7-4c35-b582-f553a72bb242'), 16, 1, 'CJAMS-68388', now(), 'CJAMS-68388', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', '221030018960', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

