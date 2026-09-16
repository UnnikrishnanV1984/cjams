/*
Issue: CJAMS-65317 Wrong Maltreator Identified in CJAMS
Category/Module: Person / Maltreatment allegation
Root cause: This is not a defect as the respective client (RONALD ALEXANDER CAMPOSRIVAS  / PID# 4392232) is identified as Alleged maltreator in the CPS IR # 221020186028 with maltreatment type as Sexual Abuse.
            SSA approved and data fix needed to make the following changes
            1) Remove the Alleged Maltreator role from RONALD ALEXANDER CAMPOSRIVAS (PID# 4392232)
            2) Add Unknown Person card with role as Alleged Maltreator in CPS IR # 221020186028
Fix provided:  Data fix has been done to make following changes in the intake and service case
               1) Removed the Alleged Maltreator role from RONALD ALEXANDER CAMPOSRIVAS (PID# 4392232)
               2) Added Unknown Person card with role as Alleged Maltreator in CPS IR # 221020186028
Data/Code fix ticket#: CJAMS-65317
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
values (gen_random_uuid(), 1, 'Unnamed', 'Unnamed', 0, 'CJAMS-65317', now(), 'CJAMS-65317', now(), now(), '1900-01-01 00:00:00', 99, 'U', false,
	false, 2, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0);
	
--Inserting created unknown person into actor 
insert into actor
	(actorid, activeflag, personid, actortype, insertedby, insertedon, updatedby, updatedon, manualupdateflag, intakeserviceid,
	iscollateralcontact, ismentalillness, ismentalimpair, ishouseholdmember, isdangertoworker, sphouseholdmemberflag, spchildflag,
	spreporteranonymousflag, spreporternoletterflag, spexpungementflag, fetalalcoholspctrmdisordflag, drugexposednewbornflag,
	probationsearchconductedflag, sexoffenderregisteredflag, unknownreporterflag, intakenumber)
values (gen_random_uuid(), 1, (select personid from person p where p.insertedby = 'CJAMS-65317'), 'AM', 'CJAMS-65317', now(), 'CJAMS-65317', now(),
	'N', '8bf18957-46b7-42c6-be84-a8bd90278e95', 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, '221020186028');
	
--Inserting created unknown actor into intakeservicerequest
update intakeservicerequestactor
set
	actorid = (select actorid from actor a where a.personid = (select personid from person p where p.insertedby = 'CJAMS-65317')),
	personid = (select personid from person p where p.insertedby = 'CJAMS-65317'),
	updatedby = 'CJAMS-65317', updatedon = now()
	where intakeservicerequestactorid = '041be262-f165-45e9-9a83-c95d6b5f23da' and activeflag = 1;
