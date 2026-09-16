UPDATE servicecase SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2021-03-12 11:00:00', updatedby = 'CDM-11241',updatedon = now() WHERE servicecaseid = '62d3a5da-eceb-4f4e-9510-2852480bcd1e';

INSERT INTO servicecasedisposition
( servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES('6bde922d-4821-4f27-9039-abecdf319b49','62d3a5da-eceb-4f4e-9510-2852480bcd1e', '2021-03-12 11:00:00', 'Closed', 'Closed','Case Closure requested by Case Worker Rebecca Skinner and closure was approved by Christine Abbatiello.', 
	   '2021-03-12 11:00:00', 1, 'ebe4bdd6-145c-4e45-bacb-f9187d0d0971','2021-03-12 11:00:00','CDM-11241',now());

insert into routing (eventcode, fromsecurityusersid, tosecurityusersid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon,updatedby, updatedon)
values ('SCDR', '519e895e-17f5-410d-b0a5-ec588a03c362', '519e895e-17f5-410d-b0a5-ec588a03c362', 'CWSP', 'CWSP', '6bde922d-4821-4f27-9039-abecdf319b49', 16, 1, 'ebe4bdd6-145c-4e45-bacb-f9187d0d0971','2021-03-12 11:00:00','CDM-11241', now());


UPDATE servicecase SET activeflag = 0, updatedby = 'CDM-11241',updatedon = now() WHERE servicecaseid = '635f1c0b-d0f8-48e8-890e-852f5f573e95';