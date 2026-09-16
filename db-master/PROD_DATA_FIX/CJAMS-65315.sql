/*
CJAMS-65315
Issue Description: 251023154590:Due to the suspension of expungement tasks in CJAMS related to litigation, we are unable to change a Named maltreator to an Unnamed maltreator. Please add 2 new Person Cards with the name "Unnamed," assign them the role of "maltreators," and then remove the maltreators role from the original Person Card
Category/Module: Person
Root cause: User was accidentally marked as AM in this case
Fix provided: DB query to deactivate AM flag from the case
Data/Code fix ticket#:CJAMS-65315
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Inserting 2 unnamed persons in person
insert into person
	(personid, activeflag, firstname, lastname, dangerlevel, updatedby, updatedon, insertedby, insertedon, effectivedate, dob,
	maritalstatustypekey, gendertypekey, refusessn, refusedob, dangertoself, isdraft, expungementflag, dobflag,
	nameunknownflag, adoptedflag, everbeenadoptedflag, sysdetadptflag, clientflag, approximateageno, criminalrecordflag,
	providerid, datavalidflag, outofstateflag, disabilityflag, afcarsageoutflag, fetalalcoholspctrmdisordflag,
	substanceexposednewbornflag, isapproxdob, citizenalenageflag, safehavenbabyflag, batchrunflag, isuscitizen)
values ('38b2cc89-703a-40c0-a2e0-92c048e8457a', 1, 'Unnamed', 'Unnamed', 0, 'CJAMS-65315', now(), 'CJAMS-65315', now(), now(), '1900-01-01 00:00:00', 99, 'U', false,
	false, 2, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
		('55538b28-8fe1-4cd0-bebb-20ff8665b9fa', 1, 'Unnamed', 'Unnamed', 0, 'CJAMS-65315', now(), 'CJAMS-65315', now(), now(), '1900-01-01 00:00:00', 99, 'U', false,
	false, 2, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0);


--Actor records for above Unnamed persons
insert into actor
	(actorid, activeflag, personid, actortype, insertedby, insertedon, updatedby, updatedon, manualupdateflag, intakeserviceid,
	iscollateralcontact, ismentalillness, ismentalimpair, ishouseholdmember, isdangertoworker, sphouseholdmemberflag, spchildflag,
	spreporteranonymousflag, spreporternoletterflag, spexpungementflag, fetalalcoholspctrmdisordflag, drugexposednewbornflag,
	probationsearchconductedflag, sexoffenderregisteredflag, unknownreporterflag, intakenumber)
values (gen_random_uuid(), 1, '38b2cc89-703a-40c0-a2e0-92c048e8457a', 'RA', 'CJAMS-65315', now(), 'CJAMS-65315', now(),
	'N', 'a26366d4-f2d2-4352-9133-0c198b23dc49', 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, null),
		(gen_random_uuid(), 1, '55538b28-8fe1-4cd0-bebb-20ff8665b9fa', 'RA', 'CJAMS-65315', now(), 'CJAMS-65315', now(),
	'N', 'a26366d4-f2d2-4352-9133-0c198b23dc49', 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, null);

-- Link above actor record to alleged maltreator intakeservicerequestactor records
update intakeservicerequestactor
set personid = '38b2cc89-703a-40c0-a2e0-92c048e8457a',
	actorid = (select actorid from cjams.actor where personid = '38b2cc89-703a-40c0-a2e0-92c048e8457a' and insertedby = 'CJAMS-65315' LIMIT 1),
	updatedby = 'CJAMS-65315', 
	updatedon = now()
where intakeservicerequestactorid IN ('f422381c-2ecc-4037-9ee4-ab87ba646c28');

update intakeservicerequestactor
set personid = '55538b28-8fe1-4cd0-bebb-20ff8665b9fa',
	actorid = (select actorid from cjams.actor where personid = '55538b28-8fe1-4cd0-bebb-20ff8665b9fa' and insertedby = 'CJAMS-65315' LIMIT 1),
	updatedby = 'CJAMS-65315', 
	updatedon = now()
where intakeservicerequestactorid IN ('d8c70c96-0cfe-43a1-a97c-ff4efc58595c');

