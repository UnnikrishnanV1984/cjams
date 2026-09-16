/*
-- Issue Description: 
   CPS IR # 261023622374

1. Remove Alleged Maltreater Role from CJAMS PID# 3323807 BROOKLYN MICHELLE KERILL and add Other Child Role as required 
2. Create a new person card 'Unnamed' with Role as Alleged Maltreater 
-- Category/ Module: Case Data (Case Management)
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


insert into person
	(personid, activeflag, firstname, lastname, dangerlevel, updatedby, updatedon, insertedby, insertedon, effectivedate, dob,
	maritalstatustypekey, gendertypekey, refusessn, refusedob, dangertoself, isdraft, expungementflag, dobflag,
	nameunknownflag, adoptedflag, everbeenadoptedflag, sysdetadptflag, clientflag, approximateageno, criminalrecordflag,
	providerid, datavalidflag, outofstateflag, disabilityflag, afcarsageoutflag, fetalalcoholspctrmdisordflag,
	substanceexposednewbornflag, isapproxdob, citizenalenageflag, safehavenbabyflag, batchrunflag, isuscitizen)
values ('38b2bb89-703a-40d0-a2e0-92c048e8457a', 1, 'Unnamed', 'Unnamed', 0, 'CJAMS-67258', now(), 'CJAMS-67258', now(), now(), '1900-01-01 00:00:00', 99, 'U', false,
	false, 2, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0);

--Actor records for above Unnamed persons
insert into actor
	(actorid, activeflag, personid, actortype, insertedby, insertedon, updatedby, updatedon, manualupdateflag, intakeserviceid,
	iscollateralcontact, ismentalillness, ismentalimpair, ishouseholdmember, isdangertoworker, sphouseholdmemberflag, spchildflag,
	spreporteranonymousflag, spreporternoletterflag, spexpungementflag, fetalalcoholspctrmdisordflag, drugexposednewbornflag,
	probationsearchconductedflag, sexoffenderregisteredflag, unknownreporterflag, intakenumber)
values (gen_random_uuid(), 1, '38b2bb89-703a-40d0-a2e0-92c048e8457a', 'AM', 'CJAMS-67258', now(), 'CJAMS-67258', now(),
	'N', '53d63478-0b83-49b7-9eb9-01f99b005b74', 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, null);

-- Link above actor record to alleged maltreator intakeservicerequestactor records
update intakeservicerequestactor
set personid = '38b2bb89-703a-40d0-a2e0-92c048e8457a',
	actorid = (select actorid from cjams.actor where personid = '38b2bb89-703a-40d0-a2e0-92c048e8457a' and insertedby = 'CJAMS-67258' LIMIT 1),
	updatedby = 'CJAMS-67258', 
	updatedon = now()
where intakeservicerequestactorid IN ('2724a4c1-b63b-4c1e-8155-3b09f024655b');


