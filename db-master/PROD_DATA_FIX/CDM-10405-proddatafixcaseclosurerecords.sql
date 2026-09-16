
update servicecase 
set enddate='2021-04-07 12:00:00', statustypekey='Closed', updatedon=now(), updatedby='CDM-10405'
where servicecaseid ='bdb7bbb2-4d88-45dc-b103-6e1a451f6148';


INSERT INTO cjams.servicecasedisposition
(servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES('bdb7bbb2-4d88-45dc-b103-6e1a451f6148'::uuid, '2021-04-07 12:00:00', 'Closed', 'Closed', ''
, '2021-04-07 12:00:00', 1, 'c40317e6-1c42-4a73-a5db-e1fc4ab376cd', now(), 'CDM-10405', now());


INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest)
VALUES('SCDR', '2bc44bbe-5920-49a3-9e05-ef79c400bf9e',
	(select servicecasedispositionid from cjams.servicecasedisposition 
		where servicecaseid ='bdb7bbb2-4d88-45dc-b103-6e1a451f6148' 
		order by insertedon desc limit 1 ), 
	16, 1, 'CDM-10405', now(), 'CDM-10405', now(), true);

    update personprogramarea set entityid = '20200329057121',updatedon = now(),objecttypekey = 'servicerequest' where personprogramid = '09d473e5-9de2-4141-8514-32e48368d550';
