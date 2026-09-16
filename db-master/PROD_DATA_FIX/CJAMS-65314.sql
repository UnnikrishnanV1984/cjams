/*
CJAMS-65314
Issue Description: 251023149275:Please add a new Person Card with the name "Unnamed," assign them the role of "maltreator," and then remove the maltreator role from the original Person Card
Category/Module: Person
Root cause: User was accidentally marked as AM in this case
Fix provided: DB query to change Aleged Maltreator to Unnamed
Data/Code fix ticket#:CJAMS-65291
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


--Inserting unnamed person
insert into cjams.person
	(activeflag, firstname, lastname, dangerlevel, updatedby, updatedon, insertedby, insertedon, effectivedate, dob,
	maritalstatustypekey, gendertypekey, refusessn, refusedob, dangertoself, isdraft, expungementflag, dobflag,
	nameunknownflag, adoptedflag, everbeenadoptedflag, sysdetadptflag, clientflag, approximateageno, criminalrecordflag,
	providerid, datavalidflag, outofstateflag, disabilityflag, afcarsageoutflag, fetalalcoholspctrmdisordflag,
	substanceexposednewbornflag, isapproxdob, citizenalenageflag, safehavenbabyflag, batchrunflag, isuscitizen)
values (1, 'Unnamed', 'Unnamed', 0, 'CJAMS-65314', now(), 'CJAMS-65314', now(), now(), '1900-01-01 00:00:00', 99, 'U', false,
	false, 2, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0);
	
	
insert into cjams.actor
	(actorid, activeflag, personid, actortype, insertedby, insertedon, updatedby, updatedon, manualupdateflag, intakeserviceid,
	iscollateralcontact, ismentalillness, ismentalimpair, ishouseholdmember, isdangertoworker, sphouseholdmemberflag, spchildflag,
	spreporteranonymousflag, spreporternoletterflag, spexpungementflag, fetalalcoholspctrmdisordflag, drugexposednewbornflag,
	probationsearchconductedflag, sexoffenderregisteredflag, unknownreporterflag, intakenumber)
values (gen_random_uuid(), 1, (select personid from cjams.person p where insertedby = 'CJAMS-65314' LIMIT 1), 'CHILD', 'CJAMS-65314', now(), 'CJAMS-65314', now(),
	'N', '7bddc209-9bdc-49b1-b508-c5748d2ae2c2', 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, null);
	
	
update cjams.intakeservicerequestactor
set personid = (select personid from cjams.person p where insertedby = 'CJAMS-65314' LIMIT 1),
	actorid = (select actorid from cjams.actor where insertedby = 'CJAMS-65314' LIMIT 1),
	updatedby = 'CJAMS-65314', 
	updatedon = now()
where intakeservicerequestactorid IN ('232eca12-0853-4ef6-986f-632589ba7247');

