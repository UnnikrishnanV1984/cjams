/*
 Issue description : GAP payment issue due to death of primary caregiver
 Root cause : User error, Data fix is done to Re-open the suspensions for both the clients,Delete all Account receivables of the old provider (Suzian Taylor / ID# 5065393), Feb, March and April payments,
              Remove the latest new provider (Edward Taylor / ID# 6301138) subsidy rate slab,  Revert the GAP application to old provider (Suzian Taylor / ID: 5065393)
 Fix provided: Data fix is done to re open the suspensions, Delete Account receivables , removed latest subsidy rate slab and reverted gap application.
 Is code fix required : N 
 Why no code fix is required : Data correction is needed
 */


-- 3472547    AUSTIN    JAMESON    TAYLOR    1e6cd52d-97a5-472b-96ee-3db815c69276

update gapsuspension
set enddate  = null, updatedby  = 'CJAMS-68730', updatedon  = now()
where gapsuspensionid  = '754d3e96-0cee-4001-9441-bd7edd8861f2' ;

update cjams.gapsuspensionrevision
set enddate  = null, updatedby  = 'CJAMS-68730', updatedon  = now()
where gapsuspensionrevisionid in  (
'd2a0a8b2-ee88-4fb6-84cd-e581a24452fd',
'5af1c068-7c6f-490a-ac0f-eca5b89f3872');

DELETE FROM cjams.routing
WHERE routingid='080f74f6-2158-41aa-8e83-9f81abdf02c1'::uuid;
DELETE FROM cjams.routing
WHERE routingid='1345dab8-b8c1-4dc7-b560-f3707348c8aa'::uuid;
DELETE FROM cjams.routing
WHERE routingid='61c07c24-dca9-42a1-a889-1a1d477ff50b'::uuid;
DELETE FROM cjams.routing
WHERE routingid='37c6c7c6-988a-4f8d-88a8-9ee5bc6d2eb2'::uuid;
DELETE FROM cjams.routing
WHERE routingid='48c58f53-ade7-4338-9cf8-754105e3f439'::uuid;
DELETE FROM cjams.routing
WHERE routingid='3989cd0c-bf13-49c2-bbe7-52e8f64fb12d'::uuid;
DELETE FROM cjams.routing
WHERE routingid='21643423-d9ec-4386-a9ec-eae5c46e45c8'::uuid;
DELETE FROM cjams.routing
WHERE routingid='61fca402-7d70-412a-874b-07a1ea56ea56'::uuid;
DELETE FROM cjams.routing
WHERE routingid='b202f3e7-6b4e-4293-b4e2-480feaf9475d'::uuid;
DELETE FROM cjams.routing
WHERE routingid='f7538d31-b120-4016-8ad4-aac9056e5e8d'::uuid;

DELETE FROM cjams.gapsuspensionrevision
WHERE gapsuspensionrevisionid='e6636cb1-6a97-4a79-a7a0-4283b1cc1184'::uuid;
DELETE FROM cjams.gapsuspensionrevision
WHERE gapsuspensionrevisionid='68bd8bbf-9f36-4273-8309-0b04b79a35bd'::uuid;
DELETE FROM cjams.gapsuspensionrevision
WHERE gapsuspensionrevisionid='77db93dc-1cad-43a6-8238-80a05b16153b'::uuid;
DELETE FROM cjams.gapsuspensionrevision
WHERE gapsuspensionrevisionid='2470e476-e4d7-4c25-adfd-95c56d9af98f'::uuid;
DELETE FROM cjams.gapsuspensionrevision
WHERE gapsuspensionrevisionid='197991b3-d093-422f-9c86-abdd5072fc95'::uuid;
DELETE FROM cjams.gapsuspensionrevision
WHERE gapsuspensionrevisionid='5af1c068-7c6f-490a-ac0f-eca5b89f3872'::uuid;


DELETE FROM cjams.gapsuspension
WHERE gapsuspensionid='f1c62551-5a28-431b-b6e1-8766faa534da'::uuid;
DELETE FROM cjams.gapsuspension
WHERE gapsuspensionid='530ba711-8a14-4d16-99aa-1b132ac42054'::uuid;
DELETE FROM cjams.gapsuspension
WHERE gapsuspensionid='928a1b98-3ef6-439d-b1b3-2db98ef2764e'::uuid;
DELETE FROM cjams.gapsuspension
WHERE gapsuspensionid='5bbbeba4-ddb8-4c48-8967-2569c2f36ed9'::uuid;
DELETE FROM cjams.gapsuspension
WHERE gapsuspensionid='6493b130-b4b7-46a6-9bd2-d2fd39123de3'::uuid;


/*

INSERT INTO cjams.gapsuspension
(gapsuspensionid, gapid, suspensionreasontypekey, startdate, enddate, notes, isdraft, suspensiondesc, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id, otherreason, alternateid, approvalstatustypekey, etl_userid, etl_load_date)
VALUES('f1c62551-5a28-431b-b6e1-8766faa534da'::uuid, 'e0719a38-41e7-4224-b3ff-0d6870871b08'::uuid, 'OT', '2026-04-30 04:00:00.000', NULL, '', 123, '', 0, '2026-05-14 14:32:29.000', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '2026-05-14 14:32:29.000', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '2026-05-14 14:38:46.956', NULL, 'primary provider Suzian Taylor passed 1/11/2026; pd until 4/30/2026 ', 1036118, '3045', NULL, NULL);
INSERT INTO cjams.gapsuspension
(gapsuspensionid, gapid, suspensionreasontypekey, startdate, enddate, notes, isdraft, suspensiondesc, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id, otherreason, alternateid, approvalstatustypekey, etl_userid, etl_load_date)
VALUES('530ba711-8a14-4d16-99aa-1b132ac42054'::uuid, 'e0719a38-41e7-4224-b3ff-0d6870871b08'::uuid, 'OT', '2026-04-30 04:00:00.000', NULL, '', 123, '', 0, '2026-05-14 14:32:29.000', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '2026-05-14 14:38:46.956', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '2026-05-14 14:53:53.397', NULL, 'primary provider Suzian Taylor passed 1/11/2026; pd until 4/30/2026 ', 1036151, '3047', NULL, NULL);
INSERT INTO cjams.gapsuspension
(gapsuspensionid, gapid, suspensionreasontypekey, startdate, enddate, notes, isdraft, suspensiondesc, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id, otherreason, alternateid, approvalstatustypekey, etl_userid, etl_load_date)
VALUES('928a1b98-3ef6-439d-b1b3-2db98ef2764e'::uuid, 'e0719a38-41e7-4224-b3ff-0d6870871b08'::uuid, 'OT', '2026-04-30 04:00:00.000', '2026-04-30 04:00:00.000', '', 123, '', 1, '2026-05-14 14:32:29.000', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '2026-05-14 14:53:53.397', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '2026-05-14 14:53:53.397', NULL, 'primary provider Suzian Taylor passed 1/11/2026; pd until 4/30/2026 ', 1036186, '3047', NULL, NULL);
INSERT INTO cjams.gapsuspension
(gapsuspensionid, gapid, suspensionreasontypekey, startdate, enddate, notes, isdraft, suspensiondesc, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id, otherreason, alternateid, approvalstatustypekey, etl_userid, etl_load_date)
VALUES('5bbbeba4-ddb8-4c48-8967-2569c2f36ed9'::uuid, 'e0719a38-41e7-4224-b3ff-0d6870871b08'::uuid, 'OT', '2026-02-01 05:00:00.000', NULL, '', 123, '', 0, '2026-07-17 15:30:14.000', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '2026-07-17 15:30:14.000', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '2026-07-17 15:32:22.870', NULL, 'death of primary Suzian Taylor', 1038103, '3045', NULL, NULL);
INSERT INTO cjams.gapsuspension
(gapsuspensionid, gapid, suspensionreasontypekey, startdate, enddate, notes, isdraft, suspensiondesc, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id, otherreason, alternateid, approvalstatustypekey, etl_userid, etl_load_date)
VALUES('6493b130-b4b7-46a6-9bd2-d2fd39123de3'::uuid, 'e0719a38-41e7-4224-b3ff-0d6870871b08'::uuid, 'OT', '2026-02-01 05:00:00.000', NULL, '', 123, '', 0, '2026-07-17 15:30:14.000', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '2026-07-17 15:32:22.870', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '2026-07-20 08:44:41.531', NULL, 'death of primary Suzian Taylor', 1038106, '3047', NULL, NULL);


INSERT INTO cjams.gapsuspensionrevision
(startdate, enddate, approvalstatustypekey, activeflag, gapsuspensionrevisionid, suspensionid, guardiansubsidyid, transactiondate, reasontypekey, startdate, enddate, suspensiondesc, approvalstatustypekey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, etl_userid, etl_load_date)
VALUES('2026-04-30 04:00:00.000', NULL, '3045', 0, 'e6636cb1-6a97-4a79-a7a0-4283b1cc1184'::uuid, 'f1c62551-5a28-431b-b6e1-8766faa534da'::uuid, 'e0719a38-41e7-4224-b3ff-0d6870871b08'::uuid, '2026-05-14 00:00:00.000', 'OT', '2026-04-30 04:00:00.000', NULL, '', '3045', '2026-05-14 00:00:00.000', NULL, '2026-05-14 14:32:29.000', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '2026-05-14 00:00:00.000', NULL, 0, 1042534, NULL, NULL);
INSERT INTO cjams.gapsuspensionrevision
(startdate, enddate, approvalstatustypekey, activeflag, gapsuspensionrevisionid, suspensionid, guardiansubsidyid, transactiondate, reasontypekey, startdate, enddate, suspensiondesc, approvalstatustypekey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, etl_userid, etl_load_date)
VALUES('2026-04-30 04:00:00.000', NULL, '3047', 0, '68bd8bbf-9f36-4273-8309-0b04b79a35bd'::uuid, '530ba711-8a14-4d16-99aa-1b132ac42054'::uuid, 'e0719a38-41e7-4224-b3ff-0d6870871b08'::uuid, '2026-05-14 00:00:00.000', 'OT', '2026-04-30 04:00:00.000', NULL, '', '3047', '2026-05-14 00:00:00.000', NULL, '2026-05-14 14:38:46.956', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '2026-05-14 00:00:00.000', NULL, 0, 1042567, NULL, NULL);
INSERT INTO cjams.gapsuspensionrevision
(startdate, enddate, approvalstatustypekey, activeflag, gapsuspensionrevisionid, suspensionid, guardiansubsidyid, transactiondate, reasontypekey, startdate, enddate, suspensiondesc, approvalstatustypekey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, etl_userid, etl_load_date)
VALUES('2026-04-30 04:00:00.000', '2026-04-30 04:00:00.000', '3045', 0, '77db93dc-1cad-43a6-8238-80a05b16153b'::uuid, '530ba711-8a14-4d16-99aa-1b132ac42054'::uuid, 'e0719a38-41e7-4224-b3ff-0d6870871b08'::uuid, '2026-05-14 00:00:00.000', 'OT', '2026-04-30 04:00:00.000', '2026-04-30 04:00:00.000', '', '3045', '2026-05-14 00:00:00.000', NULL, '2026-05-14 14:53:01.000', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '2026-05-14 00:00:00.000', NULL, 0, 1042601, NULL, NULL);
INSERT INTO cjams.gapsuspensionrevision
(startdate, enddate, approvalstatustypekey, activeflag, gapsuspensionrevisionid, suspensionid, guardiansubsidyid, transactiondate, reasontypekey, startdate, enddate, suspensiondesc, approvalstatustypekey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, etl_userid, etl_load_date)
VALUES('2026-04-30 04:00:00.000', '2026-04-30 04:00:00.000', '3047', 0, '2470e476-e4d7-4c25-adfd-95c56d9af98f'::uuid, '928a1b98-3ef6-439d-b1b3-2db98ef2764e'::uuid, 'e0719a38-41e7-4224-b3ff-0d6870871b08'::uuid, '2026-05-14 00:00:00.000', 'OT', '2026-04-30 04:00:00.000', '2026-04-30 04:00:00.000', '', '3047', '2026-05-14 00:00:00.000', NULL, '2026-05-14 14:53:53.397', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '2026-05-14 14:53:53.397', NULL, 0, 1042604, NULL, NULL);
INSERT INTO cjams.gapsuspensionrevision
(startdate, enddate, approvalstatustypekey, activeflag, gapsuspensionrevisionid, suspensionid, guardiansubsidyid, transactiondate, reasontypekey, startdate, enddate, suspensiondesc, approvalstatustypekey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, etl_userid, etl_load_date)
VALUES('2026-02-01 05:00:00.000', NULL, '3045', 0, '197991b3-d093-422f-9c86-abdd5072fc95'::uuid, '5bbbeba4-ddb8-4c48-8967-2569c2f36ed9'::uuid, 'e0719a38-41e7-4224-b3ff-0d6870871b08'::uuid, '2026-07-17 00:00:00.000', 'OT', '2026-02-01 05:00:00.000', NULL, '', '3045', '2026-07-17 00:00:00.000', NULL, '2026-07-17 15:30:14.000', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '2026-07-17 00:00:00.000', NULL, 0, 1044754, NULL, NULL);
INSERT INTO cjams.gapsuspensionrevision
(startdate, enddate, approvalstatustypekey, activeflag, gapsuspensionrevisionid, suspensionid, guardiansubsidyid, transactiondate, reasontypekey, startdate, enddate, suspensiondesc, approvalstatustypekey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, etl_userid, etl_load_date)
VALUES('2026-02-01 05:00:00.000', NULL, '3047', 0, '5af1c068-7c6f-490a-ac0f-eca5b89f3872'::uuid, '6493b130-b4b7-46a6-9bd2-d2fd39123de3'::uuid, 'e0719a38-41e7-4224-b3ff-0d6870871b08'::uuid, '2026-07-20 00:00:00.000', 'OT', '2026-02-01 05:00:00.000', NULL, '', '3047', '2026-07-20 00:00:00.000', NULL, '2026-07-17 15:32:22.870', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '2026-07-20 00:00:00.000', NULL, 0, 1044757, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('080f74f6-2158-41aa-8e83-9f81abdf02c1'::uuid, 'GASR', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '47194b3d-bf52-416c-a53b-82888c49d6a2', '70f4ac2b-41f6-49db-a5ba-65e5eacf6b3d'::uuid, 'CWSP', 'CWSP', 'f1c62551-5a28-431b-b6e1-8766faa534da', 15, 0, 'ee86845e-ead2-420b-898f-66b4dd207f4e', '2026-05-14 14:32:28.795', '47194b3d-bf52-416c-a53b-82888c49d6a2', '2026-05-14 14:38:46.956', true, 'Guardianship Suspension Submitted for review', NULL, '', '3215426', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('1345dab8-b8c1-4dc7-b560-f3707348c8aa'::uuid, 'GASR', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '47194b3d-bf52-416c-a53b-82888c49d6a2', '70f4ac2b-41f6-49db-a5ba-65e5eacf6b3d'::uuid, 'CWSP', 'CWSP', '530ba711-8a14-4d16-99aa-1b132ac42054', 16, 0, '47194b3d-bf52-416c-a53b-82888c49d6a2', '2026-05-14 14:38:46.956', '47194b3d-bf52-416c-a53b-82888c49d6a2', '2026-05-14 14:38:46.956', true, 'GAP Suspension Approved', NULL, 'GAP Suspension Approved', '3215426', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('61c07c24-dca9-42a1-a889-1a1d477ff50b'::uuid, 'GASR', '47194b3d-bf52-416c-a53b-82888c49d6a2', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '70f4ac2b-41f6-49db-a5ba-65e5eacf6b3d'::uuid, 'CWSP', 'CWSP', 'f1c62551-5a28-431b-b6e1-8766faa534da', 16, 0, '47194b3d-bf52-416c-a53b-82888c49d6a2', '2026-05-14 14:38:46.956', '47194b3d-bf52-416c-a53b-82888c49d6a2', '2026-05-14 14:38:46.956', true, '', NULL, 'Guardianship Suspension Submitted for review', '3215426', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('37c6c7c6-988a-4f8d-88a8-9ee5bc6d2eb2'::uuid, 'GASR', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '47194b3d-bf52-416c-a53b-82888c49d6a2', '70f4ac2b-41f6-49db-a5ba-65e5eacf6b3d'::uuid, 'CWSP', 'CWSP', '530ba711-8a14-4d16-99aa-1b132ac42054', 15, 0, 'ee86845e-ead2-420b-898f-66b4dd207f4e', '2026-05-14 14:53:00.925', '47194b3d-bf52-416c-a53b-82888c49d6a2', '2026-05-14 14:53:53.397', true, 'Guardianship Suspension Submitted for review', NULL, '', '3215426', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('48c58f53-ade7-4338-9cf8-754105e3f439'::uuid, 'GASR', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '47194b3d-bf52-416c-a53b-82888c49d6a2', '70f4ac2b-41f6-49db-a5ba-65e5eacf6b3d'::uuid, 'CWSP', 'CWSP', '928a1b98-3ef6-439d-b1b3-2db98ef2764e', 16, 1, '47194b3d-bf52-416c-a53b-82888c49d6a2', '2026-05-14 14:53:53.397', '47194b3d-bf52-416c-a53b-82888c49d6a2', '2026-05-14 14:53:53.397', true, 'GAP Suspension Approved', NULL, 'GAP Suspension Approved', '3215426', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('3989cd0c-bf13-49c2-bbe7-52e8f64fb12d'::uuid, 'GASR', '47194b3d-bf52-416c-a53b-82888c49d6a2', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '70f4ac2b-41f6-49db-a5ba-65e5eacf6b3d'::uuid, 'CWSP', 'CWSP', '530ba711-8a14-4d16-99aa-1b132ac42054', 16, 0, '47194b3d-bf52-416c-a53b-82888c49d6a2', '2026-05-14 14:53:53.397', '47194b3d-bf52-416c-a53b-82888c49d6a2', '2026-05-14 14:53:53.397', true, '', NULL, 'Guardianship Suspension Submitted for review', '3215426', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('21643423-d9ec-4386-a9ec-eae5c46e45c8'::uuid, 'GASR', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '47194b3d-bf52-416c-a53b-82888c49d6a2', '70f4ac2b-41f6-49db-a5ba-65e5eacf6b3d'::uuid, 'CWSP', 'CWSP', '5bbbeba4-ddb8-4c48-8967-2569c2f36ed9', 15, 0, 'ee86845e-ead2-420b-898f-66b4dd207f4e', '2026-07-17 15:30:14.386', '47194b3d-bf52-416c-a53b-82888c49d6a2', '2026-07-17 15:32:22.870', true, 'Guardianship Suspension Submitted for review', NULL, '', '3215426', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('61fca402-7d70-412a-874b-07a1ea56ea56'::uuid, 'GASR', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '47194b3d-bf52-416c-a53b-82888c49d6a2', '70f4ac2b-41f6-49db-a5ba-65e5eacf6b3d'::uuid, 'CWSP', 'CWSP', '6493b130-b4b7-46a6-9bd2-d2fd39123de3', 16, 0, '47194b3d-bf52-416c-a53b-82888c49d6a2', '2026-07-17 15:32:22.870', '47194b3d-bf52-416c-a53b-82888c49d6a2', '2026-07-17 15:32:22.870', true, 'GAP Suspension Approved', NULL, 'GAP Suspension Approved', '3215426', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('b202f3e7-6b4e-4293-b4e2-480feaf9475d'::uuid, 'GASR', '47194b3d-bf52-416c-a53b-82888c49d6a2', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '70f4ac2b-41f6-49db-a5ba-65e5eacf6b3d'::uuid, 'CWSP', 'CWSP', '5bbbeba4-ddb8-4c48-8967-2569c2f36ed9', 16, 0, '47194b3d-bf52-416c-a53b-82888c49d6a2', '2026-07-17 15:32:22.870', '47194b3d-bf52-416c-a53b-82888c49d6a2', '2026-07-17 15:32:22.870', true, '', NULL, 'Guardianship Suspension Submitted for review', '3215426', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('f7538d31-b120-4016-8ad4-aac9056e5e8d'::uuid, 'GASR', '47194b3d-bf52-416c-a53b-82888c49d6a2', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '70f4ac2b-41f6-49db-a5ba-65e5eacf6b3d'::uuid, 'CWSP', 'CWSP', '6493b130-b4b7-46a6-9bd2-d2fd39123de3', 16, 0, '47194b3d-bf52-416c-a53b-82888c49d6a2', '2026-07-20 08:44:41.531', '47194b3d-bf52-416c-a53b-82888c49d6a2', '2026-07-20 08:44:41.531', true, '', NULL, 'Guardianship Suspension Submitted for review', '3215426', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/
-- 3391401    JAYDA    SUE    TAYLOR    dc9228a3-0a69-40e3-8f1c-339bef5d7158

update gapsuspension
set enddate  = null, updatedby  = 'CJAMS-68730', updatedon  = now()
where gapsuspensionid  = 'd1dbf5b1-b62d-475b-893f-7d9a851be700'
;

update cjams.gapsuspensionrevision
set enddate  = null, updatedby  = 'CJAMS-68730', updatedon  = now()
where gapsuspensionrevisionid in  (
'af19c421-e6a1-41b5-8b9a-009fc8021061',
'a6333a1d-962d-4455-a63b-c69b57d58fc6'
);

DELETE FROM cjams.routing
WHERE routingid='35f1079f-886c-4b7c-b57a-07ad06b2ff25'::uuid;
DELETE FROM cjams.routing
WHERE routingid='6f1ac434-93dd-4a83-9dc3-8054190c9eee'::uuid;
DELETE FROM cjams.routing
WHERE routingid='5f3cd238-ceac-4336-9d0a-12882d9ad5b2'::uuid;
DELETE FROM cjams.routing
WHERE routingid='e6c5bab7-686d-43bc-aa53-93c71b1690da'::uuid;
DELETE FROM cjams.routing
WHERE routingid='6beea076-96aa-416a-852a-b8f4177c0819'::uuid;
DELETE FROM cjams.routing
WHERE routingid='fc182ee8-3df9-4dd0-801a-d72e9eca276e'::uuid;
DELETE FROM cjams.routing
WHERE routingid='985567c0-4c7b-4d48-80d2-1b2fd2dbded8'::uuid;
DELETE FROM cjams.routing
WHERE routingid='67e1d7ea-5017-4f98-a066-4fe4380864b1'::uuid;
DELETE FROM cjams.routing
WHERE routingid='e6f039c6-3a39-4050-a537-57a764135eb2'::uuid;
DELETE FROM cjams.routing
WHERE routingid='52b1a0f8-43e8-47c0-8c90-30d11c2c9a7f'::uuid;


DELETE FROM cjams.gapsuspensionrevision
WHERE gapsuspensionrevisionid='8c6798a9-2c3d-4137-ab1e-0189a6a74cf8'::uuid;
DELETE FROM cjams.gapsuspensionrevision
WHERE gapsuspensionrevisionid='3dbd9c53-80a6-410f-9929-4de7cacc3027'::uuid;
DELETE FROM cjams.gapsuspensionrevision
WHERE gapsuspensionrevisionid='3a1fa871-fa5c-424e-bb98-b22ed1e398af'::uuid;
DELETE FROM cjams.gapsuspensionrevision
WHERE gapsuspensionrevisionid='41eaed62-6211-41ad-802e-a94eda9b185d'::uuid;
DELETE FROM cjams.gapsuspensionrevision
WHERE gapsuspensionrevisionid='192d81ca-e7ed-4032-a10b-055e0ba91bee'::uuid;
DELETE FROM cjams.gapsuspensionrevision
WHERE gapsuspensionrevisionid='405dc876-3404-40c5-96cc-020ba56d2a94'::uuid;


DELETE FROM cjams.gapsuspension
WHERE gapsuspensionid='4717b4fc-b041-4b7b-bc55-f488f315bcfd'::uuid;
DELETE FROM cjams.gapsuspension
WHERE gapsuspensionid='6e8f02f7-1f40-4e6b-8e6c-f6a8296c1fc8'::uuid;
DELETE FROM cjams.gapsuspension
WHERE gapsuspensionid='244d4b06-29d8-43ff-9087-6904f7f16267'::uuid;
DELETE FROM cjams.gapsuspension
WHERE gapsuspensionid='e1665686-b343-457f-ad2b-7ec93ec17adf'::uuid;
DELETE FROM cjams.gapsuspension
WHERE gapsuspensionid='acd93f2a-179d-4e6e-9400-e1d51b4008af'::uuid;

/*
INSERT INTO cjams.gapsuspension
(gapsuspensionid, gapid, suspensionreasontypekey, startdate, enddate, notes, isdraft, suspensiondesc, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id, otherreason, alternateid, approvalstatustypekey, etl_userid, etl_load_date)
VALUES('4717b4fc-b041-4b7b-bc55-f488f315bcfd'::uuid, 'fac4634b-7112-45c1-b76b-8c3832684d77'::uuid, 'OT', '2026-04-30 04:00:00.000', NULL, '', 123, '', 0, '2026-05-14 14:31:24.000', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '2026-05-14 14:31:24.000', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '2026-05-14 14:38:55.336', NULL, 'provider died 1/11/2026; direct deposit ', 1036117, '3045', NULL, NULL);
INSERT INTO cjams.gapsuspension
(gapsuspensionid, gapid, suspensionreasontypekey, startdate, enddate, notes, isdraft, suspensiondesc, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id, otherreason, alternateid, approvalstatustypekey, etl_userid, etl_load_date)
VALUES('6e8f02f7-1f40-4e6b-8e6c-f6a8296c1fc8'::uuid, 'fac4634b-7112-45c1-b76b-8c3832684d77'::uuid, 'OT', '2026-04-30 04:00:00.000', NULL, '', 123, '', 0, '2026-05-14 14:31:24.000', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '2026-05-14 14:38:55.336', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '2026-05-14 14:53:44.241', NULL, 'provider died 1/11/2026; direct deposit ', 1036152, '3047', NULL, NULL);
INSERT INTO cjams.gapsuspension
(gapsuspensionid, gapid, suspensionreasontypekey, startdate, enddate, notes, isdraft, suspensiondesc, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id, otherreason, alternateid, approvalstatustypekey, etl_userid, etl_load_date)
VALUES('244d4b06-29d8-43ff-9087-6904f7f16267'::uuid, 'fac4634b-7112-45c1-b76b-8c3832684d77'::uuid, 'OT', '2026-04-30 04:00:00.000', '2026-04-30 04:00:00.000', '', 123, '', 1, '2026-05-14 14:31:24.000', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '2026-05-14 14:53:44.241', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '2026-05-14 14:53:44.241', NULL, 'provider died 1/11/2026; direct deposit ', 1036185, '3047', NULL, NULL);
INSERT INTO cjams.gapsuspension
(gapsuspensionid, gapid, suspensionreasontypekey, startdate, enddate, notes, isdraft, suspensiondesc, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id, otherreason, alternateid, approvalstatustypekey, etl_userid, etl_load_date)
VALUES('e1665686-b343-457f-ad2b-7ec93ec17adf'::uuid, 'fac4634b-7112-45c1-b76b-8c3832684d77'::uuid, 'OT', '2026-02-01 05:00:00.000', NULL, '', 123, '', 0, '2026-07-17 15:30:53.000', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '2026-07-17 15:30:53.000', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '2026-07-17 15:32:10.451', NULL, 'death of primary Suzian Taylor', 1038104, '3045', NULL, NULL);
INSERT INTO cjams.gapsuspension
(gapsuspensionid, gapid, suspensionreasontypekey, startdate, enddate, notes, isdraft, suspensiondesc, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id, otherreason, alternateid, approvalstatustypekey, etl_userid, etl_load_date)
VALUES('acd93f2a-179d-4e6e-9400-e1d51b4008af'::uuid, 'fac4634b-7112-45c1-b76b-8c3832684d77'::uuid, 'OT', '2026-02-01 05:00:00.000', NULL, '', 123, '', 0, '2026-07-17 15:30:53.000', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '2026-07-17 15:32:10.451', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '2026-07-20 08:44:32.123', NULL, 'death of primary Suzian Taylor', 1038105, '3047', NULL, NULL);

INSERT INTO cjams.gapsuspensionrevision
(gapsuspensionrevisionid, suspensionid, guardiansubsidyid, transactiondate, reasontypekey, startdate, enddate, suspensiondesc, approvalstatustypekey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, etl_userid, etl_load_date)
VALUES('8c6798a9-2c3d-4137-ab1e-0189a6a74cf8'::uuid, '4717b4fc-b041-4b7b-bc55-f488f315bcfd'::uuid, 'fac4634b-7112-45c1-b76b-8c3832684d77'::uuid, '2026-05-14 00:00:00.000', 'OT', '2026-04-30 04:00:00.000', NULL, '', '3045', '2026-05-14 00:00:00.000', NULL, '2026-05-14 14:31:24.000', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '2026-05-14 00:00:00.000', NULL, 0, 1042533, NULL, NULL);
INSERT INTO cjams.gapsuspensionrevision
(gapsuspensionrevisionid, suspensionid, guardiansubsidyid, transactiondate, reasontypekey, startdate, enddate, suspensiondesc, approvalstatustypekey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, etl_userid, etl_load_date)
VALUES('3dbd9c53-80a6-410f-9929-4de7cacc3027'::uuid, '6e8f02f7-1f40-4e6b-8e6c-f6a8296c1fc8'::uuid, 'fac4634b-7112-45c1-b76b-8c3832684d77'::uuid, '2026-05-14 00:00:00.000', 'OT', '2026-04-30 04:00:00.000', NULL, '', '3047', '2026-05-14 00:00:00.000', NULL, '2026-05-14 14:38:55.336', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '2026-05-14 00:00:00.000', NULL, 0, 1042568, NULL, NULL);
INSERT INTO cjams.gapsuspensionrevision
(gapsuspensionrevisionid, suspensionid, guardiansubsidyid, transactiondate, reasontypekey, startdate, enddate, suspensiondesc, approvalstatustypekey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, etl_userid, etl_load_date)
VALUES('3a1fa871-fa5c-424e-bb98-b22ed1e398af'::uuid, '6e8f02f7-1f40-4e6b-8e6c-f6a8296c1fc8'::uuid, 'fac4634b-7112-45c1-b76b-8c3832684d77'::uuid, '2026-05-14 00:00:00.000', 'OT', '2026-04-30 04:00:00.000', '2026-04-30 04:00:00.000', '', '3045', '2026-05-14 00:00:00.000', NULL, '2026-05-14 14:53:24.000', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '2026-05-14 00:00:00.000', NULL, 0, 1042602, NULL, NULL);
INSERT INTO cjams.gapsuspensionrevision
(gapsuspensionrevisionid, suspensionid, guardiansubsidyid, transactiondate, reasontypekey, startdate, enddate, suspensiondesc, approvalstatustypekey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, etl_userid, etl_load_date)
VALUES('41eaed62-6211-41ad-802e-a94eda9b185d'::uuid, '244d4b06-29d8-43ff-9087-6904f7f16267'::uuid, 'fac4634b-7112-45c1-b76b-8c3832684d77'::uuid, '2026-05-14 00:00:00.000', 'OT', '2026-04-30 04:00:00.000', '2026-04-30 04:00:00.000', '', '3047', '2026-05-14 00:00:00.000', NULL, '2026-05-14 14:53:44.241', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '2026-05-14 14:53:44.241', NULL, 0, 1042603, NULL, NULL);
INSERT INTO cjams.gapsuspensionrevision
(gapsuspensionrevisionid, suspensionid, guardiansubsidyid, transactiondate, reasontypekey, startdate, enddate, suspensiondesc, approvalstatustypekey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, etl_userid, etl_load_date)
VALUES('192d81ca-e7ed-4032-a10b-055e0ba91bee'::uuid, 'e1665686-b343-457f-ad2b-7ec93ec17adf'::uuid, 'fac4634b-7112-45c1-b76b-8c3832684d77'::uuid, '2026-07-17 00:00:00.000', 'OT', '2026-02-01 05:00:00.000', NULL, '', '3045', '2026-07-17 00:00:00.000', NULL, '2026-07-17 15:30:53.000', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '2026-07-17 00:00:00.000', NULL, 0, 1044755, NULL, NULL);
INSERT INTO cjams.gapsuspensionrevision
(gapsuspensionrevisionid, suspensionid, guardiansubsidyid, transactiondate, reasontypekey, startdate, enddate, suspensiondesc, approvalstatustypekey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, etl_userid, etl_load_date)
VALUES('405dc876-3404-40c5-96cc-020ba56d2a94'::uuid, 'acd93f2a-179d-4e6e-9400-e1d51b4008af'::uuid, 'fac4634b-7112-45c1-b76b-8c3832684d77'::uuid, '2026-07-20 00:00:00.000', 'OT', '2026-02-01 05:00:00.000', NULL, '', '3047', '2026-07-20 00:00:00.000', NULL, '2026-07-17 15:32:10.451', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '2026-07-20 00:00:00.000', NULL, 0, 1044756, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('35f1079f-886c-4b7c-b57a-07ad06b2ff25'::uuid, 'GASR', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '47194b3d-bf52-416c-a53b-82888c49d6a2', '70f4ac2b-41f6-49db-a5ba-65e5eacf6b3d'::uuid, 'CWSP', 'CWSP', '4717b4fc-b041-4b7b-bc55-f488f315bcfd', 15, 0, 'ee86845e-ead2-420b-898f-66b4dd207f4e', '2026-05-14 14:31:24.343', '47194b3d-bf52-416c-a53b-82888c49d6a2', '2026-05-14 14:38:55.336', true, 'Guardianship Suspension Submitted for review', NULL, '', '3215426', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('6f1ac434-93dd-4a83-9dc3-8054190c9eee'::uuid, 'GASR', '47194b3d-bf52-416c-a53b-82888c49d6a2', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '70f4ac2b-41f6-49db-a5ba-65e5eacf6b3d'::uuid, 'CWSP', 'CWSP', '4717b4fc-b041-4b7b-bc55-f488f315bcfd', 16, 0, '47194b3d-bf52-416c-a53b-82888c49d6a2', '2026-05-14 14:38:55.336', '47194b3d-bf52-416c-a53b-82888c49d6a2', '2026-05-14 14:38:55.336', true, '', NULL, 'Guardianship Suspension Submitted for review', '3215426', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('5f3cd238-ceac-4336-9d0a-12882d9ad5b2'::uuid, 'GASR', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '47194b3d-bf52-416c-a53b-82888c49d6a2', '70f4ac2b-41f6-49db-a5ba-65e5eacf6b3d'::uuid, 'CWSP', 'CWSP', '6e8f02f7-1f40-4e6b-8e6c-f6a8296c1fc8', 16, 0, '47194b3d-bf52-416c-a53b-82888c49d6a2', '2026-05-14 14:38:55.336', '47194b3d-bf52-416c-a53b-82888c49d6a2', '2026-05-14 14:38:55.336', true, 'GAP Suspension Approved', NULL, 'GAP Suspension Approved', '3215426', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('e6c5bab7-686d-43bc-aa53-93c71b1690da'::uuid, 'GASR', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '47194b3d-bf52-416c-a53b-82888c49d6a2', '70f4ac2b-41f6-49db-a5ba-65e5eacf6b3d'::uuid, 'CWSP', 'CWSP', '6e8f02f7-1f40-4e6b-8e6c-f6a8296c1fc8', 15, 0, 'ee86845e-ead2-420b-898f-66b4dd207f4e', '2026-05-14 14:53:24.159', '47194b3d-bf52-416c-a53b-82888c49d6a2', '2026-05-14 14:53:44.241', true, 'Guardianship Suspension Submitted for review', NULL, '', '3215426', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('6beea076-96aa-416a-852a-b8f4177c0819'::uuid, 'GASR', '47194b3d-bf52-416c-a53b-82888c49d6a2', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '70f4ac2b-41f6-49db-a5ba-65e5eacf6b3d'::uuid, 'CWSP', 'CWSP', '6e8f02f7-1f40-4e6b-8e6c-f6a8296c1fc8', 16, 0, '47194b3d-bf52-416c-a53b-82888c49d6a2', '2026-05-14 14:53:44.241', '47194b3d-bf52-416c-a53b-82888c49d6a2', '2026-05-14 14:53:44.241', true, 'Guardianship Suspension Submitted for review', NULL, 'Guardianship Suspension Submitted for review', '3215426', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('fc182ee8-3df9-4dd0-801a-d72e9eca276e'::uuid, 'GASR', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '47194b3d-bf52-416c-a53b-82888c49d6a2', '70f4ac2b-41f6-49db-a5ba-65e5eacf6b3d'::uuid, 'CWSP', 'CWSP', '244d4b06-29d8-43ff-9087-6904f7f16267', 16, 1, '47194b3d-bf52-416c-a53b-82888c49d6a2', '2026-05-14 14:53:44.241', '47194b3d-bf52-416c-a53b-82888c49d6a2', '2026-05-14 14:53:44.241', true, 'GAP Suspension Approved', NULL, 'GAP Suspension Approved', '3215426', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('985567c0-4c7b-4d48-80d2-1b2fd2dbded8'::uuid, 'GASR', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '47194b3d-bf52-416c-a53b-82888c49d6a2', '70f4ac2b-41f6-49db-a5ba-65e5eacf6b3d'::uuid, 'CWSP', 'CWSP', 'e1665686-b343-457f-ad2b-7ec93ec17adf', 15, 0, 'ee86845e-ead2-420b-898f-66b4dd207f4e', '2026-07-17 15:30:53.034', '47194b3d-bf52-416c-a53b-82888c49d6a2', '2026-07-17 15:32:10.451', true, 'Guardianship Suspension Submitted for review', NULL, '', '3215426', 'Servicecase', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('67e1d7ea-5017-4f98-a066-4fe4380864b1'::uuid, 'GASR', '47194b3d-bf52-416c-a53b-82888c49d6a2', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '70f4ac2b-41f6-49db-a5ba-65e5eacf6b3d'::uuid, 'CWSP', 'CWSP', 'e1665686-b343-457f-ad2b-7ec93ec17adf', 16, 0, '47194b3d-bf52-416c-a53b-82888c49d6a2', '2026-07-17 15:32:10.451', '47194b3d-bf52-416c-a53b-82888c49d6a2', '2026-07-17 15:32:10.451', true, '', NULL, 'Guardianship Suspension Submitted for review', '3215426', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('e6f039c6-3a39-4050-a537-57a764135eb2'::uuid, 'GASR', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '47194b3d-bf52-416c-a53b-82888c49d6a2', '70f4ac2b-41f6-49db-a5ba-65e5eacf6b3d'::uuid, 'CWSP', 'CWSP', 'acd93f2a-179d-4e6e-9400-e1d51b4008af', 16, 0, '47194b3d-bf52-416c-a53b-82888c49d6a2', '2026-07-17 15:32:10.451', '47194b3d-bf52-416c-a53b-82888c49d6a2', '2026-07-17 15:32:10.451', true, 'GAP Suspension Approved', NULL, 'GAP Suspension Approved', '3215426', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('52b1a0f8-43e8-47c0-8c90-30d11c2c9a7f'::uuid, 'GASR', '47194b3d-bf52-416c-a53b-82888c49d6a2', 'ee86845e-ead2-420b-898f-66b4dd207f4e', '70f4ac2b-41f6-49db-a5ba-65e5eacf6b3d'::uuid, 'CWSP', 'CWSP', 'acd93f2a-179d-4e6e-9400-e1d51b4008af', 16, 0, '47194b3d-bf52-416c-a53b-82888c49d6a2', '2026-07-20 08:44:32.123', '47194b3d-bf52-416c-a53b-82888c49d6a2', '2026-07-20 08:44:32.123', true, '', NULL, 'Guardianship Suspension Submitted for review', '3215426', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
*/




-----------------------------------------------------------------------------------------------------------

-- Data fix to delete ARs 


update tb_receivable_collection_status
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CJAMS-68730'
where delete_sw = 'N'
	and receivable_detail_id in (1772699, 1772704, 1772700, 1772705, 1772701, 1772706);
		



update tb_receivable_detail
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CJAMS-68730'
where delete_sw = 'N'
	and receivable_detail_id in (1772699, 1772704, 1772700, 1772705, 1772701, 1772706);
		   
-- 	Update Provider AR Balances & Payment Plan		   
update tb_receivable_header rh
set balance_no 
		= coalesce(( select sum(rd.receivable_balance_no)
						from tb_receivable_detail rd
					 where rd.receivable_id = rh.receivable_id
						and rd.delete_sw = 'N'
						and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
					),0),
	receivable_original_amount_no 
		= coalesce(( select sum(rd.amount_no)
						from tb_receivable_detail rd
					 where rd.receivable_id = rh.receivable_id
						and rd.delete_sw = 'N'
						and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
					),0),					  
	written_off_amount_no
		= coalesce(( select sum(rd.written_off_amount_no)
						from tb_receivable_detail rd
					 where rd.receivable_id = rh.receivable_id
						and rd.delete_sw = 'N'
						and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
					),0),
	update_ts = now(),
	update_user_id = 'CJAMS-68730'
where rh.delete_sw = 'N'  
	and rh.receivable_id = 1265160 ;
		 
-- 	Update Payment Plan
update tb_payment_plan pp
set current_receivable_amount 
		= coalesce(( select sum(rd.receivable_balance_no)       
				      from tb_receivable_detail rd,
				           tb_receivable_collection_status rcs
				    where rcs.receivable_detail_id = rd.receivable_detail_id
				      and rd.receivable_id = pp.receivable_id
				      and rd.receivable_status_cd in ('19','22') 
				      and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
				      and rd.delete_sw = 'N' 
				      and rcs.delete_sw = 'N'	
				      and rcs.active_sw = 'Y'   
				      and rcs.collection_status_cd <> '775'   
			    ),0),
    amount_no 
		= coalesce(((( select sum(rd.receivable_balance_no)       
				      from tb_receivable_detail rd,
				           tb_receivable_collection_status rcs
				    where rcs.receivable_detail_id = rd.receivable_detail_id
				      and rd.receivable_id = pp.receivable_id
				      and rd.receivable_status_cd in ('19','22') 
				      and ((rd.manual_sw = 'N') or (rd.manual_sw = 'Y' and rd.approval_status_cd = '3047'))
				      and rd.delete_sw = 'N' 
				      and rcs.delete_sw = 'N'	
				      and rcs.active_sw = 'Y'   
				      and rcs.collection_status_cd <> '775'   
			    ) * pp.percentage_no ) / 100 ),0),
    update_ts = now(),
	update_user_id = 'CJAMS-68730'
where pp.delete_sw = 'N'
	and pp.end_dt is null 
	and pp.receivable_id = 1265160 ;



-------------------------------------------------------------------------------------

update gapagreementrate
set activeflag = 0,
	updatedby = 'CJAMS-68730', 
	updatedon = now() 
where gapagreementrateid in ('215cd2d5-e242-4046-8e10-db0fe0f642f3','4454bb94-1768-4558-8f66-47e96e1da5ed')
	and activeflag = 1 ;


update gapratesrevision
set activeflag = 0,
	updatedby = 'CJAMS-68730', 
	updatedon = now() 
where gaprateid in ('215cd2d5-e242-4046-8e10-db0fe0f642f3','4454bb94-1768-4558-8f66-47e96e1da5ed')
	and activeflag = 1 ;


update routing
set activeflag = 0,
	updatedby = 'CJAMS-68730', 
	updatedon = now() 
where objectid in ('215cd2d5-e242-4046-8e10-db0fe0f642f3','4454bb94-1768-4558-8f66-47e96e1da5ed')
	and eventcode = 'GARR'
	and activeflag = 1 ;

---------------------------------------------------------------------

update guardianship 
set guardianonename = 'Suzian Taylor', -- 'Edward  Taylor '
    guardianoneid = 216320, -- 838882 (approval_person_id -> tb_prov_approval_person )
    guardianoneproviderid = 5085937, -- 6301138
    -- primaryrelationshipkey = 'DACRCHLD',
    guardiantwoname = 'Edward Taylor', -- NULL
    guardiantwoid = 216321, -- NULL (approval_person_id -> tb_prov_approval_person )
    guardiantwoproviderid = 5065393, -- NULL
    -- secondaryrelationshipkey = 'HSBND', 
    updatedby = 'CJAMS-68730', -- 65184bef-4775-4122-9bf0-45e2761b9292
    updatedon = now() -- 2023-08-04 10:31:49
where gapid in (
    'e0719a38-41e7-4224-b3ff-0d6870871b08',
    'fac4634b-7112-45c1-b76b-8c3832684d77'
    )
    and activeflag = 1 ;