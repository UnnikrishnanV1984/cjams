/* 
    Issue Description: CJAMS-67741
  Category/ Module  : Services: Service Log
  Root cause: As per system design, the service log can not be ended prior to the latest approved purchase authorization and beyond the selected client program, requested to  end the Service log as 2022-05-13
  Fix provided: Data fix has been done to end date the service log
  Is code fix required: N 
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: 
*/






update tb_service_log
set end_dt ='2022-05-13',
    update_user_id ='CJAMS-67741', 
    update_ts =now(),
    end_service_reason_cd = '1824'
where service_log_id in ('2043680') and delete_sw='N';

/*
 INSERT INTO cjams.routing
(routingstatustypeid, remarks, activeflag, routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(850, 'Returned', 1, '4f2b75f4-83a5-4f47-b67d-550be718b2b8', 'PCAUTH', '1e60bdbb-6d9e-430a-9877-3311e0ef0bd1', '36dadacc-bec3-4157-bc63-6ff67dbd5ae4', '70c5f926-488c-44ec-a363-29ab1c8bf749', 'CWSP', 'CWSP', '1833554', 850, 1, '1e60bdbb-6d9e-430a-9877-3311e0ef0bd1', '2022-05-19 08:27:00.444', '1e60bdbb-6d9e-430a-9877-3311e0ef0bd1', '2022-05-19 08:27:00.444', true, 'Returned', NULL, 'Already sent to fiancé', '3279102', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

 */

DELETE FROM cjams.routing
WHERE routingid='4f2b75f4-83a5-4f47-b67d-550be718b2b8';

/*
 INSERT INTO cjams.routing
(routingstatustypeid, remarks, activeflag, routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(850, 'Returned', 1, '21fbb5b6-2e3b-4104-bcea-b0391ec02a53', 'PCAUTHR', '2ef5fdf4-1e51-41d7-94b1-157f23f52065', '36dadacc-bec3-4157-bc63-6ff67dbd5ae4', '31eabbb0-f686-41dc-94d3-a3c26b12043a', 'CWSP', 'FNSFS', '1833554', 850, 1, '2ef5fdf4-1e51-41d7-94b1-157f23f52065', '2022-05-19 10:39:37.975', '2ef5fdf4-1e51-41d7-94b1-157f23f52065', '2022-05-19 10:39:37.975', true, 'Returned', NULL, 'Already sent to fiancé', '3279102', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/
DELETE FROM cjams.routing
WHERE routingid='21fbb5b6-2e3b-4104-bcea-b0391ec02a53';

/*
 *INSERT INTO cjams.routing
(routingstatustypeid, remarks, activeflag, routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(850, 'Returned', 1, 'e97622f0-cbd7-441a-af3a-2d548ad291ee', 'PCAUTHR', '36dadacc-bec3-4157-bc63-6ff67dbd5ae4', '36dadacc-bec3-4157-bc63-6ff67dbd5ae4', '31eabbb0-f686-41dc-94d3-a3c26b12043a', 'CWSP', 'FNSFS', '1833554', 850, 1, '36dadacc-bec3-4157-bc63-6ff67dbd5ae4', '2022-05-23 18:00:48.264', '36dadacc-bec3-4157-bc63-6ff67dbd5ae4', '2022-05-23 18:00:48.264', true, 'Returned', NULL, 'Already sent to fiancé', '3279102', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/

DELETE FROM cjams.routing
WHERE routingid='e97622f0-cbd7-441a-af3a-2d548ad291ee';

/*
 *INSERT INTO cjams.routing
(routingstatustypeid, remarks, activeflag, routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(850, 'Returned', 1, '7827b0e8-dc40-4753-9f98-41ded61b9672', 'PCAUTHR', '2e0c5cab-7b62-41ea-b505-11142d2fb04b', '36dadacc-bec3-4157-bc63-6ff67dbd5ae4', '31eabbb0-f686-41dc-94d3-a3c26b12043a', 'CWSP', 'FNSFW', '1833554', 850, 1, '2e0c5cab-7b62-41ea-b505-11142d2fb04b', '2022-05-24 17:45:44.931', '2e0c5cab-7b62-41ea-b505-11142d2fb04b', '2022-05-24 17:45:44.931', true, 'Returned', NULL, 'Already sent to fiancé', '3279102', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/

DELETE FROM cjams.routing
WHERE routingid='7827b0e8-dc40-4753-9f98-41ded61b9672';
/*
INSERT INTO cjams.routing
(routingstatustypeid, remarks, activeflag, routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(850, 'Returned', 1, '1800c05b-e6b8-4d5a-80d0-1fc491bf1a1e', 'PCAUTHR', '32414234-1c88-4bfd-b94e-7816d0003453', '36dadacc-bec3-4157-bc63-6ff67dbd5ae4', '31eabbb0-f686-41dc-94d3-a3c26b12043a', 'FNSFS', 'FNSFS', '1833554', 850, 1, '32414234-1c88-4bfd-b94e-7816d0003453', '2022-05-26 15:30:24.785', '32414234-1c88-4bfd-b94e-7816d0003453', '2022-05-26 15:30:24.785', true, 'Returned', NULL, 'Already sent to fiancé', NULL, 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/

DELETE FROM cjams.routing
WHERE routingid='1800c05b-e6b8-4d5a-80d0-1fc491bf1a1e';

/*
 INSERT INTO cjams.routing
(routingstatustypeid, remarks, activeflag, routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(850, 'Returned', 1, '8675db79-9eb2-42bb-b8c2-bf0f98d4c186', 'PCAUTHR', '36dadacc-bec3-4157-bc63-6ff67dbd5ae4', '36dadacc-bec3-4157-bc63-6ff67dbd5ae4', '31eabbb0-f686-41dc-94d3-a3c26b12043a', 'CWSP', 'FNSFS', '1833554', 850, 1, '36dadacc-bec3-4157-bc63-6ff67dbd5ae4', '2022-06-10 15:26:19.358', '36dadacc-bec3-4157-bc63-6ff67dbd5ae4', '2022-06-10 15:26:19.358', true, 'Returned', NULL, 'Already sent to fiancé', '3279102', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/

DELETE FROM cjams.routing
WHERE routingid='8675db79-9eb2-42bb-b8c2-bf0f98d4c186';

/*INSERT INTO cjams.routing
(routingstatustypeid, remarks, activeflag, routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES(850, 'Returned', 1, 'db9a4c0d-bbe3-4e51-8d54-615dc2355186', 'PCAUTHR', '36dadacc-bec3-4157-bc63-6ff67dbd5ae4', '36dadacc-bec3-4157-bc63-6ff67dbd5ae4', '31eabbb0-f686-41dc-94d3-a3c26b12043a', 'CWSP', 'FNSFS', '1833554', 850, 1, '36dadacc-bec3-4157-bc63-6ff67dbd5ae4', '2022-06-28 10:21:07.470', '36dadacc-bec3-4157-bc63-6ff67dbd5ae4', '2022-06-28 10:21:07.470', true, 'Returned', NULL, 'Already sent to fiancé', '3279102', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/

DELETE FROM cjams.routing
WHERE routingid='db9a4c0d-bbe3-4e51-8d54-615dc2355186';

update routing
set routingstatustypeid= 62,
activeflag=1,
routeddescription='Denied CJAMS-67741',
remarks='Denied',
updatedby='CJAMS-67741',
updatedon=now()
where  routingid='aa7e9138-18d7-47fa-9b5c-3591567fe612' and eventcode='PCAUTHR';