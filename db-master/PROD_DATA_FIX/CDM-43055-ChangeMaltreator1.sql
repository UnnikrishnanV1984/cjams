/*
Issue Description: User requested remove the Alleged Maltreator role from Client ID: 1030793 (MELISSA JOLYNN LEGER) and add Unknown person card as Alleged Maltreator.
Category/Module: Bug
Root cause: User requested update Maltreator to unknown person
Fix provided: DB queries to insert unknown person and change Maltreator 
Data/Code fix ticket#: CDM-43055
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR

*/

--Inserting unknown person into person
insert into person
	(personid, activeflag, firstname, lastname, insertedby, insertedon, updatedby, updatedon, effectivedate, dob, gendertypekey, refusessn,
	refusedob, dangertoself, isdraft)
values (gen_random_uuid(), 1, 'Unknown', 'Unknown', 'CDM-43055', now(), 'CDM-43055', now(), now(), '1900-01-01 00:00:00', 'F', false,
	false, 0, 0);
	
--Inserting above person into actor for this case
insert into actor
	(actorid, activeflag, personid, actortype, insertedby, insertedon, updatedby, updatedon, manualupdateflag, intakeserviceid,
	iscollateralcontact, ishouseholdmember, intakenumber)
values (gen_random_uuid(), 1, (select personid from person where insertedby = 'CDM-43055'), 'RA', 'CDM-43055', now(), 'CDM-43055', now(), 0,
	'f1ec3b03-7a7f-430c-8c43-1e9e96ccead2', 0, 1, 'CW9509887');

--Changing actorid for AM on this case in intakeservicerequestactor
update intakeservicerequestactor
set actorid = (select actorid from actor where personid = (select personid from person where insertedby = 'CDM-43055')),
	personid = (select personid from person where insertedby = 'CDM-43055'),
	updatedby = 'CDM-43055', updatedon = now()
where intakeservicerequestactorid = '5d2b0ee6-0dd6-4bd6-b1ad-82ef74078833' and activeflag = 1;