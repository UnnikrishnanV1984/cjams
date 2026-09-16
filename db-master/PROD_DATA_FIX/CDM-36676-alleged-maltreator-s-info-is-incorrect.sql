/*
    Issue Description: CDM-36676
    Root cause: User requested to replace the client ID # 200943509 (Demetrius Unknown) with client ID# 1633728 (Dimitri Bush) in CPS IR # 221020226856.
    Fix: Datafix provided to replace client Id in corresponding tabs.
    Pull request# for code fix: 
    Reason why no related code fix: 
    Status of the code fix if already submitted and expected prod fix date:
*/

--personid :: '71d0963b-d590-4868-8b52-87f3de6961f6'
select * from person where cjamspid = '1633728';
-- I221010287068 :: c79390d4-e0c8-43f9-b575-4db39393c499
select activeflag,intakeservicerequestactorid,* from intakeservicerequestactor i where intakeserviceid = '39cfaf25-8c2d-4d01-a786-a1396dd263b9';

--Person tab
--Backup
select intakeservicerequestactorid, actorid, intakeservicerequestpersontypekey, insertedon, insertedby, updatedon, updatedby, intakeserviceid, reported, isprimary, personid, intakenumber,servicecaseid from intakeservicerequestactor where 
actorid = '90dba1ae-fc11-4870-9404-5d4b01186d2d'
    and intakeservicerequestpersontypekey = 'AM'
    and activeflag = 1
    and intakeservicerequestactorid = 'b4ef7984-dd2b-450c-8a6e-15991e629cd5';

--Update
update
    intakeservicerequestactor
set
    personid = 'c79390d4-e0c8-43f9-b575-4db39393c499',
    intakeservicerequestpersontypekey='OTH',
    updatedby = 'CDM-36676',
    updatedon = now()
where
    actorid = '90dba1ae-fc11-4870-9404-5d4b01186d2d'
    and intakeservicerequestpersontypekey = 'AM'
    and activeflag = 1
    and intakeservicerequestactorid = 'b4ef7984-dd2b-450c-8a6e-15991e629cd5';

--Summary
-- Backup
select * from Intakeservicerequest where 
intakeserviceid = '39cfaf25-8c2d-4d01-a786-a1396dd263b9' and intakenumber = 'I221010287068';
-- Update
update cjams.Intakeservicerequest 
set narrative = '<p class="ql-align-justify"><strong>This case is being screened in as an IR-Sexual Abuse. The assigned worker is Paula Pierce and Supervisor, Antwan Chambers</strong></p><p class="ql-align-justify"><strong>&nbsp;</strong></p><p class="ql-align-justify"><strong>Casehead: Blessed Apung</strong></p><p class="ql-align-justify"><strong>Address: 2682 Delaney Street, Baltimore, MD 21223</strong></p><p class="ql-align-justify"><strong>Phone: &nbsp;667-383-9011</strong></p><p class="ql-align-justify"><strong>DOB: 05/10/1994</strong></p><p class="ql-align-justify"><strong>SS# 623-74-9124</strong></p><p class="ql-align-justify"><br></p><p class="ql-align-justify"><strong>Child/Alleged Victim: Aniyah Moreno</strong></p><p class="ql-align-justify"><strong>DOB: 09/10/2013</strong></p><p class="ql-align-justify"><strong>&nbsp;</strong></p><p class="ql-align-justify"><strong>&nbsp;</strong></p><p class="ql-align-justify"><strong>Describe the Situation:</strong></p><p class="ql-align-justify"><strong>&nbsp;</strong></p><p class="ql-align-justify"><strong>According to the caller her daughter, Aniyah Moreno disclosed to her mother today that one year ago her friend Teneka Austin’s boyfriend, Dimitri touched her in her private area. According to the caller she had gone to the store with Teneka and left Aniyah with Dimitri. Screener asked Ms. Apung if she knew Dimitri prior to this incident. Ms. Apung responded that she only knew Dimitri as Teneka’s boyfriend. Reportedly, prior to this incident one year ago the child was receiving individual therapy for ‘TRAUMA” (type not disclosed). According to the caller child is receiving individual therapy (no therapist identified) session as we speak. Ms. Apung was able to provide an address and phone contact information for Teneka, 1715 Guilford Ave., Baltimore, MD 21202, 443-826-9188. Screener asked Ms. Apung for Taneka’s DOB, but she indicated she did not know it; however, she has known her for 8 years. No additional information provided during this contact </strong></p><p class="ql-align-justify"><br></p><p><br></p>', updatedby = 'CDM-36677',
updatedon= now()  
where intakeserviceid = '39cfaf25-8c2d-4d01-a786-a1396dd263b9' and intakenumber = 'I221010287068';


-- --SDM tab
-- --Backup
-- --intakeservicerequestsdmid = 'af83939c-643a-4918-8a34-feb6b70668dc'
-- select * from intakeservicerequestsdm where intakeserviceid='39cfaf25-8c2d-4d01-a786-a1396dd263b9';
-- select * from intakeservrequestsdmmaltreatment where intakeservicerequestsdmid = 'af83939c-643a-4918-8a34-feb6b70668dc';
-- select * from intakeservrequestsdmmaltreatment where intakeservicerequestsdmid = '0e3fc8ec-10d0-4bd6-85c8-1b3fbbeec74a';
-- --Update
-- update intakeservrequestsdmmaltreatment set maltreatorsname='DIMITRI BUSH',updatedby = 'CDM-36677',
-- updatedon= now() where sdmmaltreatmentid = '86932c9c-9d56-4ab5-800c-42130f1dda55';

INSERT INTO cjams.personrole
(personroleid, activeflag, personid, ishouseholdmember, iscollateralcontact, drugexposednewbornflag, drugexposedtypekey, otherdrugs, safehavenbabyflag, probationsearchconductedflag, sexoffenderregisteredflag, dangertoself, dangertoselfreason, isdangertoworker, dangertoworkerreason, ismentalillness, mentalillnessdetail, ismentalimpair, mentalimpairdetail, insertedby, insertedon, updatedby, updatedon, intakenumber, intakeserviceid, servicecaseid, etl_userid, etl_load_date)
VALUES('42830ef1-5242-4d6b-8041-47626134c256',1, '71d0963b-d590-4868-8b52-87f3de6961f6', 0, 0, 0, 'null', NULL, 0, 0, 0, 0, '', 0, '', 0, '', 0, '', 'CDM-36676', now(), 'CDM-36676', now(), 'I221010287068', '39cfaf25-8c2d-4d01-a786-a1396dd263b9', NULL, NULL, NULL);

INSERT INTO cjams.personroletype
(personroletypeid,personroleid, roletype, activeflag, isprimary, insertedby, insertedon, updatedby, updatedon )
VALUES('054f7ed6-6ffa-4eb3-a40f-1aae706c7f57','42830ef1-5242-4d6b-8041-47626134c256'::uuid, 'AM', 1, '1',
'CDM-36676', now(), 
'CDM-36676', now()
);

INSERT INTO cjams.actor
(actorid, activeflag, personid, actortype, dangerlevel, dangerreason, insertedby, insertedon, updatedby, updatedon, expirationdate, "timestamp", primarylanguageid, secondarylanguageid, employeetypeid, employeetypename, medicaideligibility, blockgranteligibility, recipientstatus, livingarrangementtypekey, interpreterrequired, guardianname, guardianinfo, ramentalhealth, ramentalretarted, ramentalretartedtype, manualupdateflag, intakeserviceid, iscollateralcontact, old_id, ismentalillness, mentalillnessdetail, ismentalimpair, mentalimpairdetail, ishouseholdmember, isdangertoworker, dangertoworkerreason, sphouseholdmemberflag, spchildflag, spreporteranonymousflag, spreporternoletterflag, spexpungementflag, fetalalcoholspctrmdisordflag, drugexposednewbornflag, probationsearchconductedflag, sexoffenderregisteredflag, otherdrugs, unknownreporterflag, spproviderid, servicecaseid, fk_id, fk_c_id, personroletypeid, drugexposedkey, intakenumber, etl_userid, etl_load_date, objectid, objecttype)
VALUES('f6f93cdb-0200-4111-8acc-3c2f8f5a9873', 1, '71d0963b-d590-4868-8b52-87f3de6961f6', 'AM', NULL, NULL, 'CDM-36676', now(), 'CDM-36676', now(), NULL, NULL, NULL, NULL, NULL, NULL, true, true, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N', '39cfaf25-8c2d-4d01-a786-a1396dd263b9', 0, NULL, 2, '', 2, '', 2, 2, '', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, '054f7ed6-6ffa-4eb3-a40f-1aae706c7f57'::uuid, NULL, 'I221010287068', NULL, NULL, NULL, NULL);

INSERT INTO cjams.intakeservicerequestactor
(intakeservicerequestactorid, actorid, intakeservicerequestpersontypekey, rapersontypekey, insertedby, insertedon, updatedby, updatedon, expirationdate, "timestamp", intakeserviceid, routingaddressid, employeetypeid, employeetypename, medicaideligibility, blockgranteligibility, livingarrangementtypekey, guardianname, guardianinfo, ramentalhealth, ramentalretarted, ramentalretartedtype, refusessn, refusedob, activeflag, reported, isprimary, personid, old_id, ismaltreator, rcprimaryroletypekey, ncpspriorhistoryflag, householdnumber, ssnverifytypekey, rchandicapflag, rchomelessflag, lvgarrangementtypekey, livingprefixtypekey, lvgfirstname, lvgmiddlename, lvglastname, lvgsuffixtypekey, lvgrelationshiptypekey, lvgcomments, rchouseholdflag, rcchildflag, nonparticipatingflag, householdheadflag, rcinsertedon, rcinsertedby, rcupdatedon, rcupdatedby, rcactiveflag, livingwith, rcreporteranonymousflag, rcreporternoletterflag, clientflag, rcexpungementflag, rcdatavalidflag, rcclientmergeid, arclientid, arsummaryid, altrespclientid, participatingchildflag, aractiveflag, screeningpersonid, prexpungementflag, prdatavalidflag, prinsertedby, prupdatedby, practiveflag, referralclientid, caseclientid, crexpungementflag, crdatavalidflag, crinsertedby, crupdatedby, sphouseholdmemberflag, spchildflag, spreporteranonymousflag, spreporternoletterflag, spexpungementflag, fetalalcoholspctrmdisordflag, drugexposednewbornflag, probationsearchconductedflag, sexoffenderregisteredflag, otherdrugs, unknownreporterflag, spproviderid, fk_id, isvictim, servicecaseid, fk_cl_id, intakenumber, isheadofhousehold, etl_userid, etl_load_date, objectid, objecttype)
VALUES('2ad8d78f-66da-48d0-94a0-adecc29c1607', 'f6f93cdb-0200-4111-8acc-3c2f8f5a9873', 'AM', NULL, 'CDM-36676', now(), 'CDM-36676', now(), NULL, NULL, '39cfaf25-8c2d-4d01-a786-a1396dd263b9', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, true, true, '71d0963b-d590-4868-8b52-87f3de6961f6', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'I221010287068', false, NULL, NULL, NULL, NULL);

-- INSERT INTO cjams.intakeservrequestsdmmaltreatment
-- (sdmmaltreatmentid, intakeservicerequestsdmid, maltreatmenttype, maltreatorsname, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, old_id, client_id, etl_userid, etl_load_date)
-- VALUES(gen_random_uuid(), 'af83939c-643a-4918-8a34-feb6b70668dc'::uuid, 'AM', 'DIMITRI BUSH', 1, 'CDM-36676', now(), 'CDM-36676', now(), '2023-02-22 13:05:58.324', NULL, NULL, NULL, NULL);

select * from actorrelationship where intakeservicerequestactorid in ('2ad8d78f-66da-48d0-94a0-adecc29c1607','b4ef7984-dd2b-450c-8a6e-15991e629cd5');

UPDATE cjams.actorrelationship
SET updatedby = 'CDM-36676',updatedon= now(),intakeservicerequestactorid='2ad8d78f-66da-48d0-94a0-adecc29c1607' WHERE actorrelationshipid='b6a39458-6e1a-4077-8064-92a9cfb8c6b5';

-- Contact tab
select activeflag,* from contactparticipant where intakeservicerequestactorid in ('2ad8d78f-66da-48d0-94a0-adecc29c1607','b4ef7984-dd2b-450c-8a6e-15991e629cd5');

UPDATE cjams.contactparticipant
set updatedby = 'CDM-36676',updatedon= now(),intakeservicerequestactorid='2ad8d78f-66da-48d0-94a0-adecc29c1607' WHERE 
intakeservicerequestactorid in ('2ad8d78f-66da-48d0-94a0-adecc29c1607','b4ef7984-dd2b-450c-8a6e-15991e629cd5') and activeflag = 1;

-- Investigation-finding tab
-- select * from investigationallegationmaltreators where intakeservicerequestactorid in ('2ad8d78f-66da-48d0-94a0-adecc29c1607','b4ef7984-dd2b-450c-8a6e-15991e629cd5');
select * from investigationallegationmaltreators WHERE intakeservicerequestactorid in ('2ad8d78f-66da-48d0-94a0-adecc29c1607','b4ef7984-dd2b-450c-8a6e-15991e629cd5') and activeflag=1;

UPDATE cjams.investigationallegationmaltreators
SET intakeservicerequestactorid='2ad8d78f-66da-48d0-94a0-adecc29c1607', updatedby='CDM-36676', updatedon=now()
WHERE intakeservicerequestactorid in ('2ad8d78f-66da-48d0-94a0-adecc29c1607','b4ef7984-dd2b-450c-8a6e-15991e629cd5') and activeflag=1;


UPDATE intakesnapshot
SET jsondata = jsonb_set(jsondata, '{sdm}', jsonb_set(jsondata->'sdm', '{allegedmaltreator}', '[{"maltreatorsname": "DIMITRI BUSH"}]')),
updatedby = 'CDM-36676',
updatedon= now()
where
intakenumber = 'I221010287068' AND activeflag=1;

update intakesnapshot 
set
jsondata = jsonb_set(jsondata, '{persondetails}',
jsonb_set(jsondata->'persondetails', '{Person}',
jsonb_set(jsondata->'persondetails'->'Person', '{0}',
jsonb_set(jsondata->'persondetails'->'Person'->0, '{Lastname}', '"BUSH"')))),
updatedby = 'CDM-36676',
updatedon= now()
where
intakenumber = 'I221010287068' AND activeflag=1;

update intakesnapshot 
set
jsondata = jsonb_set(jsondata, '{persondetails}',
jsonb_set(jsondata->'persondetails', '{Person}',
jsonb_set(jsondata->'persondetails'->'Person', '{0}',
jsonb_set(jsondata->'persondetails'->'Person'->0, '{cjamspid}', '"1633728"')))),
updatedby = 'CDM-36676',
updatedon= now()
where
intakenumber = 'I221010287068' AND activeflag=1;

update intakesnapshot 
set
jsondata = jsonb_set(jsondata, '{persondetails}',
jsonb_set(jsondata->'persondetails', '{Person}',
jsonb_set(jsondata->'persondetails'->'Person', '{0}',
jsonb_set(jsondata->'persondetails'->'Person'->0, '{fullName}', '"DIMITRI BUSH"')))),
updatedby = 'CDM-36676',
updatedon= now()
where
intakenumber = 'I221010287068' AND activeflag=1;

update intakesnapshot 
set
jsondata = jsonb_set(jsondata, '{persondetails}',
jsonb_set(jsondata->'persondetails', '{Person}',
jsonb_set(jsondata->'persondetails'->'Person', '{0}',
jsonb_set(jsondata->'persondetails'->'Person'->0, '{Firstname}', '"DIMITRI"')))),
updatedby = 'CDM-36676',
updatedon= now()
where
intakenumber = 'I221010287068' AND activeflag=1;