-- CDM-10678 - close service case

INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
VALUES('d59f44e4-fec7-44ce-b020-0b6cfbf42b31', 'c91b2edd-fcc7-448f-9643-fb788a2f4cb0', '2021-02-12'::date, 'Closed', 'Closed', 'Star''s case closed at her request as she reunified with her parents out of state', '2021-02-12'::date, 1, '038f50d3-1dc6-4c47-ab32-63952fdb0e5b', now(), '038f50d3-1dc6-4c47-ab32-63952fdb0e5b', now(), NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('SCDR', 'fa484839-8478-4808-9412-261477e894e7', NULL, NULL, NULL, NULL, 'd59f44e4-fec7-44ce-b020-0b6cfbf42b31', 16, 1, 'fa484839-8478-4808-9412-261477e894e7', now(), 'fa484839-8478-4808-9412-261477e894e7', now(), false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

UPDATE cjams.servicecase 
SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2021-02-12'::date, updatedby = 'CDM-10678',updatedon = now() WHERE servicecaseid = 'c91b2edd-fcc7-448f-9643-fb788a2f4cb0' and activeflag = 1;
