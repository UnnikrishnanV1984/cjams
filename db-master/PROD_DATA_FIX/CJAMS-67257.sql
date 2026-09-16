/*
Issue Description: User request to remove the Alleged Maltreator role from Client ID: 204863345 and 
      add Unnamed Unnamed person card with role as Alleged Maltreator into the CPS IR # 251023366979.
Category/Module: Bug
Root cause: User requested update Maltreator to unknown person
Fix provided: DB queries to insert unknown person and change Maltreator 
Data/Code fix ticket#: CJAMS-67257
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
values (gen_random_uuid(), 1, 'Unknown', 'Unknown', 'CJAMS-67257', now(), 'CJAMS-67257', now(), now(), '1900-01-01 00:00:00', 'F', false,
	false, 0, 0);
	
--Inserting above person into actor for this case
insert into actor
	(actorid, activeflag, personid, actortype, insertedby, insertedon, updatedby, updatedon, manualupdateflag, intakeserviceid,
	iscollateralcontact, ishouseholdmember, intakenumber)
values (gen_random_uuid(), 1, (select personid from person where insertedby = 'CJAMS-67257' and activeflag = 1), 'AM', 'CJAMS-67257', now(), 'CJAMS-67257', now(), 0,
	'8db285f8-2819-4682-af5e-b33df6ac0096', 0, 1, 'I251013615960');


--Changing actorid for AM on this case in intakeservicerequestactor
update intakeservicerequestactor
set actorid = (select actorid from actor where insertedby = 'CJAMS-67257' and activeflag = 1),
	personid = (select personid from person where insertedby = 'CJAMS-67257' and activeflag = 1),
	updatedby = 'CJAMS-67257', updatedon = now()
where intakeservicerequestactorid = '80ff16b6-8e5d-464c-b1a9-b76b3286981a' and activeflag = 1;