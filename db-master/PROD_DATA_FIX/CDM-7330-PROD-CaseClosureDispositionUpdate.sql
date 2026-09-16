INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
VALUES('e812b1cc-842d-4762-9f54-8b80baa0fb13', 'f59e571e-c3f6-4832-b23b-17539140f639', '2020-10-17'::date, 'Closed', 'Closed', 'Case Closed', '2020-10-17'::date, 1, '72439d81-dfaa-46d0-a372-f90eb16f75fd', now(), 'CDM-7330', now(), NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('SCDR', '72439d81-dfaa-46d0-a372-f90eb16f75fd', NULL, NULL, NULL, NULL, 'e812b1cc-842d-4762-9f54-8b80baa0fb13', 16, 1, '72439d81-dfaa-46d0-a372-f90eb16f75fd', now(), 'CDM-7330', now(), false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
VALUES('03c106df-7b76-496e-92cf-72401b02e0e2', '5bd23425-9c0d-45a8-945a-05a8b73d9e62', '2020-11-09'::date, 'Closed', 'Closed', 'Case Closed', '2020-11-09'::date, 1, '72439d81-dfaa-46d0-a372-f90eb16f75fd', now(), 'CDM-7330', now(), NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('SCDR', '72439d81-dfaa-46d0-a372-f90eb16f75fd', NULL, NULL, NULL, NULL, '03c106df-7b76-496e-92cf-72401b02e0e2', 16, 1, '72439d81-dfaa-46d0-a372-f90eb16f75fd', now(), 'CDM-7330', now(), false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
