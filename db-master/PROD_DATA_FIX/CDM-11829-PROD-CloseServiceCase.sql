update servicecase 
set enddate='2021-03-24 21:06:15', statustypekey='Closed', updatedon=now(), updatedby='CDM-11829'
where servicecaseid ='eab6c876-7123-40c4-ad9c-d94594d9a441';

INSERT INTO cjams.servicecasedisposition
(servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
VALUES('eab6c876-7123-40c4-ad9c-d94594d9a441'::uuid, '2021-03-24 21:06:15', 'Closed', 'Closed', 'Casehead has a no contact order against him and there are no children in his care.', '2021-03-24 21:06:15', 1, 'CDM-11829', now(), 'CDM-11829', now(), NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('SCDR', '72ea08ae-678a-423d-ae3a-44921d219c5e', '72ea08ae-678a-423d-ae3a-44921d219c5e', '8d32f1f6-5401-4c69-bc40-1688e3a830cd'::uuid, 'CWSP', 'CWSP', 
	(select servicecasedispositionid from cjams.servicecasedisposition 
		where servicecaseid ='eab6c876-7123-40c4-ad9c-d94594d9a441'
		and updatedby ='CDM-11829' 
		order by insertedon desc limit 1 ), 
	16, 1, 'CDM-11829', now(), 'CDM-11829', now(), true, 'Disposition Approved', NULL, 'Disposition Approved', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
