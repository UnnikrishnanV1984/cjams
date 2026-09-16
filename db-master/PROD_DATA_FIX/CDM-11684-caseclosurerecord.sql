update servicecase 
set enddate='2021-04-07 00:00:00', statustypekey='Closed', updatedon=now(), updatedby='CDM-11684'
where servicecaseid ='d22ec8f4-0ecc-4e00-8c9a-67e62d065ae1';


INSERT INTO cjams.servicecasedisposition
(servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES('d22ec8f4-0ecc-4e00-8c9a-67e62d065ae1'::uuid, '2021-04-07 00:00:00', 'Closed', 'Closed', 'Case closed', '2021-04-07 00:00:00', 1, '579b95be-ad0c-491c-ba30-4681f46af6c1', now(), 'CDM-11684', now());


INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest)
VALUES('SCDR', '0df3e7ac-4476-4dde-bf04-af2c7063d102',
	(select servicecasedispositionid from cjams.servicecasedisposition 
		where servicecaseid ='d22ec8f4-0ecc-4e00-8c9a-67e62d065ae1' 
		order by insertedon desc limit 1 ), 
	16, 1, 'CDM-11684', now(), 'CDM-11684', now(), true);