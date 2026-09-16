UPDATE servicecase SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2020-10-22 09:00:00', updatedby = 'CDM-9654',updatedon = now() WHERE servicecaseid = '73dcbb96-16eb-4e8a-9aac-0fbc8248a5d6';

INSERT INTO servicecasedisposition
( servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES('6438b90b-aa20-4989-b7a6-b290930680f9', '73dcbb96-16eb-4e8a-9aac-0fbc8248a5d6', '2021-02-05 17:00:00', 'Closed', 'Closed','Client refused services referred to CPS.', 
	   '2021-02-05 17:00:00', 1, '8aa46919-9467-474d-8699-db8b04db4005',now(),'CDM-9654',now());

insert into routing (eventcode, fromsecurityusersid, tosecurityusersid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon,updatedby, updatedon)
values ('SCDR', '72439d81-dfaa-46d0-a372-f90eb16f75fd', '72439d81-dfaa-46d0-a372-f90eb16f75fd', 'CWSP', 'CWSP', '6438b90b-aa20-4989-b7a6-b290930680f9', 16, 1, '8aa46919-9467-474d-8699-db8b04db4005',now(),'CDM-9654', now());
