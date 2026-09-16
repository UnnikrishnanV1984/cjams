
INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
VALUES('712bb039-b432-436b-beb3-9daf4560ba07', 'feff1095-869d-495e-b990-dd0e52027eba', now(), 'Closed', 'Closed', 'Case Closed', now(), 1, '13991714-046a-47ff-a1ed-81cafaf1997b', now(), 'CDM-7245', now(), NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('SCDR', '13991714-046a-47ff-a1ed-81cafaf1997b', NULL, NULL, NULL, NULL, '712bb039-b432-436b-beb3-9daf4560ba07', 16, 1, '13991714-046a-47ff-a1ed-81cafaf1997b', now(), 'CDM-7245', now(), false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

