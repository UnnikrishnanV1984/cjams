/*
Issue: CJAMS-65433Need to change the maltreater to unnamed
Category/Module: Person / Maltreatment allegation
Root cause: Requested for a data fix to add a new Person Card with the name "Unnamed," assign them the role of "maltreator," and remove the maltreator role from the original Person Card. 
Fix provided: Data fix has been done to add a new Person Card with the name "Unnamed," assign them the role of "maltreator," and remove the maltreator role from the original Person Card. 
Data/Code fix ticket#: CJAMS-65433
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: 
*/





--Inserting an unknown person in person
insert into person
	(personid, activeflag, firstname, lastname, dangerlevel, updatedby, updatedon, insertedby, insertedon, effectivedate, dob,
	maritalstatustypekey, gendertypekey, refusessn, refusedob, dangertoself, isdraft, expungementflag, dobflag,
	nameunknownflag, adoptedflag, everbeenadoptedflag, sysdetadptflag, clientflag, approximateageno, criminalrecordflag,
	providerid, datavalidflag, outofstateflag, disabilityflag, afcarsageoutflag, fetalalcoholspctrmdisordflag,
	substanceexposednewbornflag, isapproxdob, citizenalenageflag, safehavenbabyflag, batchrunflag, isuscitizen)
values (gen_random_uuid(), 1, 'Unnamed', 'Unnamed', 0, 'CJAMS-65433', now(), 'CJAMS-65433', now(), now(), '1900-01-01 00:00:00', 99, 'U', false,
	false, 2, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0);
	
--Inserting created unknown person into actor 
insert into actor
	(actorid, activeflag, personid, actortype, insertedby, insertedon, updatedby, updatedon, manualupdateflag, intakeserviceid,
	iscollateralcontact, ismentalillness, ismentalimpair, ishouseholdmember, isdangertoworker, sphouseholdmemberflag, spchildflag,
	spreporteranonymousflag, spreporternoletterflag, spexpungementflag, fetalalcoholspctrmdisordflag, drugexposednewbornflag,
	probationsearchconductedflag, sexoffenderregisteredflag, unknownreporterflag)
values (gen_random_uuid(), 1, (select personid from person p where p.insertedby = 'CJAMS-65433'), 'AM', 'CJAMS-65433', now(), 'CJAMS-65433', now(),
	'N', '1fa18b0c-27d5-4ce6-b7e6-7575df6988e9', 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0);
	
--Inserting created unknown actor into intakeservicerequest
update intakeservicerequestactor
set
	actorid = (select actorid from actor a where a.personid = (select personid from person p where p.insertedby = 'CJAMS-65433')),
	personid = (select personid from person p where p.insertedby = 'CJAMS-65433'),
	updatedby = 'CJAMS-65433', updatedon = now()
where intakeservicerequestactorid = 'ad4eaf7f-7775-46af-a644-24f76768e434' and activeflag = 1;