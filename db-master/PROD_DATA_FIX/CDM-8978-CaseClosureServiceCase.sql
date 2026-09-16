-- CDM-8978 - Case closure records for a service case

INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
VALUES('4dece2eb-c340-4f41-805f-7572f100495f', '26ede3b1-26b8-4838-ab71-8df2177e075d', '2021-01-14'::date, 'Closed', 'Closed', 'Case Closed', '2021-01-14'::date, 1, '2bc44bbe-5920-49a3-9e05-ef79c400bf9e', now(), 'CDM-8978', now(), NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('SCDR', '2bc44bbe-5920-49a3-9e05-ef79c400bf9e', NULL, NULL, NULL, NULL, '4dece2eb-c340-4f41-805f-7572f100495f', 16, 1, '2bc44bbe-5920-49a3-9e05-ef79c400bf9e', now(), 'CDM-8978', now(), false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

UPDATE cjams.servicecase 
SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2021-01-14'::date, updatedby = 'CDM-8978',updatedon = now() WHERE servicecaseid = '26ede3b1-26b8-4838-ab71-8df2177e075d' and activeflag = 1;