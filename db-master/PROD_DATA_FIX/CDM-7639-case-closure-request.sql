--- case# 3277547
UPDATE servicecase SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = now(), updatedby = 'CDM-7639',updatedon = now() WHERE servicecaseid = '2e7f0078-703a-40c4-b7ba-89b1686711f3';

INSERT INTO servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES('535712ae-0276-4a49-bdab-ea2b40caa779', '2e7f0078-703a-40c4-b7ba-89b1686711f3', now(), 'Closed', 'Closed','This case has been closed through ICPC, however we have been unable to close in CJAMS as it has been requiring a MFRA or MFIRA, which is not needed.', 
	   now(), 1, 'CDM-7639',now(),'CDM-7639',now());

insert into routing (eventcode, fromsecurityusersid, tosecurityusersid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon,updatedby, updatedon)
values ('SCDR', '9a1c8c5c-cc81-4c3f-8c25-65089b46afca', '9a1c8c5c-cc81-4c3f-8c25-65089b46afca', 'CWSP', 'CWSP', '535712ae-0276-4a49-bdab-ea2b40caa779', 16, 1, 'CDM-7639',now(),'CDM-7639', now());

--- case# 3300533

UPDATE servicecase SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = now(), updatedby = 'CDM-7639',updatedon = now() WHERE servicecaseid = '66c3ed0c-5fd4-4628-8680-06d3118db828';

INSERT INTO servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES('6d576121-3eca-4375-a3c6-47b66851a8e3','66c3ed0c-5fd4-4628-8680-06d3118db828', now(), 'Closed', 'Closed','This case has been closed through ICPC, however we have been unable to close in CJAMS as it has been requiring a MFRA or MFIRA, which is not needed.', 
	   now(), 1, 'CDM-7639',now(),'CDM-7639',now());
	   
insert into routing (eventcode, fromsecurityusersid, tosecurityusersid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon,updatedby, updatedon)
values ('SCDR', '9a1c8c5c-cc81-4c3f-8c25-65089b46afca', '9a1c8c5c-cc81-4c3f-8c25-65089b46afca', 'CWSP', 'CWSP', '6d576121-3eca-4375-a3c6-47b66851a8e3', 16, 1, 'CDM-7639',now(),'CDM-7639', now());
