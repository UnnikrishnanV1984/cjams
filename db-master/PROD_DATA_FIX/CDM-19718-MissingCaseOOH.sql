/*
   Issue Description: CDM-19718
   Category/ Module  : Child Removal OOH is missing 
   Root cause: user wants person removal and placement OOH
   Pull request# for code fix: 4648
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
update cjams.actor 
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-19718'
where actorid = '0441bf2a-297f-45e5-84a2-a8814ec2797f';

update cjams.intakeservicerequestactor
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-19718'
where intakeservicerequestactorid = 'bddf430a-d650-4a05-a3ae-d33bb5a8caf3';

update cjams.personrole p  
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-19718'
where personroleid = 'f5b85a7c-e6f4-4e2c-b492-01249b77fb40';

update cjams.actorrelationship a2 
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-19718'
where intakeservicerequestactorid = 'bddf430a-d650-4a05-a3ae-d33bb5a8caf3';


INSERT INTO personprogramarea (
personid, programkey, subprogramkey, objecttypekey, objectid, 
startdate, insertedby, insertedon, updatedby, updatedon, 
entityid, activeflag, sourcetype
) values(
'5287a8ff-8c39-4a57-98f4-4ad8461e2548', 'OOH', null, 'servicecase', 'a4422714-4ec0-4d00-9017-e55f9a5fee6a', 
'2021-11-22 00:00:00', 'CDM-19718', now(), 'CDM-19718', now(), 
'3296159', 1, 'CW'
);