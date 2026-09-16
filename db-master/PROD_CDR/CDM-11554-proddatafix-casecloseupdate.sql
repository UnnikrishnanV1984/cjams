update servicecase 
set enddate='2021-03-19 00:00:00', statustypekey='Closed', updatedon=now(), updatedby='CDM-11554'
where servicecaseid ='d89d1031-17b0-4d3e-b5ec-4431d44d44be';


INSERT INTO cjams.servicecasedisposition
(servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES('d89d1031-17b0-4d3e-b5ec-4431d44d44be'::uuid, '2021-03-19 00:00:00', 'Closed', 'Closed', 'Case closed', '2021-03-19 00:00:00', 1, '1cedd29a-9211-4376-be7c-1e604ad7b944', now(), 'CDM-11554', now());


INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest)
VALUES('SCDR', 'c4e33509-8fd7-40d4-918b-c97764e8f473',
	(select servicecasedispositionid from cjams.servicecasedisposition 
		where servicecaseid ='d89d1031-17b0-4d3e-b5ec-4431d44d44be' 
		order by insertedon desc limit 1 ), 
	16, 1, 'CDM-11554', now(), 'CDM-11554', now(), true);
	
update caseassignment 
set enddate = '2021-03-19 00:00:00',
updatedon = now(),
updatedby = 'CDM-11554'
where caseassignmentid = 'f0749a9f-823a-4d35-b739-f59489b4a997';