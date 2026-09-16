/*
Issue: CJAMS-64211 Wrong Maltreator Identified in CJAMS
Category/Module: Person / Maltreatment allegation
Root cause: This is not a defect as the respective client (JOSEPH WALTER FISHER / PID# 3795611) is identified as Alleged maltreator in the CPS IR # CW2836703 with maltreatment type as Sexual Abuse.
            SSA approved and data fix needed to make the following changes
            1) Remove the Alleged Maltreator role from JOSEPH WALTER FISHER (PID# 3795611)
            2) Remove the client (JOSEPH WALTER FISHER/PID# 3795611) from Intake & CPS IR # CW2836703
            3) Add Unknown Person card with role as Alleged Maltreator to the intake & CPS IR # CW2836703
Fix provided:  Data fix has been done to make following changes in the intake and service case
               1) Removed the Alleged Maltreator role from JOSEPH WALTER FISHER (PID# 3795611)
               2) Removed the client (JOSEPH WALTER FISHER/PID# 3795611) from Intake & CPS IR # CW2836703
               3) Added Unknown Person card with role as Alleged Maltreator to the intake & CPS IR # CW2836703
Data/Code fix ticket#: CJAMS-64211
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
values (gen_random_uuid(), 1, 'Unnamed', 'Unnamed', 0, 'CJAMS-64211', now(), 'CJAMS-64211', now(), now(), '1900-01-01 00:00:00', 99, 'U', false,
	false, 2, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0);
	
--Inserting created unknown person into actor 
insert into actor
	(actorid, activeflag, personid, actortype, insertedby, insertedon, updatedby, updatedon, manualupdateflag, intakeserviceid,
	iscollateralcontact, ismentalillness, ismentalimpair, ishouseholdmember, isdangertoworker, sphouseholdmemberflag, spchildflag,
	spreporteranonymousflag, spreporternoletterflag, spexpungementflag, fetalalcoholspctrmdisordflag, drugexposednewbornflag,
	probationsearchconductedflag, sexoffenderregisteredflag, unknownreporterflag, intakenumber)
values (gen_random_uuid(), 1, (select personid from person p where p.insertedby = 'CJAMS-64211'), 'AM', 'CJAMS-64211', now(), 'CJAMS-64211', now(),
	'N', '87cc36ff-0688-484c-9943-b1a3c499c27b', 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'CW9587769');
	
--Inserting created unknown actor into intakeservicerequest
update intakeservicerequestactor
set
	actorid = (select actorid from actor a where a.personid = (select personid from person p where p.insertedby = 'CJAMS-64211')),
	personid = (select personid from person p where p.insertedby = 'CJAMS-64211'),
	updatedby = 'CJAMS-64211', updatedon = now()
	where intakeservicerequestactorid = '5ef61b49-caa3-4723-8332-1b45e6d1a64c' and activeflag = 1;