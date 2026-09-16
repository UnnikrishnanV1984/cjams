INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
VALUES('b2f95e95-9919-4f1f-9396-b9acf8f33d7d', 'ccc9e7c1-59e6-4866-8ae8-c1a2754a49f8', '2020-10-22'::date, 'Closed', 'Closed', 'Case Closed', '2020-10-22'::date, 1, '7915cfc4-37e7-4542-9ee8-b44923981301', now(), 'CDM-6226', now(), NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('SCDR', '7915cfc4-37e7-4542-9ee8-b44923981301', NULL, NULL, NULL, NULL, 'b2f95e95-9919-4f1f-9396-b9acf8f33d7d', 16, 1, '7915cfc4-37e7-4542-9ee8-b44923981301', now(), 'CDM-6226', now(), false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
VALUES('d7c850a9-f2d7-4c9b-8cce-2b1700148c41', '71df6465-6879-4560-8f5d-d40254cac4f8', '2020-10-16'::date, 'Closed', 'Closed', 'Case Closed', '2020-10-16'::date, 1, '7915cfc4-37e7-4542-9ee8-b44923981301', now(), 'CDM-6226', now(), NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('SCDR', '7915cfc4-37e7-4542-9ee8-b44923981301', NULL, NULL, NULL, NULL, 'd7c850a9-f2d7-4c9b-8cce-2b1700148c41', 16, 1, '7915cfc4-37e7-4542-9ee8-b44923981301', now(), 'CDM-6226', now(), false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
VALUES('ad316d78-e6c7-42a6-a816-adc319d61ba0', 'f1e04643-7c86-4e2c-b576-ad0298140e8a', '2020-06-01'::date, 'Closed', 'Closed', 'Case Closed', '2020-06-01'::date, 1, '7915cfc4-37e7-4542-9ee8-b44923981301', now(), 'CDM-6226', now(), NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('SCDR', '7915cfc4-37e7-4542-9ee8-b44923981301', NULL, NULL, NULL, NULL, 'ad316d78-e6c7-42a6-a816-adc319d61ba0', 16, 1, '7915cfc4-37e7-4542-9ee8-b44923981301', now(), 'CDM-6226', now(), false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
