UPDATE servicecase 
	SET statustypekey = 'Open', 
		dispositioncode = 'Open', 
		enddate = null, 
		updatedby = 'CDM-16119',
		updatedon = now() 
	WHERE servicecaseid = '88b53061-a51b-4d0a-a0a3-6ca6459f8291';

INSERT INTO servicecasedisposition
( servicecasedispositionid , servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES('50a35c92-6977-43f3-8a52-362c5d32b59b', '88b53061-a51b-4d0a-a0a3-6ca6459f8291', '2021-09-23 09:00:00', 'Open', 'Inprogress','To Pay a Bill', 
	   '2021-09-23 09:00:00', 1, 'CDM-16119',now(),'CDM-16119',now());

insert into routing (eventcode, fromsecurityusersid, tosecurityusersid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon,updatedby, updatedon)
values ('SCDR', '11c49ec3-6a5b-4b09-a78a-ccaab244de50', '11c49ec3-6a5b-4b09-a78a-ccaab244de50', 'CWSP', 'CWSP', '50a35c92-6977-43f3-8a52-362c5d32b59b', 16, 1, 'CDM-16119',now(),'CDM-16119', now());
