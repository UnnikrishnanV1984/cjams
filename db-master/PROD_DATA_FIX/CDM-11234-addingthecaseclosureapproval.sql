INSERT INTO cjams.servicecasedisposition
(servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES('e32518a3-5206-4393-8c2e-59d6d446959b'::uuid, '2021-03-13 12:51:52', 'Closed', 'Closed', 'Case opened in error', '2021-03-13 12:51:52', 1, 'CDM-11234', now(), 'CDM-11234', now());


INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest)
VALUES('SCDR', 'e4b5f055-b967-4b2b-9f44-04d76dbcc2d7',
	(select servicecasedispositionid from cjams.servicecasedisposition 
		where servicecaseid ='e32518a3-5206-4393-8c2e-59d6d446959b'
		and updatedby ='CDM-11234' 
		order by insertedon desc limit 1 ), 
	16, 1, 'CDM-11234', now(), 'CDM-11234', now(), true);