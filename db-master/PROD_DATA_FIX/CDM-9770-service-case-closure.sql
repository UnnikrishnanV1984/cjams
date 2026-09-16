UPDATE servicecase SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2020-10-22 09:00:00', updatedby = 'CDM-9770',updatedon = now() WHERE servicecaseid = '7ae9ae0a-f49d-41ad-956b-4d62926be081';

INSERT INTO servicecasedisposition
( servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES( 'd508c6e5-ad5d-4725-9ed1-516777a99fe4','7ae9ae0a-f49d-41ad-956b-4d62926be081', '2020-10-22 09:00:00', 'Closed', 'Closed','This case has been closed through ICPC, however we have been unable to close in CJAMS as it has been requiring a MFRA or MFIRA, which is not needed.', 
	   '2020-10-22 09:00:00', 1, 'CDM-9770',now(),'CDM-9770',now());

insert into routing (eventcode, fromsecurityusersid, tosecurityusersid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon,updatedby, updatedon)
values ('SCDR', '144b922e-bc2c-4b1a-8048-d479256caa15', '144b922e-bc2c-4b1a-8048-d479256caa15', 'CWSP', 'CWSP', 'd508c6e5-ad5d-4725-9ed1-516777a99fe4', 16, 1, 'CDM-9770',now(),'CDM-9770', now());
