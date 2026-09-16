-- CDM-9655 - close case 

UPDATE servicecase SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = now() , updatedby = 'CDM-9655',updatedon = now() WHERE servicecaseid = 'dc0c1ffe-72cd-4dc5-8bc8-4b4b10a4ade6';

INSERT INTO servicecasedisposition
( servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES('73a42c95-1be6-4c77-8006-32b5ca479cf9' ,'dc0c1ffe-72cd-4dc5-8bc8-4b4b10a4ade6', now(), 'Closed', 'Closed',null, 
	   now() , 1, 'CDM-9655',now(),'CDM-9655',now());

insert into routing (eventcode, fromsecurityusersid, tosecurityusersid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon,updatedby, updatedon)
values ('SCDR', '3a2b0a95-7960-453b-909a-4315b9152902', '34a74883-21a3-4d1b-be07-48fd2c870382', 'CWSP', 'CWSP', '73a42c95-1be6-4c77-8006-32b5ca479cf9', 16, 1, 'CDM-9655',now(),'CDM-9655', now());
