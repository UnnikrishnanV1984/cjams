/*
-- Issue Description: 
   Dev Team,

            CPS IR # 261023640398

        1. Remove Alleged Maltreater Role from CJAMS PID# 204876835 Ethan Gonzalez and add Child Role as required 
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
values ('38b2bb89-713b-40d0-a2e0-92c048e8457a', 1, 'Unnamed', 'Unnamed', 0, 'CJAMS-67256', now(), 'CJAMS-67256', now(), now(), '1900-01-01 00:00:00', 99, 'U', false,
	false, 2, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0);

--Actor records for above Unnamed persons
insert into actor
	(actorid, activeflag, personid, actortype, insertedby, insertedon, updatedby, updatedon, manualupdateflag, intakeserviceid,
	iscollateralcontact, ismentalillness, ismentalimpair, ishouseholdmember, isdangertoworker, sphouseholdmemberflag, spchildflag,
	spreporteranonymousflag, spreporternoletterflag, spexpungementflag, fetalalcoholspctrmdisordflag, drugexposednewbornflag,
	probationsearchconductedflag, sexoffenderregisteredflag, unknownreporterflag, intakenumber)
values (gen_random_uuid(), 1, '38b2bb89-713b-40d0-a2e0-92c048e8457a', 'AM', 'CJAMS-67256', now(), 'CJAMS-67256', now(),
	'N', '81fd4ab1-1533-4d67-9202-82513f074740', 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, null);

-- Link above actor record to alleged maltreator intakeservicerequestactor records
update intakeservicerequestactor
set personid = '38b2bb89-713b-40d0-a2e0-92c048e8457a',
	actorid = (select actorid from cjams.actor where personid = '38b2bb89-713b-40d0-a2e0-92c048e8457a' and insertedby = 'CJAMS-67256' LIMIT 1),
	updatedby = 'CJAMS-67256', 
	updatedon = now()
where intakeservicerequestactorid IN ('aab0398a-bfb7-47f9-9056-c7a338027335');


INSERT INTO cjams.intakeservicerequestactor
(actorid, intakeservicerequestpersontypekey, rapersontypekey, 
	insertedby, insertedon, updatedby, updatedon, expirationdate, "timestamp", intakeserviceid, 
	routingaddressid, employeetypeid, employeetypename, medicaideligibility, blockgranteligibility, livingarrangementtypekey, guardianname, guardianinfo, ramentalhealth, ramentalretarted, ramentalretartedtype, 
	refusessn, refusedob, activeflag, reported, isprimary, personid, old_id, 
	ismaltreator, rcprimaryroletypekey, ncpspriorhistoryflag, householdnumber, ssnverifytypekey, rchandicapflag, rchomelessflag, lvgarrangementtypekey, livingprefixtypekey, lvgfirstname, 
	lvgmiddlename, lvglastname, lvgsuffixtypekey, lvgrelationshiptypekey, lvgcomments, rchouseholdflag, rcchildflag, nonparticipatingflag, householdheadflag, 
	rcinsertedon, rcinsertedby, rcupdatedon, rcupdatedby, rcactiveflag, livingwith, rcreporteranonymousflag, rcreporternoletterflag, clientflag, rcexpungementflag, 
	rcdatavalidflag, rcclientmergeid, arclientid, arsummaryid, altrespclientid, participatingchildflag, aractiveflag, screeningpersonid, prexpungementflag, prdatavalidflag, 
	prinsertedby, prupdatedby, practiveflag, referralclientid, caseclientid, crexpungementflag, crdatavalidflag, crinsertedby, crupdatedby, sphouseholdmemberflag, 
	spchildflag, spreporteranonymousflag, spreporternoletterflag, spexpungementflag, fetalalcoholspctrmdisordflag, drugexposednewbornflag, probationsearchconductedflag, sexoffenderregisteredflag, otherdrugs, unknownreporterflag, 
	spproviderid, fk_id, isvictim, servicecaseid, fk_cl_id, intakenumber, isheadofhousehold, etl_userid, etl_load_date, objectid, objecttype, isexpunged)
VALUES ((select actorid from cjams.actor where personid = '0ff6feb8-0e8d-4365-a4c1-5b5919e9ab82' LIMIT 1), 'OTHERCHILD', NULL, 
	'CJAMS-67256', now(), 'CJAMS-67256', now(), NULL, NULL, '81fd4ab1-1533-4d67-9202-82513f074740'::uuid, 
	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
	false, false, 1, true, true, '0ff6feb8-0e8d-4365-a4c1-5b5919e9ab82', 'I261013908942',
	NULL, NULL, 1, NULL, NULL, 0, 0, NULL, NULL, NULL, 
	NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 0, NULL, 
	NULL, NULL, NULL, 1, NULL, 0, 0, 1, 0, 0, 
	NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, 
	NULL, 1, null, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
	NULL, NULL, NULL, NULL, 'I261013908942', false, NULL, NULL, NULL, NULL, 0);
