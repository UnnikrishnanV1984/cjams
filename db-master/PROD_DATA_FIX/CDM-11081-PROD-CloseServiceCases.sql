--3275736
update servicecase 
set enddate='2021-03-19 13:00:00', statustypekey='Closed', updatedon=now(), updatedby='CDM-11081'
where servicecaseid ='9f3434fe-fb43-4295-9737-30cf7c2ba11f';

INSERT INTO cjams.servicecasedisposition
(servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
VALUES('9f3434fe-fb43-4295-9737-30cf7c2ba11f'::uuid, '2021-03-19 13:00:00', 'Closed', 'Closed', 'closed with guardianship', '2021-03-19 13:00:00', 1, 'CDM-11081', now(), 'CDM-11081', now(), NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('SCDR', '7915cfc4-37e7-4542-9ee8-b44923981301', '5a159b1e-a7c5-46ca-95ea-4e4bc0d03743', 'b08a63b6-854b-442d-b12b-a0a55a482997'::uuid, 'CWSP', 'CWCW', 
	(select servicecasedispositionid from cjams.servicecasedisposition 
		where servicecaseid ='9f3434fe-fb43-4295-9737-30cf7c2ba11f'
		and updatedby ='CDM-11081' 
		order by insertedon desc limit 1 ), 
	16, 1, 'CDM-11081', now(), 'CDM-11081', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


--3302694
update servicecase 
set enddate='2021-02-22 13:00:00', statustypekey='Closed', updatedon=now(), updatedby='CDM-11081'
where servicecaseid ='ac5b28db-b334-46c0-8e9e-94c0ffc3378b';

INSERT INTO cjams.servicecasedisposition
(servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
VALUES('ac5b28db-b334-46c0-8e9e-94c0ffc3378b'::uuid, '2021-02-22 13:00:00', 'Closed', 'Closed', 'closed with guardianship', '2021-02-22 13:00:00', 1, 'CDM-11081', now(), 'CDM-11081', now(), NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('SCDR', '7915cfc4-37e7-4542-9ee8-b44923981301', '5a159b1e-a7c5-46ca-95ea-4e4bc0d03743', 'b08a63b6-854b-442d-b12b-a0a55a482997'::uuid, 'CWSP', 'CWCW', 
	(select servicecasedispositionid from cjams.servicecasedisposition 
		where servicecaseid ='ac5b28db-b334-46c0-8e9e-94c0ffc3378b'
		and updatedby ='CDM-11081' 
		order by insertedon desc limit 1 ), 
	16, 1, 'CDM-11081', now(), 'CDM-11081', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


--3296328
update servicecase 
set enddate='2020-11-17 13:00:00', statustypekey='Closed', updatedon=now(), updatedby='CDM-11081'
where servicecaseid ='e3ef5cc5-8473-4bae-9f04-3bdf6770a0bf';

INSERT INTO cjams.servicecasedisposition
(servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
VALUES('e3ef5cc5-8473-4bae-9f04-3bdf6770a0bf'::uuid, '2020-11-17 13:00:00', 'Closed', 'Closed', 'closed with guardianship', '2020-11-17 13:00:00', 1, 'CDM-11081', now(), 'CDM-11081', now(), NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('SCDR', '7915cfc4-37e7-4542-9ee8-b44923981301', '5a159b1e-a7c5-46ca-95ea-4e4bc0d03743', 'b08a63b6-854b-442d-b12b-a0a55a482997'::uuid, 'CWSP', 'CWCW', 
	(select servicecasedispositionid from cjams.servicecasedisposition 
		where servicecaseid ='e3ef5cc5-8473-4bae-9f04-3bdf6770a0bf'
		and updatedby ='CDM-11081' 
		order by insertedon desc limit 1 ), 
	16, 1, 'CDM-11081', now(), 'CDM-11081', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


--3302695
update servicecase 
set enddate='2021-01-10 13:00:00', statustypekey='Closed', updatedon=now(), updatedby='CDM-11081'
where servicecaseid ='473db1f9-0dc8-4e52-abad-b8e3a262a4d2';

INSERT INTO cjams.servicecasedisposition
(servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
VALUES('473db1f9-0dc8-4e52-abad-b8e3a262a4d2'::uuid, '2021-01-10 13:00:00', 'Closed', 'Closed', 'closed with guardianship', '2021-01-10 13:00:00', 1, 'CDM-11081', now(), 'CDM-11081', now(), NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('SCDR', '7915cfc4-37e7-4542-9ee8-b44923981301', '5a159b1e-a7c5-46ca-95ea-4e4bc0d03743', 'b08a63b6-854b-442d-b12b-a0a55a482997'::uuid, 'CWSP', 'CWCW', 
	(select servicecasedispositionid from cjams.servicecasedisposition 
		where servicecaseid ='473db1f9-0dc8-4e52-abad-b8e3a262a4d2'
		and updatedby ='CDM-11081' 
		order by insertedon desc limit 1 ), 
	16, 1, 'CDM-11081', now(), 'CDM-11081', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
