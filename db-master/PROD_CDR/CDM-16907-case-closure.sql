UPDATE servicecase SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2021-08-17 16:30:00', updatedby = 'CDM-16907',updatedon = now() WHERE servicecaseid = 'b49a006f-e1fe-4b81-a07e-4c46f35afff1';

INSERT INTO servicecasedisposition
(  servicecasedispositionid , servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES( '6f3d6ad2-a9c1-4294-b630-088b4a7da564', 'b49a006f-e1fe-4b81-a07e-4c46f35afff1', '2021-08-17 16:30:00', 'Closed', 'Closed','Foster Care case closed on 8/17/21 by court order. Successful reunification to birth parents.', 
	   '2021-08-17 16:30:00', 1, 'CDM-16907',now(),'CDM-16907',now()) returning servicecasedispositionid;

insert into routing (eventcode, fromsecurityusersid, tosecurityusersid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon,updatedby, updatedon)
values ('SCDR', 'd7e29f2c-c055-4000-ad21-fd5ba783525c', 'd7e29f2c-c055-4000-ad21-fd5ba783525c', 'CWSP', 'CWSP', '6f3d6ad2-a9c1-4294-b630-088b4a7da564', 16, 1, 'CDM-16907',now(),'CDM-16907', now());

update caseassignment 
set enddate = '2021-08-17 16:30:00',
updatedon = now(),
updatedby = 'CDM-16907'
where caseassignmentid in ('39cf2575-cab2-4d35-8e46-3652c0d1b842', '254f069d-be97-4232-a92f-fe8b9eeda142');
