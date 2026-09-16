UPDATE servicecase SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2021-1-11 09:00:00' , updatedby = 'CDM-9655',updatedon = now() WHERE servicecaseid = 'dc0c1ffe-72cd-4dc5-8bc8-4b4b10a4ade6';

INSERT INTO servicecasedisposition
( servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES('73a42c95-1be6-4c77-8006-32b5ca479cf9' ,'dc0c1ffe-72cd-4dc5-8bc8-4b4b10a4ade6', '2021-1-11 09:00:00', 'Closed', 'Closed','This case has been closed through ICPC, however we have been unable to close in CJAMS as it has been requiring a MFRA or MFIRA, which is not needed.', 
	   '2021-1-11 09:00:00' , 1, 'CDM-9655',now(),'CDM-9655',now());

insert into routing (eventcode, fromsecurityusersid, tosecurityusersid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon,updatedby, updatedon)
values ('SCDR', '72ea08ae-678a-423d-ae3a-44921d219c5e', '72ea08ae-678a-423d-ae3a-44921d219c5e', 'CWSP', 'CWSP', '73a42c95-1be6-4c77-8006-32b5ca479cf9', 16, 1, 'CDM-9655',now(),'CDM-9655', now());