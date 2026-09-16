/*
CDM-40754
Issue Description: The alleged maltreater needs to changed to unknown
Category/Module: Error
Root cause: User was accidentally marked as AM in this case
Fix provided: DB query to deactivate AM flag from the case
Data/Code fix ticket#:CDM-40754
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Inserting an unknown person in person
insert into person
	(personid, activeflag, firstname, lastname, dangerlevel, updatedby, updatedon, insertedby, insertedon, effectivedate, dob,
	maritalstatustypekey, gendertypekey, refusessn, refusedob, dangertoself, isdraft, expungementflag, dobflag,
	nameunknownflag, adoptedflag, everbeenadoptedflag, sysdetadptflag, clientflag, approximateageno, criminalrecordflag,
	providerid, datavalidflag, outofstateflag, disabilityflag, afcarsageoutflag, fetalalcoholspctrmdisordflag,
	substanceexposednewbornflag, isapproxdob, citizenalenageflag, safehavenbabyflag, batchrunflag, isuscitizen)
values (gen_random_uuid(), 1, 'Unnamed', 'Unnamed', 0, 'CDM-40754', now(), 'CDM-40754', now(), now(), '1900-01-01 00:00:00', 99, 'U', false,
	false, 2, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0);
	
--Inserting created unknown person into actor 
insert into actor
	(actorid, activeflag, personid, actortype, insertedby, insertedon, updatedby, updatedon, manualupdateflag, intakeserviceid,
	iscollateralcontact, ismentalillness, ismentalimpair, ishouseholdmember, isdangertoworker, sphouseholdmemberflag, spchildflag,
	spreporteranonymousflag, spreporternoletterflag, spexpungementflag, fetalalcoholspctrmdisordflag, drugexposednewbornflag,
	probationsearchconductedflag, sexoffenderregisteredflag, unknownreporterflag, intakenumber)
values (gen_random_uuid(), 1, (select personid from person p where p.insertedby = 'CDM-40754'), 'RA', 'CDM-40754', now(), 'CDM-40754', now(),
	'N', 'b048e37f-8387-46e3-b371-bf33d44faf26', 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'CW2292750');
	
--Inserting created unknown actor into intakeservicerequest as alleged maltreator
update intakeservicerequestactor
set actorid = (select actorid from actor a where a.personid = (select personid from person p where p.insertedby = 'CDM-40754')),
	personid = (select personid from person p where p.insertedby = 'CDM-40754'),
	updatedby = 'CDM-40754', updatedon = now()
where intakeservicerequestactorid = 'f6a03c30-93e7-49fd-b002-14e4b1e4ffbe' and activeflag = 1;


-- Changing exiting Maltreator TOWANDA S CAMPBELL (1600720) to Other Adult
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
VALUES('40c23ac8-f2f1-4e6b-9c38-fbc99723949f'::uuid, 'OtherADULT', NULL, 
	'CDM-40754', now(), 'CDM-40754', now(), NULL, NULL, 'b048e37f-8387-46e3-b371-bf33d44faf26'::uuid, 
	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
	false, false, 1, true, true, 'e2ee3283-a0b8-4b70-8c80-3a31c9e1ebda'::uuid, 'CW2292750',
	NULL, NULL, 1, NULL, NULL, 0, 0, NULL, NULL, NULL, 
	NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 0, NULL, 
	NULL, NULL, NULL, 1, NULL, 0, 0, 1, 0, 0, 
	NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, 
	NULL, 1, 1598860, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
	NULL, NULL, NULL, NULL, 'CW2292750', false, NULL, NULL, NULL, NULL, 0);
	

UPDATE cjams.actor 
	set actortype = 'OtherADULT',
		updatedby = 'CDM-40754', updatedon = now()
	WHERE actorid = '40c23ac8-f2f1-4e6b-9c38-fbc99723949f';








