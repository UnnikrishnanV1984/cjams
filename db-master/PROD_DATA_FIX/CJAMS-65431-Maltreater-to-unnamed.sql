/*
Issue Description: User requested to remove the Alleged Maltreator role from Client ID: 204227746 (Yoseph Kidane) and
    add Unnamed Unnamed person card with role as Alleged Maltreator into the CPS IR # 251023169247.
Category/Module: Bug
Root cause: User requested update Maltreator to unknown person
Fix provided: DB queries to insert unknown person and change Maltreator 
Data/Code fix ticket#: CJAMS-65431
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
values (gen_random_uuid(), 1, 'Unknown', 'Unknown', 'CJAMS-65431', now(), 'CJAMS-65431', now(), now(), '1900-01-01 00:00:00', 'F', false,
	false, 0, 0);
	
--Inserting above person into actor for this case
insert into actor
	(actorid, activeflag, personid, actortype, insertedby, insertedon, updatedby, updatedon, manualupdateflag, intakeserviceid,
	iscollateralcontact, ishouseholdmember, intakenumber)
values (gen_random_uuid(), 1, (select personid from person where insertedby = 'CJAMS-65431' and activeflag = 1), 'RA', 'CJAMS-65431', now(), 'CJAMS-65431', now(), 0,
	'db956a6a-b026-429a-98ec-3c136f1412d8', 0, 1, 'I251013405150');


--Changing actorid for AM on this case in intakeservicerequestactor
update intakeservicerequestactor
set actorid = (select actorid from actor where insertedby = 'CJAMS-65431' and activeflag = 1),
	personid = (select personid from person where insertedby = 'CJAMS-65431' and activeflag = 1),
	updatedby = 'CJAMS-65431', updatedon = now()
where intakeservicerequestactorid = 'cd3b232a-a480-421b-9838-7f75b446cc04' and activeflag = 1;