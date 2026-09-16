UPDATE servicecase SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2021-04-07 09:00:00', updatedby = 'CDM-12106',updatedon = now() WHERE servicecaseid = '0150385c-1418-4069-915d-b69d4a17e580';

INSERT INTO servicecasedisposition
( servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES( '5eab54b9-efb8-4fed-9152-a27fa60ddec0', '0150385c-1418-4069-915d-b69d4a17e580', '2021-04-07 09:00:00', 'Closed', 'Closed','family not responsive or accepting of services.', 
	   '2021-04-07 09:00:00', 1, 'CDM-12106',now(),'CDM-12106',now());

insert into routing (eventcode, fromsecurityusersid, tosecurityusersid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon,updatedby, updatedon)
values ('SCDR', '72ea08ae-678a-423d-ae3a-44921d219c5e', '72ea08ae-678a-423d-ae3a-44921d219c5e', 'CWSP', 'CWSP', '5eab54b9-efb8-4fed-9152-a27fa60ddec0', 16, 1, 'CDM-12106',now(),'CDM-12106', now());

