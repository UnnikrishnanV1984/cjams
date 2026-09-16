/*
Issue: CJAMS-63949 Unable to change Disposition to Not Named
Category/Module: Person / Maltreatment allegation
Root cause: As per current design, the sexual abuse maltreatment type is temporary suspended in CJAMS so the appeal worker can not change the findings to Indicated Unnamed. 
			Case is already closed and data fix is need to add a new Person Card with the name "Unnamed," assign them the role of "maltreator," and remove the maltreator role from the original Person Card.
Fix provided: Data fix has been done to add a new Person Card with the name "Unnamed," assign them the role of "maltreator," and remove the maltreator role from the original Person Card. 
Data/Code fix ticket#: CJAMS-63949
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Case is closed and data fix is needed to resolve this issue.
*/





--Inserting an unknown person in person
insert into person
	(personid, activeflag, firstname, lastname, dangerlevel, updatedby, updatedon, insertedby, insertedon, effectivedate, dob,
	maritalstatustypekey, gendertypekey, refusessn, refusedob, dangertoself, isdraft, expungementflag, dobflag,
	nameunknownflag, adoptedflag, everbeenadoptedflag, sysdetadptflag, clientflag, approximateageno, criminalrecordflag,
	providerid, datavalidflag, outofstateflag, disabilityflag, afcarsageoutflag, fetalalcoholspctrmdisordflag,
	substanceexposednewbornflag, isapproxdob, citizenalenageflag, safehavenbabyflag, batchrunflag, isuscitizen)
values (gen_random_uuid(), 1, 'Unnamed', 'Unnamed', 0, 'CJAMS-63949', now(), 'CJAMS-63949', now(), now(), '1900-01-01 00:00:00', 99, 'U', false,
	false, 2, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0);
	
--Inserting created unknown person into actor 
insert into actor
	(actorid, activeflag, personid, actortype, insertedby, insertedon, updatedby, updatedon, manualupdateflag, intakeserviceid,
	iscollateralcontact, ismentalillness, ismentalimpair, ishouseholdmember, isdangertoworker, sphouseholdmemberflag, spchildflag,
	spreporteranonymousflag, spreporternoletterflag, spexpungementflag, fetalalcoholspctrmdisordflag, drugexposednewbornflag,
	probationsearchconductedflag, sexoffenderregisteredflag, unknownreporterflag)
values (gen_random_uuid(), 1, (select personid from person p where p.insertedby = 'CJAMS-63949'), 'AM', 'CJAMS-63949', now(), 'CJAMS-63949', now(),
	'N', '59184d8d-387d-40fa-9709-539dec9271b6', 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0);
	
--Inserting created unknown actor into intakeservicerequest
update intakeservicerequestactor
set
	actorid = (select actorid from actor a where a.personid = (select personid from person p where p.insertedby = 'CJAMS-63949')),
	personid = (select personid from person p where p.insertedby = 'CJAMS-63949'),
	updatedby = 'CJAMS-63949', updatedon = now()
where intakeservicerequestactorid = '90481087-e3eb-4392-889c-798b00cc9f22' and activeflag = 1;