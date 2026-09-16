UPDATE servicecase SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2020-09-30T16:52:55', updatedby = 'CDM-9153',updatedon = now() WHERE servicecaseid = '5a9f18a4-185e-4ec7-8b57-16e52b12b431';

INSERT INTO servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES('6320af89-19c7-4182-a0a0-e909caaef17a','5a9f18a4-185e-4ec7-8b57-16e52b12b431', '2020-09-30T16:52:55', 'Closed', 'Closed', '2020-09-30T16:52:55', 1, 'CDM-9153',now(),'CDM-9153',now());

insert into routing (eventcode, fromsecurityusersid, tosecurityusersid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon,updatedby, updatedon)
values ('SCDR', 'f2599061-b9c9-455f-a9c8-c7bc31e9ef22', 'f2599061-b9c9-455f-a9c8-c7bc31e9ef22', 'CWSP', 'CWSP', '6320af89-19c7-4182-a0a0-e909caaef17a', 16, 1, 'CDM-9153',now(),'CDM-9153', now());
