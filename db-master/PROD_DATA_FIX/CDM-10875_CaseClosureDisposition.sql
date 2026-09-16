-- CDM-10875 - case closure disposition records

INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
VALUES('42d6ee10-d57c-489d-a423-c9b8f0097d38', '282157a8-8c72-41a9-99e1-8dd5c0495f51', '2020-06-03'::date, 'Closed', 'Closed', 'Child aged out', '2020-06-03'::date, 1, '03756649-cfd6-4be6-8c39-75c6a63096c2', now(), 'CDM-10875', now(), NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('SCDR', 'f9a7eff0-c276-456d-ba16-9b104c34c12a', NULL, NULL, NULL, NULL, '42d6ee10-d57c-489d-a423-c9b8f0097d38', 16, 1, 'f9a7eff0-c276-456d-ba16-9b104c34c12a', now(), 'CDM-10875', now(), false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

UPDATE cjams.servicecase 
SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2020-06-03'::date, updatedby = 'CDM-10875',updatedon = now() WHERE servicecaseid = '282157a8-8c72-41a9-99e1-8dd5c0495f51' and activeflag = 1;
