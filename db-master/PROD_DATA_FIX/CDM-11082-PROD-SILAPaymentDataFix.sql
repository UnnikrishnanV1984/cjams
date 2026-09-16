--CASE ID: 3215971, CJAMS PID: 1152916 (Dennis O Herrera)
update servicecase 
set enddate = null, 
	statustypekey = 'pending', 
	dispositioncode = 'open', 
	updatedon = now(), 
	updatedby = 'CDM-11082'
where servicecaseid = '1a4f5f06-5c10-4417-9f6e-1fcf09b4ee67';

insert into cjams.servicecasedisposition
(	servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, 
	dispositioncode, "comments", effectivedate, activeflag, 
	insertedby, insertedon, updatedby, updatedon, expirationdate, 
	old_id, etl_userid, etl_load_date
)
values
(	gen_random_uuid(), '1a4f5f06-5c10-4417-9f6e-1fcf09b4ee67', now(), 'Reopen', 
	'Inprogress', 'Reopening a Closed Case for SILA payment to Youth', now(), 1, 
	'CDM-11082', now(), 'CDM-11082', now(), NULL, 
	'3215971', null, null
);

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('SCDR', 'cca91e91-1886-46c2-bcc6-76eb9dcfd3f2', 'b3503705-5dab-4f41-b564-15e933c7b902', '95c02657-cd0c-436a-b09c-d47ab0da4006'::uuid, 'CWSP', 'CWSP', 
	(select servicecasedispositionid from cjams.servicecasedisposition 
		where servicecaseid ='1a4f5f06-5c10-4417-9f6e-1fcf09b4ee67'
		and updatedby ='CDM-11082' 
		order by insertedon desc limit 1 ), 
	16, 1, 'CDM-11082', now(), 'CDM-11082', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.caseassignment
(eventidno_fk, eventdttmkey_fk, fromworkeridno, fromsupervisoridno, fromofficecode, toworkeridno, tosupervisoridno, toofficecode, caseassigncode, effectivedate, effectivetime, frombizunitidno, tobizunitidno, old_id, foldergroupindc, cmfldrgrpasgnkey, insertedby, updatedby, insertedon, updatedon, objecttypekey, objectid, responsibilitytypekey, activeflag, startdate, enddate, fromteamid, toteamid, remarks, statustypekey, fromldssid, toldssid, assignmenttype, fk_id, assigndate, isrestricted, assigndescription, summary, isnew, expungementflag, entityopendate, etl_userid, etl_load_date)
VALUES('205d3bdd-844f-45f1-a4fa-f6e186a52c08'::uuid, NULL, 'b3503705-5dab-4f41-b564-15e933c7b902', NULL, NULL, 'b08160e9-2f90-474b-9513-3edf28814abd', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'b3503705-5dab-4f41-b564-15e933c7b902', 'CDM-11082', now(), now(), 'servicecase', '1a4f5f06-5c10-4417-9f6e-1fcf09b4ee67'::uuid, 'family', 1, now(), NULL, '95c02657-cd0c-436a-b09c-d47ab0da4006'::uuid, '95c02657-cd0c-436a-b09c-d47ab0da4006'::uuid, '<p>Reopening a Closed Case for SILA payment to Youth.</p>', 'ASSGN', 'c81be790-a79d-40ac-a38d-abd4dd5a81f6'::uuid, 'c81be790-a79d-40ac-a38d-abd4dd5a81f6'::uuid, 'W', NULL, now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

--CASE ID: 3237411, CJAMS PID: 3612355 (Jeonna Desire Johnson)
update servicecase 
set enddate = null, 
	statustypekey = 'pending', 
	dispositioncode = 'open', 
	updatedon = now(), 
	updatedby = 'CDM-11082'
where servicecaseid = '2640c903-b19a-4536-a962-c8e2be2d4f2e';

insert into cjams.servicecasedisposition
(	servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, 
	dispositioncode, "comments", effectivedate, activeflag, 
	insertedby, insertedon, updatedby, updatedon, expirationdate, 
	old_id, etl_userid, etl_load_date
)
values
(	gen_random_uuid(), '2640c903-b19a-4536-a962-c8e2be2d4f2e', now(), 'Reopen', 
	'Inprogress', 'Reopening a Closed Case for SILA payment to Youth', now(), 1, 
	'CDM-11082', now(), 'CDM-11082', now(), NULL, 
	'3215971', null, null
);

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('SCDR', 'cca91e91-1886-46c2-bcc6-76eb9dcfd3f2', 'b3503705-5dab-4f41-b564-15e933c7b902', '95c02657-cd0c-436a-b09c-d47ab0da4006'::uuid, 'CWSP', 'CWSP', 
	(select servicecasedispositionid from cjams.servicecasedisposition 
		where servicecaseid ='2640c903-b19a-4536-a962-c8e2be2d4f2e'
		and updatedby ='CDM-11082' 
		order by insertedon desc limit 1 ), 
	16, 1, 'CDM-11082', now(), 'CDM-11082', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.caseassignment
(eventidno_fk, eventdttmkey_fk, fromworkeridno, fromsupervisoridno, fromofficecode, toworkeridno, tosupervisoridno, toofficecode, caseassigncode, effectivedate, effectivetime, frombizunitidno, tobizunitidno, old_id, foldergroupindc, cmfldrgrpasgnkey, insertedby, updatedby, insertedon, updatedon, objecttypekey, objectid, responsibilitytypekey, activeflag, startdate, enddate, fromteamid, toteamid, remarks, statustypekey, fromldssid, toldssid, assignmenttype, fk_id, assigndate, isrestricted, assigndescription, summary, isnew, expungementflag, entityopendate, etl_userid, etl_load_date)
VALUES('2640c903-b19a-4536-a962-c8e2be2d4f2e'::uuid, NULL, '337f4170-0f0c-4675-9430-accd7771590e', '6008485', NULL, 'f11134c0-9bba-4240-9dd4-09da77cfc882', '6026248', NULL, NULL, NULL, NULL, NULL, NULL, '3237411', NULL, NULL, '337f4170-0f0c-4675-9430-accd7771590e', 'b3503705-5dab-4f41-b564-15e933c7b902', now(), now(), 'servicecase', '2640c903-b19a-4536-a962-c8e2be2d4f2e'::uuid, 'family', 1, now(), NULL, '6123c7a6-29a7-4252-ac6b-2018bf5a0bf8'::uuid, '95c02657-cd0c-436a-b09c-d47ab0da4006'::uuid, '<p>Reopening a Closed Case for SILA payment to Youth.</p>', 'ASSGN', 'c81be790-a79d-40ac-a38d-abd4dd5a81f6'::uuid, 'c81be790-a79d-40ac-a38d-abd4dd5a81f6'::uuid, 'W', '5738236', now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
