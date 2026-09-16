/*
-- Issue Description: 
	dA final disbursement was sent to me for approval.
    I selected the other disbursement link, and then forwarded to the approve or deny screen.


-- Category/ Module: Child Accounts (Finance Management) 
-- Root cause:  Old migrated date with the closed account status and routing id was duplicated 
-- Fix Provided: Datafix has been promoted to remove the routing for those closed account and to remove duplicate routing data.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

/*
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('042c0a6e-e613-48bf-86dc-5e4e430631e0', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6053', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-06-10 10:26:48.000', 'Migration_child_disbursement', '2020-06-10 10:26:48.000', false, NULL, '6053', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('0acf31cb-33e9-4a6a-9edf-963bf5239fc8', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6013', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-04-22 16:46:32.000', 'Migration_child_disbursement', '2020-04-22 16:46:32.000', false, NULL, '6013', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-05-16', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('0b470acd-55e2-4deb-8ccb-20e259d12f24', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5942', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-03-10 09:28:05.000', 'Migration_child_disbursement', '2020-03-09 15:31:24.000', false, NULL, '5942', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-04-18', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('0bb6849a-c950-460b-8ec3-6bac579539bd', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5904', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-02-20 11:55:52.000', 'Migration_child_disbursement', '2020-02-20 11:55:52.000', false, NULL, '5904', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('0e3517c5-04f1-4ef7-b6f4-6a4df3d0929c', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5905', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-02-24 15:37:41.000', 'Migration_child_disbursement', '2020-02-24 10:43:14.000', false, NULL, '5905', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-07-25', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('0e3d909d-62ca-4e70-bd1f-0c8e6271f7b6', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6055', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-06-10 14:31:16.000', 'Migration_child_disbursement', '2020-06-10 12:19:05.000', false, NULL, '6055', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-07-25', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('0fcfbb85-7591-4a48-8484-2cb0ae52a369', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6014', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-04-22 16:49:20.000', 'Migration_child_disbursement', '2020-04-22 16:49:20.000', false, NULL, '6014', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-05-16', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('10b23167-c1bc-4b2b-a5d4-6f58ac6b955d', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6018', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-04-29 15:47:03.000', 'Migration_child_disbursement', '2020-04-29 11:20:58.000', false, NULL, '6018', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-07-25', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('129010c1-5ed1-4df4-b6b4-17b0e5d68db6', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6054', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-06-10 14:36:18.000', 'Migration_child_disbursement', '2020-06-10 12:16:58.000', false, NULL, '6054', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('19045f39-c41e-4769-a4f4-17ea4581afc2', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6052', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-06-10 14:34:50.000', 'Migration_child_disbursement', '2020-06-10 12:09:43.000', false, NULL, '6052', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-07-25', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('19986f1d-0d9b-4a8e-a95b-f0870caed0c9', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6059', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-06-17 09:55:03.000', 'Migration_child_disbursement', '2020-06-17 09:55:03.000', false, NULL, '6059', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('1a91e1c7-eaae-493f-b402-ec68be5efefb', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6023', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-05-06 08:32:41.000', 'Migration_child_disbursement', '2020-05-06 08:32:41.000', false, NULL, '6023', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('1b0fedcd-5afe-47e4-8107-6f64164e89e1', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5884', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-02-06 10:15:57.000', 'Migration_child_disbursement', '2020-02-06 08:30:12.000', false, NULL, '5884', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-07-25', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('1b522518-4677-4a8e-a069-e223fa86225b', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6015', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-04-29 15:44:21.000', 'Migration_child_disbursement', '2020-04-29 11:12:25.000', false, NULL, '6015', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-07-25', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('1c95e70d-d845-4d74-acf0-776b24aa108f', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6050', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-06-10 14:32:11.000', 'Migration_child_disbursement', '2020-06-10 12:03:11.000', false, NULL, '6050', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('1de9e7d7-283e-4ac5-9c5e-d1ad50beca45', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5885', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-02-05 11:23:08.000', 'Migration_child_disbursement', '2020-02-05 11:23:08.000', false, NULL, '5885', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-05-16', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('1f657a44-8b0f-4f6f-98b2-2bc00ef38cc3', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5885', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-02-06 10:16:51.000', 'Migration_child_disbursement', '2020-02-06 08:31:28.000', false, NULL, '5885', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-07-25', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('1f75d9f9-1a27-4fae-ae55-fa8cfb4da2b0', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6049', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-06-10 14:33:59.000', 'Migration_child_disbursement', '2020-06-10 11:57:59.000', false, NULL, '6049', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-07-25', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('1f82e9f1-4ac7-43f6-b482-ef255307d0b6', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6016', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-04-22 17:05:40.000', 'Migration_child_disbursement', '2020-04-22 17:05:40.000', false, NULL, '6016', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('1f9f528e-70b0-450b-bf6b-1f6deecbe207', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5902', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-02-20 11:51:07.000', 'Migration_child_disbursement', '2020-02-20 11:51:07.000', false, NULL, '5902', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('20aaa00e-1a8f-498c-b822-172dc92b19d4', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5905', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-02-20 11:59:20.000', 'Migration_child_disbursement', '2020-02-20 11:59:20.000', false, NULL, '5905', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('22614a88-b47a-4ce3-9b75-4064fbf54b53', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6015', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-04-22 16:52:25.000', 'Migration_child_disbursement', '2020-04-22 16:52:25.000', false, NULL, '6015', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-05-16', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('286c03ba-9175-415d-a9bc-50ea28536440', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5902', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-02-20 11:51:07.000', 'Migration_child_disbursement', '2020-02-20 11:51:07.000', false, NULL, '5902', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-04-18', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('2b55c2a9-4380-427b-a869-87aa5304c37d', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6056', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-06-10 10:39:55.000', 'Migration_child_disbursement', '2020-06-10 10:39:55.000', false, NULL, '6056', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('3073e099-53a3-40ea-b710-00791f84b699', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6019', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-04-22 17:27:29.000', 'Migration_child_disbursement', '2020-04-22 17:27:29.000', false, NULL, '6019', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-05-16', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('318f2ddd-9bc4-4301-9944-744ddce59f0c', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5906', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-02-20 12:02:16.000', 'Migration_child_disbursement', '2020-02-20 12:02:16.000', false, NULL, '5906', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('33034732-6f39-4248-b2ed-ff00192897ca', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5883', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-02-05 11:15:20.000', 'Migration_child_disbursement', '2020-02-05 11:15:20.000', false, NULL, '5883', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-04-18', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('34049739-4e85-4460-b83d-719e0ad8a040', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5884', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-02-05 11:19:44.000', 'Migration_child_disbursement', '2020-02-05 11:19:44.000', false, NULL, '5884', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-05-16', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('373b1228-8157-4f36-b292-e903ced118ad', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6057', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-06-17 09:49:22.000', 'Migration_child_disbursement', '2020-06-17 09:49:22.000', false, NULL, '6057', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('3ad9fc5b-432f-4a5a-b629-fa598ae065c9', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6018', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-04-22 17:25:03.000', 'Migration_child_disbursement', '2020-04-22 17:25:03.000', false, NULL, '6018', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('41500973-9530-49c9-bc07-7d26c189bbdb', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5942', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-03-10 09:28:05.000', 'Migration_child_disbursement', '2020-03-09 15:31:24.000', false, NULL, '5942', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('482cd384-a32f-477d-98e5-a65dd95e4611', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6050', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-06-10 10:05:43.000', 'Migration_child_disbursement', '2020-06-10 10:05:43.000', false, NULL, '6050', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('4a60fb26-ce4c-4f96-a52b-f8fd4dcb06f8', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6013', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-04-22 16:46:32.000', 'Migration_child_disbursement', '2020-04-22 16:46:32.000', false, NULL, '6013', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('4b1d8aa6-4f51-4c2d-a874-9307528d7799', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6018', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-04-22 17:25:03.000', 'Migration_child_disbursement', '2020-04-22 17:25:03.000', false, NULL, '6018', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-05-16', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('4c7b7751-cdb6-4745-8577-07f4b164cda9', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6013', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-04-29 15:41:01.000', 'Migration_child_disbursement', '2020-04-29 11:08:48.000', false, NULL, '6013', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-07-25', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('4ccae28c-9f2f-457e-8bc4-9e28d3ae2288', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6024', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-05-06 19:35:41.000', 'Migration_child_disbursement', '2020-05-06 13:13:18.000', false, NULL, '6024', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-05-16', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('4cee80de-212f-4304-8055-5049aeffda5a', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5904', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-02-24 15:39:19.000', 'Migration_child_disbursement', '2020-02-24 10:41:23.000', false, NULL, '5904', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-05-16', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('4dc03465-cdb4-4cc2-94db-93507ac31998', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5883', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-02-05 11:15:20.000', 'Migration_child_disbursement', '2020-02-05 11:15:20.000', false, NULL, '5883', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-05-16', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('4dfe386b-1abe-42bc-8279-b9a408fa1353', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6024', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-05-06 08:38:18.000', 'Migration_child_disbursement', '2020-05-06 08:38:18.000', false, NULL, '6024', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-05-16', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('4fea77fd-b2f6-4789-b56e-f25bba49eac6', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5903', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-02-24 15:41:33.000', 'Migration_child_disbursement', '2020-02-24 10:39:45.000', false, NULL, '5903', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-05-16', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('5022f47e-0c0a-4c86-b452-85650ca4eaf6', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6025', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-05-06 19:37:25.000', 'Migration_child_disbursement', '2020-05-06 13:10:51.000', false, NULL, '6025', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('51372a82-bfe7-4f7d-ac1c-bd2aea93f891', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5902', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-02-24 15:36:59.000', 'Migration_child_disbursement', '2020-02-24 10:36:13.000', false, NULL, '5902', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-07-25', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('5400a349-3269-4bd0-96a8-edfa5775a53e', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5905', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-02-24 15:37:41.000', 'Migration_child_disbursement', '2020-02-24 10:43:14.000', false, NULL, '5905', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('56b6d3c1-82db-41c2-9e84-77146deb8db0', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5942', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-03-09 12:33:28.000', 'Migration_child_disbursement', '2020-03-09 12:33:28.000', false, NULL, '5942', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-04-18', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('57338314-c12a-4f94-8a0e-6bed58910a10', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6025', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-05-06 08:49:41.000', 'Migration_child_disbursement', '2020-05-06 08:49:41.000', false, NULL, '6025', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-05-16', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('5ab5a4ec-888d-49ac-9255-40384bf91ea2', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6054', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-06-10 10:31:22.000', 'Migration_child_disbursement', '2020-06-10 10:31:22.000', false, NULL, '6054', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('5e1e17c0-677c-4ff9-960c-470b9d74a4b4', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5906', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-02-24 15:40:23.000', 'Migration_child_disbursement', '2020-02-24 10:45:13.000', false, NULL, '5906', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('5fb60895-5ebc-49ef-aa7e-9be129af5af7', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6052', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-06-10 10:17:15.000', 'Migration_child_disbursement', '2020-06-10 10:17:15.000', false, NULL, '6052', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('61bbaa9c-f858-48d2-ac51-df128b5ac37b', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5906', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-02-20 12:02:16.000', 'Migration_child_disbursement', '2020-02-20 12:02:16.000', false, NULL, '5906', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-04-18', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('63ab9cf3-819c-48b3-9023-b72d3687f638', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6023', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-05-06 19:34:28.000', 'Migration_child_disbursement', '2020-05-06 13:07:28.000', false, NULL, '6023', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('64f84dfa-0a4f-48e8-9dee-5e947a3a2f6f', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5883', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-02-06 10:15:06.000', 'Migration_child_disbursement', '2020-02-06 08:28:26.000', false, NULL, '5883', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('6549435c-e67a-4261-9e9e-95226bfb0840', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5885', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-02-05 11:23:08.000', 'Migration_child_disbursement', '2020-02-05 11:23:08.000', false, NULL, '5885', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('66021e33-e784-4432-9210-47158def9088', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6025', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-05-06 08:49:41.000', 'Migration_child_disbursement', '2020-05-06 08:49:41.000', false, NULL, '6025', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-07-25', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('6662650f-fb79-46ef-8f1b-b8a36824b5c2', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5902', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-02-20 11:51:07.000', 'Migration_child_disbursement', '2020-02-20 11:51:07.000', false, NULL, '5902', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-05-16', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('66cfe09a-23f6-4fc6-8eb4-7b5d1333a68c', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6016', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-04-29 15:46:13.000', 'Migration_child_disbursement', '2020-04-29 11:18:13.000', false, NULL, '6016', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-07-25', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('66d112fa-1599-418b-8a76-019307352560', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5942', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-03-10 09:28:05.000', 'Migration_child_disbursement', '2020-03-09 15:31:24.000', false, NULL, '5942', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-05-16', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('66eec3b5-b0fd-483d-8134-5d8ab2e5705d', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6017', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-04-29 15:45:19.000', 'Migration_child_disbursement', '2020-04-29 11:15:45.000', false, NULL, '6017', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-07-25', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('69b16b59-1296-470c-a551-2f3063feb46d', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5904', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-02-24 15:39:19.000', 'Migration_child_disbursement', '2020-02-24 10:41:23.000', false, NULL, '5904', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('6a62e4dd-0814-4aa4-b73f-a9b6791d3846', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6013', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-04-29 15:41:01.000', 'Migration_child_disbursement', '2020-04-29 11:08:48.000', false, NULL, '6013', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('71e353b2-a580-41d3-a6d8-11aa08ce8be2', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6024', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-05-06 08:38:18.000', 'Migration_child_disbursement', '2020-05-06 08:38:18.000', false, NULL, '6024', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('7325134b-1373-465a-87d6-b353e4403097', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6017', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-04-22 17:22:00.000', 'Migration_child_disbursement', '2020-04-22 17:22:00.000', false, NULL, '6017', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-05-16', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('7389e023-fe57-4c48-9c72-ef20ed00b1d6', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5905', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-02-24 15:37:41.000', 'Migration_child_disbursement', '2020-02-24 10:43:14.000', false, NULL, '5905', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-05-16', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('750507ec-e07b-414e-ab6c-c770b5e82caf', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '676ac1ec-f338-4646-a786-b3af379986f9', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6057', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-06-17 13:41:44.000', 'Migration_child_disbursement', '2020-06-17 11:39:35.000', false, NULL, '6057', NULL, NULL, NULL, '6023972', '6007150', NULL, NULL, 'Data Migration', '2020-07-25', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('798d7b33-cfd7-4343-a2c1-f6c1f13cd30c', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6017', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-04-29 15:45:19.000', 'Migration_child_disbursement', '2020-04-29 11:15:45.000', false, NULL, '6017', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('7b38d7a3-1682-44a6-84be-95f6d4f1a8ea', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6060', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-06-17 09:58:20.000', 'Migration_child_disbursement', '2020-06-17 09:58:20.000', false, NULL, '6060', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('7c4e1c4a-f253-4789-934f-e424290b6b72', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5884', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-02-06 10:15:57.000', 'Migration_child_disbursement', '2020-02-06 08:30:12.000', false, NULL, '5884', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('8094aca6-6830-4ccb-bd60-3b8eedd35c89', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6014', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-04-29 15:42:58.000', 'Migration_child_disbursement', '2020-04-29 11:10:51.000', false, NULL, '6014', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-07-25', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('816f642c-d331-4899-8ca0-dbe4c13ed88c', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5884', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-02-06 10:15:57.000', 'Migration_child_disbursement', '2020-02-06 08:30:12.000', false, NULL, '5884', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-05-16', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('81ced8bf-2887-40e5-a2b9-2a71d1114306', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5942', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-03-09 12:33:28.000', 'Migration_child_disbursement', '2020-03-09 12:33:28.000', false, NULL, '5942', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-05-16', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('82395c76-48ff-4cfd-8cfd-85248678c01b', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6024', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-05-06 19:35:41.000', 'Migration_child_disbursement', '2020-05-06 13:13:18.000', false, NULL, '6024', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('849f6d82-7f87-4561-add9-9df0c38cb83a', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6051', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-06-10 14:30:27.000', 'Migration_child_disbursement', '2020-06-10 12:05:51.000', false, NULL, '6051', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-07-25', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('867d8d4f-268a-40d3-a190-4f381180a0ac', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5903', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-02-20 11:53:34.000', 'Migration_child_disbursement', '2020-02-20 11:53:34.000', false, NULL, '5903', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('894add88-cb0d-4b60-9c92-6d3d6f930bde', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5903', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-02-20 11:53:34.000', 'Migration_child_disbursement', '2020-02-20 11:53:34.000', false, NULL, '5903', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-05-16', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('896cfa64-f08e-44ab-8b45-a33f7c8d0a0b', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6019', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-04-22 17:27:29.000', 'Migration_child_disbursement', '2020-04-22 17:27:29.000', false, NULL, '6019', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('89b393ba-03a1-436a-8bb2-feb7a4b0f3bf', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6018', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-04-29 15:47:03.000', 'Migration_child_disbursement', '2020-04-29 11:20:58.000', false, NULL, '6018', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('8b91d125-b63f-46b1-8393-af094b923342', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6014', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-04-29 15:42:58.000', 'Migration_child_disbursement', '2020-04-29 11:10:51.000', false, NULL, '6014', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('8bad4b8f-c487-4783-a9ec-906ce50009ca', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6053', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-06-10 14:32:59.000', 'Migration_child_disbursement', '2020-06-10 12:13:26.000', false, NULL, '6053', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-07-25', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('8ce4e0eb-636f-444c-a10a-c7341ffa3e41', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5906', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-02-24 15:40:23.000', 'Migration_child_disbursement', '2020-02-24 10:45:13.000', false, NULL, '5906', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-07-25', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('8da07c7b-e25f-48b5-90a2-8631b2f397df', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6058', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-06-17 09:52:54.000', 'Migration_child_disbursement', '2020-06-17 09:52:54.000', false, NULL, '6058', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('8f68dc9c-f01e-4546-a921-6911a2e70a7f', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5905', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-02-20 11:59:20.000', 'Migration_child_disbursement', '2020-02-20 11:59:20.000', false, NULL, '5905', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-05-16', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('94d210ba-57e2-4a0c-94dd-ade44913d6e5', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5902', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-02-24 15:36:59.000', 'Migration_child_disbursement', '2020-02-24 10:36:13.000', false, NULL, '5902', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-05-16', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('963c51c5-0aa3-45f0-88d2-367c02fbacf1', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5906', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-02-24 15:40:23.000', 'Migration_child_disbursement', '2020-02-24 10:45:13.000', false, NULL, '5906', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-05-16', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('96e102a5-4914-44bb-bbbc-18dd46d5405e', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5885', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-02-06 10:16:51.000', 'Migration_child_disbursement', '2020-02-06 08:31:28.000', false, NULL, '5885', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-05-16', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('99507aa5-c0d1-416c-82f7-511e5d269d83', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5885', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-02-06 10:16:51.000', 'Migration_child_disbursement', '2020-02-06 08:31:28.000', false, NULL, '5885', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('9ab9da17-39dc-4efc-a12c-42f86bf085ae', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5905', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-02-20 11:59:20.000', 'Migration_child_disbursement', '2020-02-20 11:59:20.000', false, NULL, '5905', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-04-18', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('9d167b77-b335-47b9-a7cc-d10936cb2feb', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5884', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-02-05 11:19:44.000', 'Migration_child_disbursement', '2020-02-05 11:19:44.000', false, NULL, '5884', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('a08f26ab-9f32-4219-9707-74f8dc239f4f', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6019', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-04-29 15:47:49.000', 'Migration_child_disbursement', '2020-04-29 14:21:06.000', false, NULL, '6019', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-07-25', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('a292794f-2fa8-4f57-a320-fce8b6494aa2', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5903', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-02-24 15:41:33.000', 'Migration_child_disbursement', '2020-02-24 10:39:45.000', false, NULL, '5903', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-07-25', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('a2da69d6-047d-42cb-855a-3bd272fd83db', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5883', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-02-06 10:15:06.000', 'Migration_child_disbursement', '2020-02-06 08:28:26.000', false, NULL, '5883', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-05-16', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('a549fe05-1fe4-48f3-be39-9bc8c25fc684', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6016', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-04-29 15:46:13.000', 'Migration_child_disbursement', '2020-04-29 11:18:13.000', false, NULL, '6016', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('aa9e9d88-ccbd-46e2-88a9-3ba1841fea04', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5904', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-02-24 15:39:19.000', 'Migration_child_disbursement', '2020-02-24 10:41:23.000', false, NULL, '5904', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-07-25', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('aaa43e15-29c2-4b1b-bb32-48b64a3a888d', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6019', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-04-29 15:47:49.000', 'Migration_child_disbursement', '2020-04-29 14:21:06.000', false, NULL, '6019', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('ab102bf0-4d5d-4049-9cd6-fbf99a49f6c4', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6017', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-04-22 17:22:00.000', 'Migration_child_disbursement', '2020-04-22 17:22:00.000', false, NULL, '6017', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('af0fd6a7-cb39-4f67-be93-8725e39d7170', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5883', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-02-05 11:15:20.000', 'Migration_child_disbursement', '2020-02-05 11:15:20.000', false, NULL, '5883', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('b41b5dc0-a656-44cb-a867-8793ba71500b', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5903', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-02-20 11:53:34.000', 'Migration_child_disbursement', '2020-02-20 11:53:34.000', false, NULL, '5903', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-04-18', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('b78f5931-6fdc-419c-b3fc-14ccc8c07580', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6049', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-06-10 10:02:32.000', 'Migration_child_disbursement', '2020-06-10 10:02:32.000', false, NULL, '6049', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('bb84efac-bc07-49b0-940e-709f81880201', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6025', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-05-06 19:37:25.000', 'Migration_child_disbursement', '2020-05-06 13:10:51.000', false, NULL, '6025', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-07-25', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('bd5677c2-0f4d-41b0-bc91-7705ccb7116a', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6023', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-05-06 19:34:28.000', 'Migration_child_disbursement', '2020-05-06 13:07:28.000', false, NULL, '6023', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-07-25', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('c3ae533d-286a-4a32-a172-900b0a1dd341', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5903', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-02-24 15:41:33.000', 'Migration_child_disbursement', '2020-02-24 10:39:45.000', false, NULL, '5903', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('cee83a8f-38c5-4d0f-836a-65f4076b83d2', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6016', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-04-22 17:05:40.000', 'Migration_child_disbursement', '2020-04-22 17:05:40.000', false, NULL, '6016', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-05-16', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('cf6f705b-a893-41b3-8f7f-ed59d02478cc', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6023', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-05-06 08:32:41.000', 'Migration_child_disbursement', '2020-05-06 08:32:41.000', false, NULL, '6023', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-05-16', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('cfb4a37d-9b13-4612-a997-c1015e86a79e', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6017', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-04-22 17:22:00.000', 'Migration_child_disbursement', '2020-04-22 17:22:00.000', false, NULL, '6017', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-07-25', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('d0791147-9b9e-4997-925f-666820312721', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5942', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-03-09 12:33:28.000', 'Migration_child_disbursement', '2020-03-09 12:33:28.000', false, NULL, '5942', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('d2123df3-5744-410b-9594-38c2fa0da899', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5883', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-02-06 10:15:06.000', 'Migration_child_disbursement', '2020-02-06 08:28:26.000', false, NULL, '5883', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-04-18', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('d6600125-6e21-4b27-b369-7d55a09a16f0', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6055', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-06-10 10:35:08.000', 'Migration_child_disbursement', '2020-06-10 10:35:08.000', false, NULL, '6055', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('d6de8a24-3dd4-4ed7-b966-b9395ae972a3', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5906', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-02-20 12:02:16.000', 'Migration_child_disbursement', '2020-02-20 12:02:16.000', false, NULL, '5906', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-05-16', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('d72d0c14-3910-4aa2-95e4-22cd41a11518', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6051', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-06-10 10:09:00.000', 'Migration_child_disbursement', '2020-06-10 10:09:00.000', false, NULL, '6051', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('da990f0e-bee4-4485-aeac-3bbec4f90085', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5885', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-02-05 11:23:08.000', 'Migration_child_disbursement', '2020-02-05 11:23:08.000', false, NULL, '5885', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-04-18', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('e0885032-163d-4747-8c4e-d5d539a4db17', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5904', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-02-20 11:55:52.000', 'Migration_child_disbursement', '2020-02-20 11:55:52.000', false, NULL, '5904', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-05-16', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('e3faa947-c067-4300-a520-7752fe08fb97', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6014', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-04-22 16:49:20.000', 'Migration_child_disbursement', '2020-04-22 16:49:20.000', false, NULL, '6014', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('e485d6c4-7d80-4f28-97d0-5fc116b9ecd9', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5904', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-02-20 11:55:52.000', 'Migration_child_disbursement', '2020-02-20 11:55:52.000', false, NULL, '5904', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-04-18', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('e625550a-9f0d-4b6d-b7e8-6040e3aad7cb', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '676ac1ec-f338-4646-a786-b3af379986f9', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6058', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-06-17 13:43:27.000', 'Migration_child_disbursement', '2020-06-17 11:45:59.000', false, NULL, '6058', NULL, NULL, NULL, '6023972', '6007150', NULL, NULL, 'Data Migration', '2020-07-25', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('e99b177e-9a21-40ef-8d12-c1a887a3ab89', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6025', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-05-06 08:49:41.000', 'Migration_child_disbursement', '2020-05-06 08:49:41.000', false, NULL, '6025', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('ea3229a9-9c45-419e-ac2a-ce8382203140', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5884', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-02-05 11:19:44.000', 'Migration_child_disbursement', '2020-02-05 11:19:44.000', false, NULL, '5884', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-04-18', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('ee0937ed-a161-47e4-a0b9-e4d12f9de2ba', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '5902', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-02-24 15:36:59.000', 'Migration_child_disbursement', '2020-02-24 10:36:13.000', false, NULL, '5902', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('ee4c2d73-a163-4edc-8f4a-ecf6e0a6fd5b', 'FINALDIS', '2e2cd25f-3373-46ed-9e63-07fdb79e2735', '90cc6979-1af9-4842-a5bd-148a97f8b073', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6015', 56, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-04-22 16:52:25.000', 'Migration_child_disbursement', '2020-04-22 16:52:25.000', false, NULL, '6015', NULL, NULL, NULL, '6007158', '6023972', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('f14e88d5-42bd-4dab-b141-016c3661c657', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '676ac1ec-f338-4646-a786-b3af379986f9', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6060', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-06-17 13:39:11.000', 'Migration_child_disbursement', '2020-06-17 11:52:08.000', false, NULL, '6060', NULL, NULL, NULL, '6023972', '6007150', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('f77600c2-1323-4eaf-b202-eba7b9131316', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '676ac1ec-f338-4646-a786-b3af379986f9', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6059', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-06-17 13:37:10.000', 'Migration_child_disbursement', '2020-06-17 11:49:52.000', false, NULL, '6059', NULL, NULL, NULL, '6023972', '6007150', NULL, NULL, 'Data Migration', '2020-07-25', NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes, intakerecommendation, supervisordecision, approveddate)
VALUES('fa00c8de-9ebc-48cf-a364-61d9cdd1e220', 'FINALDIS', '90cc6979-1af9-4842-a5bd-148a97f8b073', '5cf2d751-bd69-4436-bc02-60ca01abb28c', '3cbfe95b-bcf4-4a18-a51a-98e41aee9d0a', 'CWSP', 'CWCW', '6015', 58, 1, 'e155e2c1-d335-49f4-9450-22382b37e120', '2020-04-29 15:44:21.000', 'Migration_child_disbursement', '2020-04-29 11:12:25.000', false, NULL, '6015', NULL, NULL, NULL, '6023972', '6008267', NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL);
*/
/*
select status_cd ,delete_sw ,total_balance_no,available_balance_no,comm_account_id,* from tb_client_account tca where client_id =1678306-- and status_cd = '593' 
select * from tb_child_account_disbursement tcad where client_account_id =14024
select routingstatustypeid ,activeflag ,* from routing where objectid = '5856' and eventcode = 'FINALDIS'
*/


delete from routing
where routingid in (
'81ced8bf-2887-40e5-a2b9-2a71d1114306',
'56b6d3c1-82db-41c2-9e84-77146deb8db0',
'd0791147-9b9e-4997-925f-666820312721',
'66d112fa-1599-418b-8a76-019307352560',
'0b470acd-55e2-4deb-8ccb-20e259d12f24',
'41500973-9530-49c9-bc07-7d26c189bbdb',
'5ab5a4ec-888d-49ac-9255-40384bf91ea2',
'129010c1-5ed1-4df4-b6b4-17b0e5d68db6',
'b78f5931-6fdc-419c-b3fc-14ccc8c07580',
'1f75d9f9-1a27-4fae-ae55-fa8cfb4da2b0',
'61bbaa9c-f858-48d2-ac51-df128b5ac37b',
'd6de8a24-3dd4-4ed7-b966-b9395ae972a3',
'318f2ddd-9bc4-4301-9944-744ddce59f0c',
'963c51c5-0aa3-45f0-88d2-367c02fbacf1',
'5e1e17c0-677c-4ff9-960c-470b9d74a4b4',
'8ce4e0eb-636f-444c-a10a-c7341ffa3e41',
'7325134b-1373-465a-87d6-b353e4403097',
'ab102bf0-4d5d-4049-9cd6-fbf99a49f6c4',
'cfb4a37d-9b13-4612-a997-c1015e86a79e',
'798d7b33-cfd7-4343-a2c1-f6c1f13cd30c',
'66eec3b5-b0fd-483d-8134-5d8ab2e5705d',
'd72d0c14-3910-4aa2-95e4-22cd41a11518',
'849f6d82-7f87-4561-add9-9df0c38cb83a',
'2b55c2a9-4380-427b-a869-87aa5304c37d',
'5fb60895-5ebc-49ef-aa7e-9be129af5af7',
'19045f39-c41e-4769-a4f4-17ea4581afc2',
'042c0a6e-e613-48bf-86dc-5e4e430631e0',
'8bad4b8f-c487-4783-a9ec-906ce50009ca',
'3073e099-53a3-40ea-b710-00791f84b699',
'896cfa64-f08e-44ab-8b45-a33f7c8d0a0b',
'aaa43e15-29c2-4b1b-bb32-48b64a3a888d',
'a08f26ab-9f32-4219-9707-74f8dc239f4f',
'4b1d8aa6-4f51-4c2d-a874-9307528d7799',
'3ad9fc5b-432f-4a5a-b629-fa598ae065c9',
'89b393ba-03a1-436a-8bb2-feb7a4b0f3bf',
'10b23167-c1bc-4b2b-a5d4-6f58ac6b955d',
'286c03ba-9175-415d-a9bc-50ea28536440',
'6662650f-fb79-46ef-8f1b-b8a36824b5c2',
'1f9f528e-70b0-450b-bf6b-1f6deecbe207',
'94d210ba-57e2-4a0c-94dd-ade44913d6e5',
'ee0937ed-a161-47e4-a0b9-e4d12f9de2ba',
'51372a82-bfe7-4f7d-ac1c-bd2aea93f891',
'0acf31cb-33e9-4a6a-9edf-963bf5239fc8',
'4a60fb26-ce4c-4f96-a52b-f8fd4dcb06f8',
'6a62e4dd-0814-4aa4-b73f-a9b6791d3846',
'4c7b7751-cdb6-4745-8577-07f4b164cda9',
'22614a88-b47a-4ce3-9b75-4064fbf54b53',
'ee4c2d73-a163-4edc-8f4a-ecf6e0a6fd5b',
'fa00c8de-9ebc-48cf-a364-61d9cdd1e220',
'1b522518-4677-4a8e-a069-e223fa86225b',
'57338314-c12a-4f94-8a0e-6bed58910a10',
'e99b177e-9a21-40ef-8d12-c1a887a3ab89',
'66021e33-e784-4432-9210-47158def9088',
'5022f47e-0c0a-4c86-b452-85650ca4eaf6',
'bb84efac-bc07-49b0-940e-709f81880201',
'0fcfbb85-7591-4a48-8484-2cb0ae52a369',
'e3faa947-c067-4300-a520-7752fe08fb97',
'8b91d125-b63f-46b1-8393-af094b923342',
'8094aca6-6830-4ccb-bd60-3b8eedd35c89',
'd6600125-6e21-4b27-b369-7d55a09a16f0',
'0e3d909d-62ca-4e70-bd1f-0c8e6271f7b6',
'373b1228-8157-4f36-b292-e903ced118ad',
'750507ec-e07b-414e-ab6c-c770b5e82caf',
'19986f1d-0d9b-4a8e-a95b-f0870caed0c9',
'f77600c2-1323-4eaf-b202-eba7b9131316',
'cf6f705b-a893-41b3-8f7f-ed59d02478cc',
'1a91e1c7-eaae-493f-b402-ec68be5efefb',
'63ab9cf3-819c-48b3-9023-b72d3687f638',
'bd5677c2-0f4d-41b0-bc91-7705ccb7116a',
'b41b5dc0-a656-44cb-a867-8793ba71500b',
'894add88-cb0d-4b60-9c92-6d3d6f930bde',
'867d8d4f-268a-40d3-a190-4f381180a0ac',
'4fea77fd-b2f6-4789-b56e-f25bba49eac6',
'c3ae533d-286a-4a32-a172-900b0a1dd341',
'a292794f-2fa8-4f57-a320-fce8b6494aa2',
'8da07c7b-e25f-48b5-90a2-8631b2f397df',
'e625550a-9f0d-4b6d-b7e8-6040e3aad7cb',
'e485d6c4-7d80-4f28-97d0-5fc116b9ecd9',
'e0885032-163d-4747-8c4e-d5d539a4db17',
'0bb6849a-c950-460b-8ec3-6bac579539bd',
'4cee80de-212f-4304-8055-5049aeffda5a',
'69b16b59-1296-470c-a551-2f3063feb46d',
'aa9e9d88-ccbd-46e2-88a9-3ba1841fea04',
'ea3229a9-9c45-419e-ac2a-ce8382203140',
'34049739-4e85-4460-b83d-719e0ad8a040',
'9d167b77-b335-47b9-a7cc-d10936cb2feb',
'816f642c-d331-4899-8ca0-dbe4c13ed88c',
'7c4e1c4a-f253-4789-934f-e424290b6b72',
'1b0fedcd-5afe-47e4-8107-6f64164e89e1',
'9ab9da17-39dc-4efc-a12c-42f86bf085ae',
'8f68dc9c-f01e-4546-a921-6911a2e70a7f',
'20aaa00e-1a8f-498c-b822-172dc92b19d4',
'7389e023-fe57-4c48-9c72-ef20ed00b1d6',
'5400a349-3269-4bd0-96a8-edfa5775a53e',
'0e3517c5-04f1-4ef7-b6f4-6a4df3d0929c',
'cee83a8f-38c5-4d0f-836a-65f4076b83d2',
'1f82e9f1-4ac7-43f6-b482-ef255307d0b6',
'a549fe05-1fe4-48f3-be39-9bc8c25fc684',
'66cfe09a-23f6-4fc6-8eb4-7b5d1333a68c',
'7b38d7a3-1682-44a6-84be-95f6d4f1a8ea',
'f14e88d5-42bd-4dab-b141-016c3661c657',
'482cd384-a32f-477d-98e5-a65dd95e4611',
'1c95e70d-d845-4d74-acf0-776b24aa108f',
'da990f0e-bee4-4485-aeac-3bbec4f90085',
'1de9e7d7-283e-4ac5-9c5e-d1ad50beca45',
'6549435c-e67a-4261-9e9e-95226bfb0840',
'96e102a5-4914-44bb-bbbc-18dd46d5405e',
'99507aa5-c0d1-416c-82f7-511e5d269d83',
'1f657a44-8b0f-4f6f-98b2-2bc00ef38cc3',
'4dfe386b-1abe-42bc-8279-b9a408fa1353',
'71e353b2-a580-41d3-a6d8-11aa08ce8be2',
'4ccae28c-9f2f-457e-8bc4-9e28d3ae2288',
'82395c76-48ff-4cfd-8cfd-85248678c01b',
'33034732-6f39-4248-b2ed-ff00192897ca',
'4dc03465-cdb4-4cc2-94db-93507ac31998',
'af0fd6a7-cb39-4f67-be93-8725e39d7170',
'd2123df3-5744-410b-9594-38c2fa0da899',
'a2da69d6-047d-42cb-855a-3bd272fd83db',
'64f84dfa-0a4f-48e8-9dee-5e947a3a2f6f'
)
and routingstatustypeid in (56,58)
and activeflag = 1; 




update routing
set activeflag = 0,
	updatedby = 'CJAMS-58690',
	updatedon = now()
where routingid in (
'7a637154-8e68-4b8d-989b-d698b10d6e87',
'd67a7b61-d7da-4006-a767-a80b17595114',
'cfb4a37d-9b13-4612-a997-c1015e86a79e',
'079bc8f9-3491-4d31-bf0d-a05b25b897ba',
'd48d943f-0abe-457a-8dea-4d16b5d740f5',
'910ecd5d-4f3e-4ba5-9ee9-4f464828798c',
'9e67f317-deaa-4421-bdd2-89677076c266',
'6312aa2d-142b-4f71-8afc-68ea59827093',
'43910cd9-4258-45db-9233-6f4c1da31730',
'c90f1aac-2ade-4fa9-ae45-7011806afc57',
'06ad31ca-6839-40e4-9d36-0a7943b6fd47',
'a1cf110e-9893-4bd9-b071-75cc90019e6a',
'72d6f1e9-7cd1-418c-9435-56f079e46b82',
'768c5d75-a1c3-4d39-8de9-f520ea72fd3c',
'a748315b-e573-485c-bed1-9673117610f5',
'a5b7d223-6c79-462b-8786-78c35b336257',
'642e795d-617b-42e8-a4e4-07faff17e0fd',
'eec28854-e7aa-4aa8-ac37-5f4033e46c8a',
'c2457c19-4c9e-4dc9-afe7-2dd12a3af1e9',
'6c9806ff-77a1-4643-a174-2b31583690cc',
'3b736048-3d15-409f-9dc8-19f7a68aee6f',
'd7addb57-2a4d-4299-9622-9da548a82ec5',
'66021e33-e784-4432-9210-47158def9088',
'a4e6a2c0-4403-4d64-a171-c75aa68209cc',
'7957a0f5-d964-4bd3-bd34-b5960a17d44b',
'e2354c5f-3603-499d-9085-afd538204910',
'10be5fa6-e7a2-4c41-a9b7-ad3a43587547',
'4c16bc3a-f5cc-4ef2-b2c0-c26235de4736',
'657a9638-648b-41d1-b1e0-42694427333c',
'f2a148ce-4319-4da2-a7a9-969704ded851',
'3891ffe3-9ceb-43b3-952a-c23068bf7193',
'9a5e8e81-ec87-4715-aec7-3b5b4e2899a7',
'64dec140-c811-4e6b-a742-e52858892615',
'3ac8a8ef-2f43-4e97-afa1-4ed2452a8f50',
'79a0e64a-35cb-4fc0-b775-ced49b61585e',
'06ad31ca-6839-40e4-9d36-0a7943b6fd47',
'e064d360-ca97-410e-be0c-19ec430346ff',
'35699462-9555-4d2d-a0cd-f753bb0d5782',
'f5ec7578-ffa2-48b8-8e44-95a4b10adf0e',
'87e5dc10-2db0-403d-96b6-29b04b98a2a9',
'c93ee02a-2cc0-4ab8-8cac-35e9561cc151',
'6ee7ca7c-08dc-43f8-93fe-389ccf8724f1',
'b038ff3e-eacd-44f3-b5ca-b3eb088bc58f',
'91d9263e-f0f9-47d9-8f08-93d2aff66d7f',
'f0527f87-790c-4a9d-9917-3ae273f81d86',
'123c1ab0-168a-439f-86d8-36047c3da139'

)
and routingstatustypeid = 56
and activeflag = 1;


update routing
set routingstatustypeid = 58,
	updatedby = 'CJAMS-58690',
	updatedon = now()
where routingid in (
'487689fc-d26a-43e9-b8cc-f38f7f43600d',
'7ef89165-76cf-4af6-8ddc-8ad0c032661a',
'867d94f2-8b7a-4cb2-8b2a-12dd8a3bc9fa',
'2d2e89ce-65df-4a5c-a42e-7a74b2f4718f',
'9022931a-9498-4c91-a2e4-248bc4725060',
'7ef89165-76cf-4af6-8ddc-8ad0c032661a',
'98aa5493-484d-4c17-80a2-ccdb372c21de'
)
	and activeflag = 1
	and routingstatustypeid is null;

---- To Fix the Child Account Balances
-- Closed but balance available client id
/*3184653
1435072
1699748
3816024
1691544
1678306*/

--client ID: 3184653
update tb_client_account ta
set obligated_for_anc = 
	 ( select coalesce(sum(spa.cost_no),0) 
			from tb_service_purchase_authorization spa
		where spa.delete_sw  = 'N'
			and spa.authorization_id 
				in (	select tr.authorization_id 
							from tb_account_transaction tr
						where tr.client_account_id = 12579
							and tr.delete_sw = 'N'
							and tr.authorization_id is not null
							and (select count(*)
									from tb_payment_header ph
								 where ph.authorization_id = tr.authorization_id
									and ph.delete_sw = 'N'
								) = 0 
							and (select count(*)
									from routing ro
								 where ro.objectid::character varying = tr.authorization_id::character varying
									and ro.activeflag = 1
									and ro.routingstatustypeid = '62'
								) = 0
					)
	),	
	update_ts = now(),
	update_user_id = 'CJAMS-58690'
where ta.client_account_id = 12579
and ta.delete_sw = 'N' ;

update tb_client_account ta
set total_balance_no = 
	(
		coalesce(( select sum(coalesce(tr.transaction_amount_no,0))
			from tb_account_transaction tr
			where tr.client_account_id = ta.client_account_id
			   and ( 	tr.transaction_type_cd <> '588' 
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd = '5472' )
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd <> '5472' 
							and tr.adjustment_approval_status_cd = '3047' ) 
					)
			   and tr.transaction_type_cd <> '5530'    
			   and tr.credit_debit_sw = 'C'
			   and tr.delete_sw = 'N' 
		),0)	   
		- 
		coalesce(( select sum(coalesce(tr.transaction_amount_no,0))
			from tb_account_transaction  tr
			where tr.client_account_id =  ta.client_account_id
				and ( 	tr.transaction_type_cd <> '588' 
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd = '5472' )
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd <> '5472' 
							and tr.adjustment_approval_status_cd = '3047' ) 
					)
				and tr.transaction_type_cd <> '5530'    
				and tr.credit_debit_sw = 'D'
				and tr.delete_sw = 'N' 
		),0)
	),
	obligated_for_coc = 
	coalesce(( select
		( select sum(coalesce(tr.transaction_amount_no,0))
			from tb_account_transaction tr
		   where tr.client_account_id = ca.client_account_id
			and tr.delete_sw = 'N'
			and tr.credit_debit_sw = 'C'
			and tr.transaction_source_cd in ('587','586','585')	
			and benefit_start_dt > f_daymonth((current_date - interval '2 month')::date  ,'L' , 'C') 
		 )
		+
		coalesce((
		  select sum(coalesce(tr1.transaction_amount_no,0))	
			from tb_account_transaction tr1
		   where tr1.transaction_type_cd = '588'
			and tr1.credit_debit_sw = 'C'
			and tr1.transaction_source_cd = '5473'	
			and tr1.adjustment_approval_status_cd = '3047'
			and tr1.reference_transaction_id in
					(
					  select tr.transaction_id
						from tb_account_transaction tr
					  where tr.client_account_id = ca.client_account_id
						and tr.delete_sw = 'N'
						and tr.credit_debit_sw = 'C'
						and tr.transaction_source_cd in ('587','586','585')	
						and benefit_start_dt > f_daymonth((current_date - interval '2 month')::date  ,'L' , 'C') 
					)

		),0)
		-
		coalesce((
		  select sum(coalesce(tr1.transaction_amount_no,0))	
			from tb_account_transaction tr1
		   where tr1.transaction_type_cd = '588'
			and tr1.credit_debit_sw = 'D'
			and tr1.transaction_source_cd = '5473'	
			and tr1.adjustment_approval_status_cd = '3047'
			and tr1.reference_transaction_id in
					(
					  select tr.transaction_id
						from tb_account_transaction tr
					  where tr.client_account_id = ca.client_account_id
						and tr.delete_sw = 'N'
						and tr.credit_debit_sw = 'C'
						and tr.transaction_source_cd in ('587','586','585')	
						and benefit_start_dt > f_daymonth((current_date - interval '2 month')::date  ,'L' , 'C') 
					)

		),0)
		from tb_client_account ca
	where ca.client_account_id = ta.client_account_id
		and ca.delete_sw = 'N'
	),0),
	update_ts = now(),
	update_user_id = 'CJAMS-58690'
where ta.client_account_id = 12579
	and ta.delete_sw = 'N' ;
			
update tb_client_account ta
set available_balance_no = total_balance_no - ( coalesce(obligated_for_anc,0)  + coalesce(obligated_for_coc,0) ),
	update_ts = now(),
	update_user_id = 'CJAMS-58690'
where ta.client_account_id = 12579
	and ta.delete_sw = 'N' ;

-- Commigled Account
-- Update Commingled Account Balance
/*update cjams.tb_commingled_account
	set total_balance_no = ( select sum(coalesce(total_balance_no,0))
								from cjams.tb_client_account
							 where comm_account_id = 201
								and delete_sw = 'N' ),
		update_ts = now(),
		update_user_id = 'CJAMS-58690'
where comm_account_id = 201
	and delete_sw = 'N' ;*/



-- Client ID: 1435072

update tb_client_account ta
set obligated_for_anc = 
	 ( select coalesce(sum(spa.cost_no),0) 
			from tb_service_purchase_authorization spa
		where spa.delete_sw  = 'N'
			and spa.authorization_id 
				in (	select tr.authorization_id 
							from tb_account_transaction tr
						where tr.client_account_id = 11529
							and tr.delete_sw = 'N'
							and tr.authorization_id is not null
							and (select count(*)
									from tb_payment_header ph
								 where ph.authorization_id = tr.authorization_id
									and ph.delete_sw = 'N'
								) = 0 
							and (select count(*)
									from routing ro
								 where ro.objectid::character varying = tr.authorization_id::character varying
									and ro.activeflag = 1
									and ro.routingstatustypeid = '62'
								) = 0
					)
	),	
	update_ts = now(),
	update_user_id = 'CJAMS-58690'
where ta.client_account_id = 11529
and ta.delete_sw = 'N' ;

update tb_client_account ta
set total_balance_no = 
	(
		coalesce(( select sum(coalesce(tr.transaction_amount_no,0))
			from tb_account_transaction tr
			where tr.client_account_id = ta.client_account_id
			   and ( 	tr.transaction_type_cd <> '588' 
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd = '5472' )
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd <> '5472' 
							and tr.adjustment_approval_status_cd = '3047' ) 
					)
			   and tr.transaction_type_cd <> '5530'    
			   and tr.credit_debit_sw = 'C'
			   and tr.delete_sw = 'N' 
		),0)	   
		- 
		coalesce(( select sum(coalesce(tr.transaction_amount_no,0))
			from tb_account_transaction  tr
			where tr.client_account_id =  ta.client_account_id
				and ( 	tr.transaction_type_cd <> '588' 
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd = '5472' )
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd <> '5472' 
							and tr.adjustment_approval_status_cd = '3047' ) 
					)
				and tr.transaction_type_cd <> '5530'    
				and tr.credit_debit_sw = 'D'
				and tr.delete_sw = 'N' 
		),0)
	),
	obligated_for_coc = 
	coalesce(( select
		( select sum(coalesce(tr.transaction_amount_no,0))
			from tb_account_transaction tr
		   where tr.client_account_id = ca.client_account_id
			and tr.delete_sw = 'N'
			and tr.credit_debit_sw = 'C'
			and tr.transaction_source_cd in ('587','586','585')	
			and benefit_start_dt > f_daymonth((current_date - interval '2 month')::date  ,'L' , 'C') 
		 )
		+
		coalesce((
		  select sum(coalesce(tr1.transaction_amount_no,0))	
			from tb_account_transaction tr1
		   where tr1.transaction_type_cd = '588'
			and tr1.credit_debit_sw = 'C'
			and tr1.transaction_source_cd = '5473'	
			and tr1.adjustment_approval_status_cd = '3047'
			and tr1.reference_transaction_id in
					(
					  select tr.transaction_id
						from tb_account_transaction tr
					  where tr.client_account_id = ca.client_account_id
						and tr.delete_sw = 'N'
						and tr.credit_debit_sw = 'C'
						and tr.transaction_source_cd in ('587','586','585')	
						and benefit_start_dt > f_daymonth((current_date - interval '2 month')::date  ,'L' , 'C') 
					)

		),0)
		-
		coalesce((
		  select sum(coalesce(tr1.transaction_amount_no,0))	
			from tb_account_transaction tr1
		   where tr1.transaction_type_cd = '588'
			and tr1.credit_debit_sw = 'D'
			and tr1.transaction_source_cd = '5473'	
			and tr1.adjustment_approval_status_cd = '3047'
			and tr1.reference_transaction_id in
					(
					  select tr.transaction_id
						from tb_account_transaction tr
					  where tr.client_account_id = ca.client_account_id
						and tr.delete_sw = 'N'
						and tr.credit_debit_sw = 'C'
						and tr.transaction_source_cd in ('587','586','585')	
						and benefit_start_dt > f_daymonth((current_date - interval '2 month')::date  ,'L' , 'C') 
					)

		),0)
		from tb_client_account ca
	where ca.client_account_id = ta.client_account_id
		and ca.delete_sw = 'N'
	),0),
	update_ts = now(),
	update_user_id = 'CJAMS-58690'
where ta.client_account_id = 11529
	and ta.delete_sw = 'N' ;
			
update tb_client_account ta
set available_balance_no = total_balance_no - ( coalesce(obligated_for_anc,0)  + coalesce(obligated_for_coc,0) ),
	update_ts = now(),
	update_user_id = 'CJAMS-58690'
where ta.client_account_id = 11529
	and ta.delete_sw = 'N' ;


-- ClientID: 1699748

update tb_client_account ta
set obligated_for_anc = 
	 ( select coalesce(sum(spa.cost_no),0) 
			from tb_service_purchase_authorization spa
		where spa.delete_sw  = 'N'
			and spa.authorization_id 
				in (	select tr.authorization_id 
							from tb_account_transaction tr
						where tr.client_account_id = 12736
							and tr.delete_sw = 'N'
							and tr.authorization_id is not null
							and (select count(*)
									from tb_payment_header ph
								 where ph.authorization_id = tr.authorization_id
									and ph.delete_sw = 'N'
								) = 0 
							and (select count(*)
									from routing ro
								 where ro.objectid::character varying = tr.authorization_id::character varying
									and ro.activeflag = 1
									and ro.routingstatustypeid = '62'
								) = 0
					)
	),	
	update_ts = now(),
	update_user_id = 'CJAMS-58690'
where ta.client_account_id = 12736
and ta.delete_sw = 'N' ;

update tb_client_account ta
set total_balance_no = 
	(
		coalesce(( select sum(coalesce(tr.transaction_amount_no,0))
			from tb_account_transaction tr
			where tr.client_account_id = ta.client_account_id
			   and ( 	tr.transaction_type_cd <> '588' 
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd = '5472' )
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd <> '5472' 
							and tr.adjustment_approval_status_cd = '3047' ) 
					)
			   and tr.transaction_type_cd <> '5530'    
			   and tr.credit_debit_sw = 'C'
			   and tr.delete_sw = 'N' 
		),0)	   
		- 
		coalesce(( select sum(coalesce(tr.transaction_amount_no,0))
			from tb_account_transaction  tr
			where tr.client_account_id =  ta.client_account_id
				and ( 	tr.transaction_type_cd <> '588' 
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd = '5472' )
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd <> '5472' 
							and tr.adjustment_approval_status_cd = '3047' ) 
					)
				and tr.transaction_type_cd <> '5530'    
				and tr.credit_debit_sw = 'D'
				and tr.delete_sw = 'N' 
		),0)
	),
	obligated_for_coc = 
	coalesce(( select
		( select sum(coalesce(tr.transaction_amount_no,0))
			from tb_account_transaction tr
		   where tr.client_account_id = ca.client_account_id
			and tr.delete_sw = 'N'
			and tr.credit_debit_sw = 'C'
			and tr.transaction_source_cd in ('587','586','585')	
			and benefit_start_dt > f_daymonth((current_date - interval '2 month')::date  ,'L' , 'C') 
		 )
		+
		coalesce((
		  select sum(coalesce(tr1.transaction_amount_no,0))	
			from tb_account_transaction tr1
		   where tr1.transaction_type_cd = '588'
			and tr1.credit_debit_sw = 'C'
			and tr1.transaction_source_cd = '5473'	
			and tr1.adjustment_approval_status_cd = '3047'
			and tr1.reference_transaction_id in
					(
					  select tr.transaction_id
						from tb_account_transaction tr
					  where tr.client_account_id = ca.client_account_id
						and tr.delete_sw = 'N'
						and tr.credit_debit_sw = 'C'
						and tr.transaction_source_cd in ('587','586','585')	
						and benefit_start_dt > f_daymonth((current_date - interval '2 month')::date  ,'L' , 'C') 
					)

		),0)
		-
		coalesce((
		  select sum(coalesce(tr1.transaction_amount_no,0))	
			from tb_account_transaction tr1
		   where tr1.transaction_type_cd = '588'
			and tr1.credit_debit_sw = 'D'
			and tr1.transaction_source_cd = '5473'	
			and tr1.adjustment_approval_status_cd = '3047'
			and tr1.reference_transaction_id in
					(
					  select tr.transaction_id
						from tb_account_transaction tr
					  where tr.client_account_id = ca.client_account_id
						and tr.delete_sw = 'N'
						and tr.credit_debit_sw = 'C'
						and tr.transaction_source_cd in ('587','586','585')	
						and benefit_start_dt > f_daymonth((current_date - interval '2 month')::date  ,'L' , 'C') 
					)

		),0)
		from tb_client_account ca
	where ca.client_account_id = ta.client_account_id
		and ca.delete_sw = 'N'
	),0),
	update_ts = now(),
	update_user_id = 'CJAMS-58690'
where ta.client_account_id = 12736
	and ta.delete_sw = 'N' ;
			
update tb_client_account ta
set available_balance_no = total_balance_no - ( coalesce(obligated_for_anc,0)  + coalesce(obligated_for_coc,0) ),
	update_ts = now(),
	update_user_id = 'CJAMS-58690'
where ta.client_account_id = 12736
	and ta.delete_sw = 'N' ;


-- ClientID: 3816024

update tb_client_account ta
set obligated_for_anc = 
	 ( select coalesce(sum(spa.cost_no),0) 
			from tb_service_purchase_authorization spa
		where spa.delete_sw  = 'N'
			and spa.authorization_id 
				in (	select tr.authorization_id 
							from tb_account_transaction tr
						where tr.client_account_id = 12882
							and tr.delete_sw = 'N'
							and tr.authorization_id is not null
							and (select count(*)
									from tb_payment_header ph
								 where ph.authorization_id = tr.authorization_id
									and ph.delete_sw = 'N'
								) = 0 
							and (select count(*)
									from routing ro
								 where ro.objectid::character varying = tr.authorization_id::character varying
									and ro.activeflag = 1
									and ro.routingstatustypeid = '62'
								) = 0
					)
	),	
	update_ts = now(),
	update_user_id = 'CJAMS-58690'
where ta.client_account_id = 12882
and ta.delete_sw = 'N' ;

update tb_client_account ta
set total_balance_no = 
	(
		coalesce(( select sum(coalesce(tr.transaction_amount_no,0))
			from tb_account_transaction tr
			where tr.client_account_id = ta.client_account_id
			   and ( 	tr.transaction_type_cd <> '588' 
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd = '5472' )
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd <> '5472' 
							and tr.adjustment_approval_status_cd = '3047' ) 
					)
			   and tr.transaction_type_cd <> '5530'    
			   and tr.credit_debit_sw = 'C'
			   and tr.delete_sw = 'N' 
		),0)	   
		- 
		coalesce(( select sum(coalesce(tr.transaction_amount_no,0))
			from tb_account_transaction  tr
			where tr.client_account_id =  ta.client_account_id
				and ( 	tr.transaction_type_cd <> '588' 
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd = '5472' )
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd <> '5472' 
							and tr.adjustment_approval_status_cd = '3047' ) 
					)
				and tr.transaction_type_cd <> '5530'    
				and tr.credit_debit_sw = 'D'
				and tr.delete_sw = 'N' 
		),0)
	),
	obligated_for_coc = 
	coalesce(( select
		( select sum(coalesce(tr.transaction_amount_no,0))
			from tb_account_transaction tr
		   where tr.client_account_id = ca.client_account_id
			and tr.delete_sw = 'N'
			and tr.credit_debit_sw = 'C'
			and tr.transaction_source_cd in ('587','586','585')	
			and benefit_start_dt > f_daymonth((current_date - interval '2 month')::date  ,'L' , 'C') 
		 )
		+
		coalesce((
		  select sum(coalesce(tr1.transaction_amount_no,0))	
			from tb_account_transaction tr1
		   where tr1.transaction_type_cd = '588'
			and tr1.credit_debit_sw = 'C'
			and tr1.transaction_source_cd = '5473'	
			and tr1.adjustment_approval_status_cd = '3047'
			and tr1.reference_transaction_id in
					(
					  select tr.transaction_id
						from tb_account_transaction tr
					  where tr.client_account_id = ca.client_account_id
						and tr.delete_sw = 'N'
						and tr.credit_debit_sw = 'C'
						and tr.transaction_source_cd in ('587','586','585')	
						and benefit_start_dt > f_daymonth((current_date - interval '2 month')::date  ,'L' , 'C') 
					)

		),0)
		-
		coalesce((
		  select sum(coalesce(tr1.transaction_amount_no,0))	
			from tb_account_transaction tr1
		   where tr1.transaction_type_cd = '588'
			and tr1.credit_debit_sw = 'D'
			and tr1.transaction_source_cd = '5473'	
			and tr1.adjustment_approval_status_cd = '3047'
			and tr1.reference_transaction_id in
					(
					  select tr.transaction_id
						from tb_account_transaction tr
					  where tr.client_account_id = ca.client_account_id
						and tr.delete_sw = 'N'
						and tr.credit_debit_sw = 'C'
						and tr.transaction_source_cd in ('587','586','585')	
						and benefit_start_dt > f_daymonth((current_date - interval '2 month')::date  ,'L' , 'C') 
					)

		),0)
		from tb_client_account ca
	where ca.client_account_id = ta.client_account_id
		and ca.delete_sw = 'N'
	),0),
	update_ts = now(),
	update_user_id = 'CJAMS-58690'
where ta.client_account_id = 12882
	and ta.delete_sw = 'N' ;
			
update tb_client_account ta
set available_balance_no = total_balance_no - ( coalesce(obligated_for_anc,0)  + coalesce(obligated_for_coc,0) ),
	update_ts = now(),
	update_user_id = 'CJAMS-58690'
where ta.client_account_id = 12882
	and ta.delete_sw = 'N' ;

-- Commigled Account
-- Update Commingled Account Balance
/*update cjams.tb_commingled_account
	set total_balance_no = ( select sum(coalesce(total_balance_no,0))
								from cjams.tb_client_account
							 where comm_account_id = 201
								and delete_sw = 'N' ),
		update_ts = now(),
		update_user_id = 'CJAMS-58690'
where comm_account_id = 201
	and delete_sw = 'N' ;*/



--clientID: 1691544
update tb_client_account ta
set obligated_for_anc = 
	 ( select coalesce(sum(spa.cost_no),0) 
			from tb_service_purchase_authorization spa
		where spa.delete_sw  = 'N'
			and spa.authorization_id 
				in (	select tr.authorization_id 
							from tb_account_transaction tr
						where tr.client_account_id = 12911
							and tr.delete_sw = 'N'
							and tr.authorization_id is not null
							and (select count(*)
									from tb_payment_header ph
								 where ph.authorization_id = tr.authorization_id
									and ph.delete_sw = 'N'
								) = 0 
							and (select count(*)
									from routing ro
								 where ro.objectid::character varying = tr.authorization_id::character varying
									and ro.activeflag = 1
									and ro.routingstatustypeid = '62'
								) = 0
					)
	),	
	update_ts = now(),
	update_user_id = 'CJAMS-58690'
where ta.client_account_id = 12911
and ta.delete_sw = 'N' ;

update tb_client_account ta
set total_balance_no = 
	(
		coalesce(( select sum(coalesce(tr.transaction_amount_no,0))
			from tb_account_transaction tr
			where tr.client_account_id = ta.client_account_id
			   and ( 	tr.transaction_type_cd <> '588' 
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd = '5472' )
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd <> '5472' 
							and tr.adjustment_approval_status_cd = '3047' ) 
					)
			   and tr.transaction_type_cd <> '5530'    
			   and tr.credit_debit_sw = 'C'
			   and tr.delete_sw = 'N' 
		),0)	   
		- 
		coalesce(( select sum(coalesce(tr.transaction_amount_no,0))
			from tb_account_transaction  tr
			where tr.client_account_id =  ta.client_account_id
				and ( 	tr.transaction_type_cd <> '588' 
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd = '5472' )
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd <> '5472' 
							and tr.adjustment_approval_status_cd = '3047' ) 
					)
				and tr.transaction_type_cd <> '5530'    
				and tr.credit_debit_sw = 'D'
				and tr.delete_sw = 'N' 
		),0)
	),
	obligated_for_coc = 
	coalesce(( select
		( select sum(coalesce(tr.transaction_amount_no,0))
			from tb_account_transaction tr
		   where tr.client_account_id = ca.client_account_id
			and tr.delete_sw = 'N'
			and tr.credit_debit_sw = 'C'
			and tr.transaction_source_cd in ('587','586','585')	
			and benefit_start_dt > f_daymonth((current_date - interval '2 month')::date  ,'L' , 'C') 
		 )
		+
		coalesce((
		  select sum(coalesce(tr1.transaction_amount_no,0))	
			from tb_account_transaction tr1
		   where tr1.transaction_type_cd = '588'
			and tr1.credit_debit_sw = 'C'
			and tr1.transaction_source_cd = '5473'	
			and tr1.adjustment_approval_status_cd = '3047'
			and tr1.reference_transaction_id in
					(
					  select tr.transaction_id
						from tb_account_transaction tr
					  where tr.client_account_id = ca.client_account_id
						and tr.delete_sw = 'N'
						and tr.credit_debit_sw = 'C'
						and tr.transaction_source_cd in ('587','586','585')	
						and benefit_start_dt > f_daymonth((current_date - interval '2 month')::date  ,'L' , 'C') 
					)

		),0)
		-
		coalesce((
		  select sum(coalesce(tr1.transaction_amount_no,0))	
			from tb_account_transaction tr1
		   where tr1.transaction_type_cd = '588'
			and tr1.credit_debit_sw = 'D'
			and tr1.transaction_source_cd = '5473'	
			and tr1.adjustment_approval_status_cd = '3047'
			and tr1.reference_transaction_id in
					(
					  select tr.transaction_id
						from tb_account_transaction tr
					  where tr.client_account_id = ca.client_account_id
						and tr.delete_sw = 'N'
						and tr.credit_debit_sw = 'C'
						and tr.transaction_source_cd in ('587','586','585')	
						and benefit_start_dt > f_daymonth((current_date - interval '2 month')::date  ,'L' , 'C') 
					)

		),0)
		from tb_client_account ca
	where ca.client_account_id = ta.client_account_id
		and ca.delete_sw = 'N'
	),0),
	update_ts = now(),
	update_user_id = 'CJAMS-58690'
where ta.client_account_id = 12911
	and ta.delete_sw = 'N' ;
			
update tb_client_account ta
set available_balance_no = total_balance_no - ( coalesce(obligated_for_anc,0)  + coalesce(obligated_for_coc,0) ),
	update_ts = now(),
	update_user_id = 'CJAMS-58690'
where ta.client_account_id = 12911
	and ta.delete_sw = 'N' ;

-- Commigled Account
-- Update Commingled Account Balance
/*update cjams.tb_commingled_account
	set total_balance_no = ( select sum(coalesce(total_balance_no,0))
								from cjams.tb_client_account
							 where comm_account_id = 201
								and delete_sw = 'N' ),
		update_ts = now(),
		update_user_id = 'CJAMS-58690'
where comm_account_id = 201
	and delete_sw = 'N' ;*/



--clientID: 1678306
update tb_client_account ta
set obligated_for_anc = 
	 ( select coalesce(sum(spa.cost_no),0) 
			from tb_service_purchase_authorization spa
		where spa.delete_sw  = 'N'
			and spa.authorization_id 
				in (	select tr.authorization_id 
							from tb_account_transaction tr
						where tr.client_account_id = 14024
							and tr.delete_sw = 'N'
							and tr.authorization_id is not null
							and (select count(*)
									from tb_payment_header ph
								 where ph.authorization_id = tr.authorization_id
									and ph.delete_sw = 'N'
								) = 0 
							and (select count(*)
									from routing ro
								 where ro.objectid::character varying = tr.authorization_id::character varying
									and ro.activeflag = 1
									and ro.routingstatustypeid = '62'
								) = 0
					)
	),	
	update_ts = now(),
	update_user_id = 'CJAMS-58690'
where ta.client_account_id = 14024
and ta.delete_sw = 'N' ;

update tb_client_account ta
set total_balance_no = 
	(
		coalesce(( select sum(coalesce(tr.transaction_amount_no,0))
			from tb_account_transaction tr
			where tr.client_account_id = ta.client_account_id
			   and ( 	tr.transaction_type_cd <> '588' 
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd = '5472' )
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd <> '5472' 
							and tr.adjustment_approval_status_cd = '3047' ) 
					)
			   and tr.transaction_type_cd <> '5530'    
			   and tr.credit_debit_sw = 'C'
			   and tr.delete_sw = 'N' 
		),0)	   
		- 
		coalesce(( select sum(coalesce(tr.transaction_amount_no,0))
			from tb_account_transaction  tr
			where tr.client_account_id =  ta.client_account_id
				and ( 	tr.transaction_type_cd <> '588' 
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd = '5472' )
						or
						( tr.transaction_type_cd = '588' and tr.transaction_source_cd <> '5472' 
							and tr.adjustment_approval_status_cd = '3047' ) 
					)
				and tr.transaction_type_cd <> '5530'    
				and tr.credit_debit_sw = 'D'
				and tr.delete_sw = 'N' 
		),0)
	),
	obligated_for_coc = 
	coalesce(( select
		( select sum(coalesce(tr.transaction_amount_no,0))
			from tb_account_transaction tr
		   where tr.client_account_id = ca.client_account_id
			and tr.delete_sw = 'N'
			and tr.credit_debit_sw = 'C'
			and tr.transaction_source_cd in ('587','586','585')	
			and benefit_start_dt > f_daymonth((current_date - interval '2 month')::date  ,'L' , 'C') 
		 )
		+
		coalesce((
		  select sum(coalesce(tr1.transaction_amount_no,0))	
			from tb_account_transaction tr1
		   where tr1.transaction_type_cd = '588'
			and tr1.credit_debit_sw = 'C'
			and tr1.transaction_source_cd = '5473'	
			and tr1.adjustment_approval_status_cd = '3047'
			and tr1.reference_transaction_id in
					(
					  select tr.transaction_id
						from tb_account_transaction tr
					  where tr.client_account_id = ca.client_account_id
						and tr.delete_sw = 'N'
						and tr.credit_debit_sw = 'C'
						and tr.transaction_source_cd in ('587','586','585')	
						and benefit_start_dt > f_daymonth((current_date - interval '2 month')::date  ,'L' , 'C') 
					)

		),0)
		-
		coalesce((
		  select sum(coalesce(tr1.transaction_amount_no,0))	
			from tb_account_transaction tr1
		   where tr1.transaction_type_cd = '588'
			and tr1.credit_debit_sw = 'D'
			and tr1.transaction_source_cd = '5473'	
			and tr1.adjustment_approval_status_cd = '3047'
			and tr1.reference_transaction_id in
					(
					  select tr.transaction_id
						from tb_account_transaction tr
					  where tr.client_account_id = ca.client_account_id
						and tr.delete_sw = 'N'
						and tr.credit_debit_sw = 'C'
						and tr.transaction_source_cd in ('587','586','585')	
						and benefit_start_dt > f_daymonth((current_date - interval '2 month')::date  ,'L' , 'C') 
					)

		),0)
		from tb_client_account ca
	where ca.client_account_id = ta.client_account_id
		and ca.delete_sw = 'N'
	),0),
	update_ts = now(),
	update_user_id = 'CJAMS-58690'
where ta.client_account_id = 14024
	and ta.delete_sw = 'N' ;
			
update tb_client_account ta
set available_balance_no = total_balance_no - ( coalesce(obligated_for_anc,0)  + coalesce(obligated_for_coc,0) ),
	update_ts = now(),
	update_user_id = 'CJAMS-58690'
where ta.client_account_id = 14024
	and ta.delete_sw = 'N' ;

-- Commigled Account
-- If the commigled account number present in 
--select status_cd ,delete_sw ,total_balance_no,available_balance_no,comm_account_id,* from tb_client_account tca where client_id =1678306-- and status_cd = '593' 
-- Update Commingled Account Balance
/*update cjams.tb_commingled_account
	set total_balance_no = ( select sum(coalesce(total_balance_no,0))
								from cjams.tb_client_account
							 where comm_account_id = 201
								and delete_sw = 'N' ),
		update_ts = now(),
		update_user_id = 'CJAMS-58690'
where comm_account_id = 201
	and delete_sw = 'N' ;*/