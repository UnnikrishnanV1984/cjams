/*
CJAMS-65291
Issue Description: CW2197461:Per the investigation summary report, no maltreater should be named, therefore the maltreaters should ne unnamed
Category/Module: Person
Root cause: User was accidentally marked as AM in this case
Fix provided: DB query to deactivate AM flag from the case
Data/Code fix ticket#:CJAMS-65291
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
values ('562b435d-2447-494d-a5b0-3a3f059931ee', 1, 'Unnamed', 'Unnamed', 0, 'CJAMS-65291', now(), 'CJAMS-65291', now(), now(), '1900-01-01 00:00:00', 99, 'U', false,
	false, 2, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
		('061534ed-c2df-46c7-bbc0-761573bf9b2e', 1, 'Unnamed', 'Unnamed', 0, 'CJAMS-65291', now(), 'CJAMS-65291', now(), now(), '1900-01-01 00:00:00', 99, 'U', false,
	false, 2, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0);


--Actor records for above Unnamed persons
insert into actor
	(actorid, activeflag, personid, actortype, insertedby, insertedon, updatedby, updatedon, manualupdateflag, intakeserviceid,
	iscollateralcontact, ismentalillness, ismentalimpair, ishouseholdmember, isdangertoworker, sphouseholdmemberflag, spchildflag,
	spreporteranonymousflag, spreporternoletterflag, spexpungementflag, fetalalcoholspctrmdisordflag, drugexposednewbornflag,
	probationsearchconductedflag, sexoffenderregisteredflag, unknownreporterflag, intakenumber)
values (gen_random_uuid(), 1, '562b435d-2447-494d-a5b0-3a3f059931ee', 'RA', 'CJAMS-65291', now(), 'CJAMS-65291', now(),
	'N', 'fc4485ad-c15e-470f-a018-ccd1624a33b5', 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'CW2197461'),
		(gen_random_uuid(), 1, '061534ed-c2df-46c7-bbc0-761573bf9b2e', 'RA', 'CJAMS-65291', now(), 'CJAMS-65291', now(),
	'N', 'fc4485ad-c15e-470f-a018-ccd1624a33b5', 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'CW2197461');


-- Link above actor record to alleged maltreator intakeservicerequestactor records
update intakeservicerequestactor
set personid = '562b435d-2447-494d-a5b0-3a3f059931ee',
	actorid = (select actorid from cjams.actor where personid = '562b435d-2447-494d-a5b0-3a3f059931ee' and insertedby = 'CJAMS-65291' LIMIT 1),
	updatedby = 'CJAMS-65291', 
	updatedon = now()
where intakeservicerequestactorid IN ('d1c9003a-8fd1-43d9-954e-f5de5763db97');

update intakeservicerequestactor
set personid = '061534ed-c2df-46c7-bbc0-761573bf9b2e',
	actorid = (select actorid from cjams.actor where personid = '061534ed-c2df-46c7-bbc0-761573bf9b2e' and insertedby = 'CJAMS-65291' LIMIT 1),
	updatedby = 'CJAMS-65291', 
	updatedon = now()
where intakeservicerequestactorid IN ('1c41456f-79fc-405a-82d3-0125d0cfccf4');


-- Create intakeservierequestactor for CJAMSPID 1458093 with OtherAdult Role
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
VALUES ('1d7a48d1-5daf-41ef-80d9-f4803622c657', 'OtherADULT', NULL, 
	'CJAMS-65291', now(), 'CJAMS-65291', now(), NULL, NULL, 'fc4485ad-c15e-470f-a018-ccd1624a33b5'::uuid, 
	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
	false, false, 1, true, true, '277e4653-730d-414a-89eb-77a94a0a86df', 'CW2197461',
	NULL, NULL, 1, NULL, NULL, 0, 0, NULL, NULL, NULL, 
	NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 0, NULL, 
	NULL, NULL, NULL, 1, NULL, 0, 0, 1, 0, 0, 
	NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, 
	NULL, 1, 1598860, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
	NULL, NULL, NULL, NULL, 'CW2197461', false, NULL, NULL, NULL, NULL, 0);


--Removing Alleged Maltreator role for CJAMSPID 1595595
update intakeservicerequestactor
set intakeservicerequestpersontypekey = 'OtherADULT',
	updatedby = 'CJAMS-65291', updatedon = now()
where intakeservicerequestactorid IN ('97537f4d-cc6e-4fad-95c5-6750c8f93eba')
	and activeflag = 1;




