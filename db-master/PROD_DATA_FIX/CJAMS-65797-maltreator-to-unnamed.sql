/*
Issue: CJAMS-65797 Wrong Maltreator Identified in CJAMS
Category/Module: Person / Maltreatment allegation
Root cause: This is not a defect as the respective client (NATALIE ALLEN SOPHIA / PID# 4300150) is identified as Alleged maltreator in the case 251023310684
            SSA approved and data fix needed to make the following changes
            1) Remove the Alleged Maltreator role from (NATALIE ALLEN SOPHIA / PID# 4300150)
            2) Remove the client (NATALIE ALLEN SOPHIA / PID# 4300150) from Intake & CPS IR # 251023310684
            3) Add Unnamed Person card with role as Alleged Maltreator to the intake & CPS IR # 251023310684
Fix provided:  Data fix has been done to make following changes in the intake and service case
               1) Removed the Alleged Maltreator role from (NATALIE ALLEN SOPHIA / PID# 4300150)
               2) Removed the client (NATALIE ALLEN SOPHIA / PID# 4300150) from Intake & CPS IR # 251023310684
               3) Added Unknown Person card with role as Alleged Maltreator to the intake & CPS IR # 251023310684
Data/Code fix ticket#: CJAMS-65797
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is as per system design and data fix is needed to resolve it.
*/


--Inserting an unknown person in person
insert into person
	(personid, activeflag, firstname, lastname, dangerlevel, updatedby, updatedon, insertedby, insertedon, effectivedate, dob,
	maritalstatustypekey, gendertypekey, refusessn, refusedob, dangertoself, isdraft, expungementflag, dobflag,
	nameunknownflag, adoptedflag, everbeenadoptedflag, sysdetadptflag, clientflag, approximateageno, criminalrecordflag,
	providerid, datavalidflag, outofstateflag, disabilityflag, afcarsageoutflag, fetalalcoholspctrmdisordflag,
	substanceexposednewbornflag, isapproxdob, citizenalenageflag, safehavenbabyflag, batchrunflag, isuscitizen)
values (gen_random_uuid(), 1, 'Unnamed', 'Unnamed', 0, 'CJAMS-65797', now(), 'CJAMS-65797', now(), now(), '1900-01-01 00:00:00', 99, 'U', false,
	false, 2, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0);

--Inserting created unknown person into actor 
insert into actor
	(actorid, activeflag, personid, actortype, insertedby, insertedon, updatedby, updatedon, manualupdateflag, intakeserviceid,
	iscollateralcontact, ismentalillness, ismentalimpair, ishouseholdmember, isdangertoworker, sphouseholdmemberflag, spchildflag,
	spreporteranonymousflag, spreporternoletterflag, spexpungementflag, fetalalcoholspctrmdisordflag, drugexposednewbornflag,
	probationsearchconductedflag, sexoffenderregisteredflag, unknownreporterflag)
values (gen_random_uuid(), 1, (select personid from person p where p.insertedby = 'CJAMS-65797'), 'AM', 'CJAMS-65797', now(), 'CJAMS-65797', now(),
	'N', 'eddb1aa1-7949-45ff-83ec-fd2d4bb7b539', 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0);

--Inserting created unknown actor into intakeservicerequest
update intakeservicerequestactor
set
	actorid = (select actorid from actor a where a.personid = (select personid from person p where p.insertedby = 'CJAMS-65797')),
	personid = (select personid from person p where p.insertedby = 'CJAMS-65797'),
	updatedby = 'CJAMS-65797', updatedon = now()
where intakeservicerequestactorid = '40f09a36-c65d-456f-b6ec-99219eeb7585' and activeflag = 1;
