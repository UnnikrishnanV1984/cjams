UPDATE servicecase SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2021-01-20 16:00:00', updatedby = 'CDM-12486',updatedon = now() WHERE servicecaseid = '36168bf5-c227-4bde-9210-d72e27dc55f2';

INSERT INTO servicecasedisposition
( servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES( 'f10e1b31-a14c-46fc-93e1-79a05d02d427', '36168bf5-c227-4bde-9210-d72e27dc55f2', '2021-01-20 16:00:00', 'Closed', 'Closed','Senae Jackson requested closure.', 
	   '2021-01-20 16:00:00', 1, 'CDM-12486',now(),'CDM-12486',now());

insert into routing (eventcode, fromsecurityusersid, tosecurityusersid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon,updatedby, updatedon)
values ('SCDR', '44ae52aa-6389-425a-a422-2a8bf24c3aae', '44ae52aa-6389-425a-a422-2a8bf24c3aae', 'CWSP', 'CWSP', 'f10e1b31-a14c-46fc-93e1-79a05d02d427', 16, 1, 'CDM-12486',now(),'CDM-12486', now());

update caseassignment 
set enddate = '2021-01-20 16:00:00',
updatedon = now(),
updatedby = 'CDM-12486'
where caseassignmentid = '887fe8ef-8939-428f-9370-fc265e27e92a';