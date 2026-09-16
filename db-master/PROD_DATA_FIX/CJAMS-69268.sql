/*
Issue: CJAMS-69268 - Replace maltreator's name with Unknown
Category/Module: Person / Maltreatment Allegation / Investigation Findings
Root cause: Not a defect. Per a signed settlement agreement through the Harford County Courts,
   SSA approved removing the Alleged Maltreator role from NOAH DAVID HALL (CJAMS PID# 3540971)
   and adding an Unknown person card as the Alleged Maltreator on CPS IR # CW2862985.
Fix provided: Data fix has been done to add an Unknown person card with the role Alleged Maltreator
   and remove the Alleged Maltreator role from NOAH DAVID HALL (CJAMS PID# 3540971) on
   CPS IR # CW2862985.
Data/Code fix ticket#: CJAMS-69268
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
values (gen_random_uuid(), 1, 'Unnamed', 'Unnamed', 0, 'CJAMS-69268', now(), 'CJAMS-69268', now(), now(), '1900-01-01 00:00:00', 99, 'U', false,
	false, 2, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0);
	
--Inserting created unknown person into actor 
insert into actor
	(actorid, activeflag, personid, actortype, insertedby, insertedon, updatedby, updatedon, manualupdateflag, intakeserviceid,
	iscollateralcontact, ismentalillness, ismentalimpair, ishouseholdmember, isdangertoworker, sphouseholdmemberflag, spchildflag,
	spreporteranonymousflag, spreporternoletterflag, spexpungementflag, fetalalcoholspctrmdisordflag, drugexposednewbornflag,
	probationsearchconductedflag, sexoffenderregisteredflag, unknownreporterflag, intakenumber)
values (gen_random_uuid(), 1, (select personid from person p where p.insertedby = 'CJAMS-69268'), 'AM', 'CJAMS-69268', now(), 'CJAMS-69268', now(),
	'N', 'a3ab8512-7757-4dfd-bf60-219648064717', 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'CW9738321');
	
--Inserting created unknown actor into intakeservicerequest
update intakeservicerequestactor
set
	actorid = (select actorid from actor a where a.personid = (select personid from person p where p.insertedby = 'CJAMS-69268')),
	personid = (select personid from person p where p.insertedby = 'CJAMS-69268'),
	updatedby = 'CJAMS-69268', updatedon = now()
	where intakeservicerequestactorid = 'eac2abf2-d9aa-4648-a1e5-2b895bce1435' and activeflag = 1;
