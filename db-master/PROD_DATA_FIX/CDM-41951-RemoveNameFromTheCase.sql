/*
Issue Description: User requested to remove the Alleged Maltreator role from Client ID: 1518131 (NASHAWN R JONES) and add Unknown person card as Alleged Maltreator.
Category/Module: Bug
Root cause: 2 persons added to the IR case did not get automatic program assignments
Fix provided: DB queries to insert program assignments for the 2 persons
Data/Code fix ticket#: CDM-42058
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR

Backup before update/ delete:Query:
delete from person where insertedby = 'CDM-41951';
delete from actor where personid = (select personid from person where insertedby = 'CDM-41951');
*/

--Inserting unknown person into person
insert into person
	(personid, activeflag, firstname, lastname, insertedby, insertedon, updatedby, updatedon, effectivedate, dob, gendertypekey, refusessn,
	refusedob, dangertoself, isdraft)
values (gen_random_uuid(), 1, 'Unknown', 'Unknown', 'CDM-41951', now(), 'CDM-41951', now(), now(), '1900-01-01 00:00:00', 'F', false,
	false, 0, 0);
	
--Inserting above person into actor for this case
insert into actor
	(actorid, activeflag, personid, actortype, insertedby, insertedon, updatedby, updatedon, manualupdateflag, intakeserviceid,
	iscollateralcontact, ishouseholdmember, intakenumber)
values (gen_random_uuid(), 1, (select personid from person where insertedby = 'CDM-41951'), 'RA', 'CDM-41951', now(), 'CDM-41951', now(), 0,
	'daa7008d-18b1-4dc5-aa85-85517f6e2376', 0, 1, 'CW2677944');

--Changing actorid for AM on this case in intakeservicerequestactor
update intakeservicerequestactor
set actorid = (select actorid from actor where personid = (select personid from person where insertedby = 'CDM-41951')),
	personid = (select personid from person where insertedby = 'CDM-41951'),
	updatedby = 'CDM-41951', updatedon = now()
where intakeservicerequestactorid = 'c608d251-661c-419a-a05e-284205fc2fa9' and activeflag = 1;