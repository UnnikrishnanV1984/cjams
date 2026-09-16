
/*
Issue: Need to change the maltreater to unnamed
Category/Module: Person / Maltreatment allegation
Root cause: Requested for a data fix to add a new Person Card with the name "Unnamed," assign them the role of "maltreator," and remove the maltreator role from the original Person Card. 
Fix provided: Data fix has been done to add a new Person Card with the name "Unnamed," assign them the role of "maltreator," and remove the maltreator role from the original Person Card. 
Data/Code fix ticket#: CJAMS-66350
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Issue is fixed by adding data on the database.
Status of the code fix: Data fix completed, PR raised for documentation.
*/
insert into person
	(personid, activeflag, firstname, lastname, dangerlevel, updatedby, updatedon, insertedby, insertedon, effectivedate, dob,
	maritalstatustypekey, gendertypekey, refusessn, refusedob, dangertoself, isdraft, expungementflag, dobflag,
	nameunknownflag, adoptedflag, everbeenadoptedflag, sysdetadptflag, clientflag, approximateageno, criminalrecordflag,
	providerid, datavalidflag, outofstateflag, disabilityflag, afcarsageoutflag, fetalalcoholspctrmdisordflag,
	substanceexposednewbornflag, isapproxdob, citizenalenageflag, safehavenbabyflag, batchrunflag, isuscitizen)
values (gen_random_uuid(), 1, 'Unnamed', 'Unnamed', 0, 'CJAMS-66350', now(), 'CJAMS-66350', now(), now(), '2006-06-12 00:00:00', 99, 'Female', false,
	false, 2, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0);
	
--Inserting created unknown person into actor 
insert into actor
	(actorid, activeflag, personid, actortype, insertedby, insertedon, updatedby, updatedon, manualupdateflag, intakeserviceid,
	iscollateralcontact, ismentalillness, ismentalimpair, ishouseholdmember, isdangertoworker, sphouseholdmemberflag, spchildflag,
	spreporteranonymousflag, spreporternoletterflag, spexpungementflag, fetalalcoholspctrmdisordflag, drugexposednewbornflag,
	probationsearchconductedflag, sexoffenderregisteredflag, unknownreporterflag)
values (gen_random_uuid(), 1, (select personid from person p where p.insertedby = 'CJAMS-66350' limit 1), 'AM', 'CJAMS-66350', now(), 'CJAMS-66350', now(),
	'N', '172641ce-140d-469a-8eb9-f7bfba1e052e', 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0);

update intakeservicerequestactor
set
	actorid = (select actorid from actor a where a.personid = (select personid from person p where p.insertedby = 'CJAMS-66350' limit 1) limit 1),
	personid = (select personid from person p where p.insertedby = 'CJAMS-66350' limit 1),
	updatedby = 'CJAMS-66350', updatedon = now()
where intakeservicerequestactorid = 'a435cd49-9c6d-470c-9a10-75de2ffb4444' and activeflag = 1;
