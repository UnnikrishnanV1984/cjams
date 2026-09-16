-- CDM-10961 - Case closure records for a service case

INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
VALUES('7d29c714-9344-4656-9320-c23cf17f6975', 'fe05c44c-50b2-458d-8316-57300b602e2e', '2020-06-22'::date, 'Closed', 'Closed', 'Child left the home no longer eligible', '2020-06-22'::date, 1, '03756649-cfd6-4be6-8c39-75c6a63096c2', now(), 'CDM-10961', now(), NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('SCDR', 'f9a7eff0-c276-456d-ba16-9b104c34c12a', NULL, NULL, NULL, NULL, '7d29c714-9344-4656-9320-c23cf17f6975', 16, 1, 'f9a7eff0-c276-456d-ba16-9b104c34c12a', now(), 'CDM-10961', now(), false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

UPDATE cjams.servicecase 
SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2020-06-22'::date, updatedby = 'CDM-10961',updatedon = now() WHERE servicecaseid = 'fe05c44c-50b2-458d-8316-57300b602e2e' and activeflag = 1;
