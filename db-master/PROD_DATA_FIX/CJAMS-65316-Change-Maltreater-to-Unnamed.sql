/*
Issue Description: User request to remove the Alleged Maltreator role from Client ID: 4457325 (JOSE G MORALES) and 
      add Unnamed Unnamed person card with role as Alleged Maltreator into the CPS IR # 251023138573.
Category/Module: Bug
Root cause: User requested update Maltreator to unknown person
Fix provided: DB queries to insert unknown person and change Maltreator 
Data/Code fix ticket#: CJAMS-65316
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
values (gen_random_uuid(), 1, 'Unknown', 'Unknown', 'CJAMS-65316', now(), 'CJAMS-65316', now(), now(), '1900-01-01 00:00:00', 'F', false,
	false, 0, 0);
	
--Inserting above person into actor for this case
insert into actor
	(actorid, activeflag, personid, actortype, insertedby, insertedon, updatedby, updatedon, manualupdateflag, intakeserviceid,
	iscollateralcontact, ishouseholdmember, intakenumber)
values (gen_random_uuid(), 1, (select personid from person where insertedby = 'CJAMS-65316' and activeflag = 1), 'RA', 'CJAMS-65316', now(), 'CJAMS-65316', now(), 0,
	'19c729f9-ef7e-4e55-ba96-97dadc28b213', 0, 1, 'I251013371866');



--Changing actorid for AM on this case in intakeservicerequestactor
update intakeservicerequestactor
set actorid = (select actorid from actor where insertedby = 'CJAMS-65316' and activeflag = 1),
	personid = (select personid from person where insertedby = 'CJAMS-65316' and activeflag = 1),
	updatedby = 'CJAMS-65316', updatedon = now()
where intakeservicerequestactorid = 'ad13dd99-98fd-4a1f-9507-2eaf5ab59bb7' and activeflag = 1;



insert into intakeservicerequestactor
(intakeservicerequestactorid,activeflag,actorid,personid,intakeservicerequestpersontypekey,insertedby,insertedon,updatedby,updatedon,intakeserviceid,intakenumber)
values
(gen_random_uuid(), '1','2e0cb47a-ac95-4447-a1ef-0d90b41c57e4','09dbab76-cb76-4d7d-a572-5a36e3ea29a0','OtherADULT', 'CJAMS-65316',now(),'CJAMS-65316',now(),'19c729f9-ef7e-4e55-ba96-97dadc28b213','I251013371866');
