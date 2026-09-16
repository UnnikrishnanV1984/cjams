/*
Issue Description: Please remove Janelle Dorsey as the maltreater for this investigation
Category/Module: Error
Root cause: User was accidentally marked as AM in this case
Fix provided: DB query to deactivate AM flag from the case
Data/Code fix ticket#:CDM-40753
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Inserting an unknown person in person
insert into person
	(personid, activeflag, firstname, lastname, dangerlevel, updatedby, updatedon, insertedby, insertedon, effectivedate, dob,
	maritalstatustypekey, gendertypekey, refusessn, refusedob, dangertoself, isdraft, expungementflag, dobflag,
	nameunknownflag, adoptedflag, everbeenadoptedflag, sysdetadptflag, clientflag, approximateageno, criminalrecordflag,
	providerid, datavalidflag, outofstateflag, disabilityflag, afcarsageoutflag, fetalalcoholspctrmdisordflag,
	substanceexposednewbornflag, isapproxdob, citizenalenageflag, safehavenbabyflag, batchrunflag, isuscitizen)
values (gen_random_uuid(), 1, 'Unnamed', 'Unnamed', 0, 'CDM-40753', now(), 'CDM-40753', now(), now(), '1900-01-01 00:00:00', 99, 'U', false,
	false, 2, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0);
	
--Inserting created unknown person into actor 
insert into actor
	(actorid, activeflag, personid, actortype, insertedby, insertedon, updatedby, updatedon, manualupdateflag, intakeserviceid,
	iscollateralcontact, ismentalillness, ismentalimpair, ishouseholdmember, isdangertoworker, sphouseholdmemberflag, spchildflag,
	spreporteranonymousflag, spreporternoletterflag, spexpungementflag, fetalalcoholspctrmdisordflag, drugexposednewbornflag,
	probationsearchconductedflag, sexoffenderregisteredflag, unknownreporterflag, intakenumber)
values (gen_random_uuid(), 1, (select personid from person p where p.insertedby = 'CDM-40753'), 'RA', 'CDM-40753', now(), 'CDM-40753', now(),
	'N', '74b24559-c16d-422d-a6b4-2caf5c69091b', 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'CW2320969');
	
--Inserting created unknown actor into intakeservicerequest
update intakeservicerequestactor
set 
	actorid = (select actorid from actor a where a.personid = (select personid from person p where p.insertedby = 'CDM-40753')),
	personid = (select personid from person p where p.insertedby = 'CDM-40753'),
	updatedby = 'CDM-40753', updatedon = now()
where intakeservicerequestactorid = '23832940-4705-4ae3-90a2-57a3c6e5b731' and activeflag = 1;