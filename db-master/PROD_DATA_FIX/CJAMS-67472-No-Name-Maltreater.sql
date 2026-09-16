/*
Issue: CJAMS-67472 Wrong Maltreator Identified in CJAMS
Category/Module: Person / Maltreatment allegation
Root cause: 1. Remove the Alleged Maltreator role from Landon Jacob Morris (PID# 3930901
            2. Add Unnamed Unnamed person card with role as Alleged Maltreator into the CPS IR # 241021854988.
            3. Verify the alleged maltreator name will displayed as Unnamed Unnamed on the Maltreatment Allegation screen, Investigation Findings screen, and Investigation Summary Report.
Fix provided:  Data fix has been done 
Data/Code fix ticket#: CJAMS-67472
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
values (gen_random_uuid(), 1, 'Unnamed', 'Unnamed', 0, 'CJAMS-67472', now(), 'CJAMS-67472', now(), now(), '1900-01-01 00:00:00', 99, 'U', false,
	false, 2, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0);
	
--Inserting created unknown person into actor 
insert into actor
	(actorid, activeflag, personid, actortype, insertedby, insertedon, updatedby, updatedon, manualupdateflag, intakeserviceid,
	iscollateralcontact, ismentalillness, ismentalimpair, ishouseholdmember, isdangertoworker, sphouseholdmemberflag, spchildflag,
	spreporteranonymousflag, spreporternoletterflag, spexpungementflag, fetalalcoholspctrmdisordflag, drugexposednewbornflag,
	probationsearchconductedflag, sexoffenderregisteredflag, unknownreporterflag, intakenumber)
values (gen_random_uuid(), 1, (select personid from person p where p.insertedby = 'CJAMS-67472'), 'AM', 'CJAMS-67472', now(), 'CJAMS-67472', now(),
	'N', '9cbceaed-751f-4549-8164-d9d28089cacb', 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, '241021854988');
	
--Inserting created unknown actor into intakeservicerequest
update intakeservicerequestactor
set
	actorid = (select actorid from actor a where a.personid = (select personid from person p where p.insertedby = 'CJAMS-67472')),
	personid = (select personid from person p where p.insertedby = 'CJAMS-67472'),
	updatedby = 'CJAMS-67472', updatedon = now()
	where intakeservicerequestactorid = 'c09ca8f0-e2e0-4c41-8369-f63003055212' and activeflag = 1;