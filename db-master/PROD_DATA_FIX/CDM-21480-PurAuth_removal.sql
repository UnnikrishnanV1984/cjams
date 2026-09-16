/*
   Issue Description: CDM-21480
   Category/ Module  : purchase auth won't go away
   Root cause: Case shows pending in approval box
   Pull request# for code fix:  N/A
   Reason why no related code fix:  N/A
   Status of the code fix if already submitted and expected prod fix date: 

  select * FROM cjams.routing 
 where objectid = '1823233' 
and routingid  in (
'52321bea-9d0a-4b9c-b15d-f27a37cbc755',
'fe8e3006-353e-40d3-abbe-3b429d9b15c6',
'9b195c12-79b3-44c2-a4e2-494990ba5a8a',
'a3855fbf-a79c-4866-b95a-2608fe6728bd',
'81bb9df3-330d-41a1-b5c9-f354266d49de',
'3832724d-b72b-49ec-9bc0-085cc450739e',
'ca1bff40-3302-451c-9830-56fcc163ca83',
'b1ad38a3-5c7b-400c-9fb9-2b3f2c6b5e6e',
'29fc5d9e-ab0d-4542-8995-3253a95730fd',
'0cfce3e0-062d-42c0-9d50-3b0c1b49859e',
'5d761f91-3080-42f6-b3ca-26c9c93fad1a'
);

  INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('52321bea-9d0a-4b9c-b15d-f27a37cbc755'::uuid, 'PCAUTHR', 'e12d7ff7-c158-45bd-8d59-b84e4485616d', '2744efa4-8129-48fb-b292-7c4351f66f89', 'af5a6281-0f7c-497b-a592-60b6359794c6'::uuid, 'CWSP', 'FNSFS', '1823233', 43, 1, 'e12d7ff7-c158-45bd-8d59-b84e4485616d', '2022-03-15 12:56:08.311', 'e12d7ff7-c158-45bd-8d59-b84e4485616d', '2022-03-15 12:56:08.311', true, 'Approved', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3051072', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('5d761f91-3080-42f6-b3ca-26c9c93fad1a'::uuid, 'PCAUTHR', 'da23f52d-6348-413b-9e37-0de2ab823825', 'e12d7ff7-c158-45bd-8d59-b84e4485616d', 'e333583f-22b4-4f56-b43b-9ec4b0c99f8e'::uuid, 'CWSP', 'CWSP', '1823233', 42, 1, 'da23f52d-6348-413b-9e37-0de2ab823825', '2022-03-15 11:57:35.381', 'da23f52d-6348-413b-9e37-0de2ab823825', '2022-03-15 11:57:35.381', true, 'Forwarded to Director Approval', NULL, 'Purchase Authorization Forwarded to Director Approval', '3051072', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('fe8e3006-353e-40d3-abbe-3b429d9b15c6'::uuid, 'PCAUTHR', 'e12d7ff7-c158-45bd-8d59-b84e4485616d', '2744efa4-8129-48fb-b292-7c4351f66f89', 'af5a6281-0f7c-497b-a592-60b6359794c6'::uuid, 'CWSP', 'FNSFS', '1823233', 43, 1, 'e12d7ff7-c158-45bd-8d59-b84e4485616d', '2022-03-15 12:58:07.122', 'e12d7ff7-c158-45bd-8d59-b84e4485616d', '2022-03-15 12:58:07.122', true, 'Approved', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3051072', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('9b195c12-79b3-44c2-a4e2-494990ba5a8a'::uuid, 'PCAUTHR', 'e12d7ff7-c158-45bd-8d59-b84e4485616d', '2744efa4-8129-48fb-b292-7c4351f66f89', 'af5a6281-0f7c-497b-a592-60b6359794c6'::uuid, 'CWSP', 'FNSFS', '1823233', 43, 1, 'e12d7ff7-c158-45bd-8d59-b84e4485616d', '2022-03-15 12:59:00.378', 'e12d7ff7-c158-45bd-8d59-b84e4485616d', '2022-03-15 12:59:00.378', true, 'Approved', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3051072', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('a3855fbf-a79c-4866-b95a-2608fe6728bd'::uuid, 'PCAUTHR', 'e12d7ff7-c158-45bd-8d59-b84e4485616d', '2744efa4-8129-48fb-b292-7c4351f66f89', 'af5a6281-0f7c-497b-a592-60b6359794c6'::uuid, 'CWSP', 'FNSFS', '1823233', 43, 1, 'e12d7ff7-c158-45bd-8d59-b84e4485616d', '2022-03-15 12:56:40.684', 'e12d7ff7-c158-45bd-8d59-b84e4485616d', '2022-03-15 12:56:40.684', true, 'Approved', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3051072', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('81bb9df3-330d-41a1-b5c9-f354266d49de'::uuid, 'PCAUTHR', 'e12d7ff7-c158-45bd-8d59-b84e4485616d', '2744efa4-8129-48fb-b292-7c4351f66f89', 'af5a6281-0f7c-497b-a592-60b6359794c6'::uuid, 'CWSP', 'FNSFS', '1823233', 43, 1, 'e12d7ff7-c158-45bd-8d59-b84e4485616d', '2022-03-15 12:57:21.548', 'e12d7ff7-c158-45bd-8d59-b84e4485616d', '2022-03-15 12:57:21.548', true, 'Approved', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3051072', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('3832724d-b72b-49ec-9bc0-085cc450739e'::uuid, 'PCAUTHR', 'e12d7ff7-c158-45bd-8d59-b84e4485616d', '2744efa4-8129-48fb-b292-7c4351f66f89', 'af5a6281-0f7c-497b-a592-60b6359794c6'::uuid, 'CWSP', 'FNSFS', '1823233', 43, 1, 'e12d7ff7-c158-45bd-8d59-b84e4485616d', '2022-03-17 13:43:08.350', 'e12d7ff7-c158-45bd-8d59-b84e4485616d', '2022-03-17 13:43:08.350', true, 'Approved', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3051072', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('ca1bff40-3302-451c-9830-56fcc163ca83'::uuid, 'PCAUTHR', 'e12d7ff7-c158-45bd-8d59-b84e4485616d', '2744efa4-8129-48fb-b292-7c4351f66f89', 'af5a6281-0f7c-497b-a592-60b6359794c6'::uuid, 'CWSP', 'FNSFS', '1823233', 43, 1, 'e12d7ff7-c158-45bd-8d59-b84e4485616d', '2022-03-17 13:43:48.684', 'e12d7ff7-c158-45bd-8d59-b84e4485616d', '2022-03-17 13:43:48.684', true, 'Approved', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3051072', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('b1ad38a3-5c7b-400c-9fb9-2b3f2c6b5e6e'::uuid, 'PCAUTHR', 'e12d7ff7-c158-45bd-8d59-b84e4485616d', '2744efa4-8129-48fb-b292-7c4351f66f89', 'af5a6281-0f7c-497b-a592-60b6359794c6'::uuid, 'CWSP', 'FNSFS', '1823233', 43, 1, 'e12d7ff7-c158-45bd-8d59-b84e4485616d', '2022-03-17 13:44:26.581', 'e12d7ff7-c158-45bd-8d59-b84e4485616d', '2022-03-17 13:44:26.581', true, 'Approved', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3051072', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('29fc5d9e-ab0d-4542-8995-3253a95730fd'::uuid, 'PCAUTHR', 'e12d7ff7-c158-45bd-8d59-b84e4485616d', '2744efa4-8129-48fb-b292-7c4351f66f89', 'af5a6281-0f7c-497b-a592-60b6359794c6'::uuid, 'CWSP', 'FNSFS', '1823233', 43, 1, 'e12d7ff7-c158-45bd-8d59-b84e4485616d', '2022-03-17 13:45:09.055', 'e12d7ff7-c158-45bd-8d59-b84e4485616d', '2022-03-17 13:45:09.055', true, 'Approved', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3051072', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('0cfce3e0-062d-42c0-9d50-3b0c1b49859e'::uuid, 'PCAUTHR', 'e12d7ff7-c158-45bd-8d59-b84e4485616d', '2744efa4-8129-48fb-b292-7c4351f66f89', 'af5a6281-0f7c-497b-a592-60b6359794c6'::uuid, 'CWSP', 'FNSFS', '1823233', 43, 1, 'e12d7ff7-c158-45bd-8d59-b84e4485616d', '2022-03-17 13:45:55.154', 'e12d7ff7-c158-45bd-8d59-b84e4485616d', '2022-03-17 13:45:55.154', true, 'Approved', NULL, 'Purchase Authorization Forwarded to Funding Approval', '3051072', 'ServiceCase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
 
*/

DELETE FROM cjams.routing 
 where objectid = '1823233' 
and routingid  in (
'52321bea-9d0a-4b9c-b15d-f27a37cbc755',
'fe8e3006-353e-40d3-abbe-3b429d9b15c6',
'9b195c12-79b3-44c2-a4e2-494990ba5a8a',
'a3855fbf-a79c-4866-b95a-2608fe6728bd',
'81bb9df3-330d-41a1-b5c9-f354266d49de',
'3832724d-b72b-49ec-9bc0-085cc450739e',
'ca1bff40-3302-451c-9830-56fcc163ca83',
'b1ad38a3-5c7b-400c-9fb9-2b3f2c6b5e6e',
'29fc5d9e-ab0d-4542-8995-3253a95730fd',
'0cfce3e0-062d-42c0-9d50-3b0c1b49859e',
'5d761f91-3080-42f6-b3ca-26c9c93fad1a'
);