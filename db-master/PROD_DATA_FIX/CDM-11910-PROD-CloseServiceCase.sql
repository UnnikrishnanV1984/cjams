--2020034904754
update servicecase 
set enddate='2021-01-12 17:00:00', statustypekey='Closed', updatedon=now(), updatedby='CDM-11910'
where servicecaseid ='432cd345-497e-40dc-899a-9d0aea4c3b50';

INSERT INTO cjams.servicecasedisposition
(servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
VALUES('432cd345-497e-40dc-899a-9d0aea4c3b50'::uuid, '2021-01-12 17:00:00', 'Closed', 'Closed', 'Families refusing in home services.', '2021-01-12 17:00:00', 1, 'CDM-11910', now(), 'CDM-11910', now(), NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('SCDR', '72ea08ae-678a-423d-ae3a-44921d219c5e', '72ea08ae-678a-423d-ae3a-44921d219c5e', '8d32f1f6-5401-4c69-bc40-1688e3a830cd'::uuid, 'CWSP', 'CWSP', 
	(select servicecasedispositionid from cjams.servicecasedisposition 
		where servicecaseid ='432cd345-497e-40dc-899a-9d0aea4c3b50'
		and updatedby ='CDM-11910' 
		order by insertedon desc limit 1 ), 
	16, 1, 'CDM-11910', now(), 'CDM-11910', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


--202101305364
update servicecase 
set enddate='2021-02-23 17:00:00', statustypekey='Closed', updatedon=now(), updatedby='CDM-11910'
where servicecaseid ='4d9232db-ff5a-4555-9ae6-b1594bd86302';

INSERT INTO cjams.servicecasedisposition
(servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
VALUES('4d9232db-ff5a-4555-9ae6-b1594bd86302'::uuid, '2021-02-23 17:00:00', 'Closed', 'Closed', 'Families refusing in home services.', '2021-02-23 17:00:00', 1, 'CDM-11910', now(), 'CDM-11910', now(), NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('SCDR', '72ea08ae-678a-423d-ae3a-44921d219c5e', '72ea08ae-678a-423d-ae3a-44921d219c5e', '8d32f1f6-5401-4c69-bc40-1688e3a830cd'::uuid, 'CWSP', 'CWSP', 
	(select servicecasedispositionid from cjams.servicecasedisposition 
		where servicecaseid ='4d9232db-ff5a-4555-9ae6-b1594bd86302'
		and updatedby ='CDM-11910' 
		order by insertedon desc limit 1 ), 
	16, 1, 'CDM-11910', now(), 'CDM-11910', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
