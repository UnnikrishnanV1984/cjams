

UPDATE servicecase SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2021-05-17 12:01:00', updatedby = 'CDM-13229',updatedon = now() WHERE servicecaseid = 'd284c262-1376-44c1-8438-15b401858e6d';

INSERT INTO servicecasedisposition
( servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES( '940a068e-6ed5-4e72-ba43-27a86d80d322', 'd284c262-1376-44c1-8438-15b401858e6d', '2021-05-17 12:01:00', 'Closed', 'Closed','Service Case created in error.', 
	   '2021-05-17 12:01:00', 1, 'CDM-13229',now(),'CDM-13229',now());
	  	  
update caseassignment 
set enddate = '2021-05-17 12:01:00',
updatedon = now(),
updatedby = 'CDM-12486'
where caseassignmentid = '1e95774c-3fbd-4c7d-8a47-629279b2adb7';

insert into routing (eventcode, fromsecurityusersid, tosecurityusersid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon,updatedby, updatedon)
values ('SCDR', 'ef648b5c-8d50-4a75-a3ea-1e0b91823847', '36d2f073-58c2-464c-83db-8d77b3ff14a8', 'CWSP', 'CWCW', '940a068e-6ed5-4e72-ba43-27a86d80d322', 16, 1, 'CDM-13229',now(),'CDM-13229', now());

update cjams.personprogramarea set enddate ='2021-05-17 12:01:00' where objectid ='d284c262-1376-44c1-8438-15b401858e6d';
