UPDATE servicecase SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = now(), updatedby = 'CDM-8095',updatedon = now() WHERE servicecaseid = 'b297ccb3-2229-4f41-ae5d-70f3cf9880dd';

INSERT INTO servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES( '11100296-5376-4ea8-a735-0f1eeecec3a2','b297ccb3-2229-4f41-ae5d-70f3cf9880dd', now(), 'Closed', 'Closed','Case should be closed as of 12/15/20. Service case was opened to pay a bill for a CPS case.', 
	   now(), 1, 'CDM-8095',now(),'CDM-8095',now());

insert into routing (eventcode, fromsecurityusersid, tosecurityusersid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon,updatedby, updatedon)
values ('SCDR', '2bc44bbe-5920-49a3-9e05-ef79c400bf9e', '2bc44bbe-5920-49a3-9e05-ef79c400bf9e', 'CWSP', 'CWSP', '11100296-5376-4ea8-a735-0f1eeecec3a2', 16, 1, 'CDM-8095',now(),'CDM-8095', now());
