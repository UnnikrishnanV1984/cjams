/*
    Issue Description: CDM-36677
    Root cause: User requested to replace the alleged maltreater from CJAMS PID#: 201140045 (Demetrius Wilkes) to CJAMS PID#: 1633728 (DIMITRI BUSH).
    Fix: Datafix provided to replace client Id in corresponding tabs.
    Pull request# for code fix: 
    Reason why no related code fix: 
    Status of the code fix if already submitted and expected prod fix date:
*/

--personid = '71d0963b-d590-4868-8b52-87f3de6961f6'
select * from person where cjamspid = '1633728';

--Person tab
--Backup
select intakeservicerequestactorid, actorid, intakeservicerequestpersontypekey, insertedon, insertedby, updatedon, updatedby, intakeserviceid, reported, isprimary, personid, intakenumber,servicecaseid from intakeservicerequestactor where 
actorid = 'ad90bd08-c6c2-48e3-b11b-abe6b9bc0d05'
    and intakeservicerequestpersontypekey = 'AM'
    and activeflag = 1
    and intakeservicerequestactorid = '76185124-15b2-4a48-9253-6855684fc58d';
	
--UPDATE cjams.intakeservicerequestactor
--SET intakeservicerequestpersontypekey='AM',personid='150cd506-eb19-43cf-bde0-75e7dd310ad5'::uuid, updatedby='a1a0dd48-12f8-4fe0-8d17-15dae74fe2ca', updatedon='2023-02-22 12:59:21.224' 
--where intakeserviceid = '24e9b3a6-4b74-4d01-97c7-19d9a72a233a' and personid = '71d0963b-d590-4868-8b52-87f3de6961f6';personid = '150cd506-eb19-43cf-bde0-75e7dd310ad5';


--Update
update
    intakeservicerequestactor
set
    personid = '150cd506-eb19-43cf-bde0-75e7dd310ad5',
    intakeservicerequestpersontypekey='OTH',
    updatedby = 'CDM-36677',
    updatedon = now()
where
    actorid = 'ad90bd08-c6c2-48e3-b11b-abe6b9bc0d05';


-- UPDATE cjams.actorrelationship
-- SET intakeservicerequestactorid='76185124-15b2-4a48-9253-6855684fc58d', intakeserviceid=NULL, relationshiptypekey='SELF', insertedby='a1a0dd48-12f8-4fe0-8d17-15dae74fe2ca', insertedon='2023-02-22 12:59:21.224', updatedby='a1a0dd48-12f8-4fe0-8d17-15dae74fe2ca', updatedon='2023-02-22 12:59:21.224', "timestamp"=NULL, effectivedate='2023-02-22 12:59:21.224', expirationdate=NULL, activeflag=1, intakeservicerequestactorid='76185124-15b2-4a48-9253-6855684fc58d', old_id=NULL, client1id=NULL, client2id=NULL, caregiverflag=NULL, paternityestdflag=NULL, paternityestddate=NULL, paternitycourtorderflag=NULL, maternityestdflag=NULL, maternityestddate=NULL, maternitycourtorderflag=NULL, "comments"=NULL, startdate=NULL, enddate=NULL, sysgenflag=NULL, origclientid=NULL, caseid=NULL, referralid=NULL, expungementflag=NULL, datavalidflag=NULL, clientmergeid=NULL, fk1_id=NULL, fk2_id=NULL, fk3_id=NULL, person1id=NULL, person2id=NULL, servicecaseid=NULL, intakeserviceid=NULL, intakenumber='I231010498630', etl_userid=NULL, etl_load_date=NULL
-- WHERE actorrelationshipid='89dc5936-2bd4-4de4-826a-0bb8a113ba33';

-- 46c95e4b-16aa-4d27-9b1b-abba8cfc5621

--Summary
-- Backup
select * from Intakeservicerequest where 
intakeserviceid = '24e9b3a6-4b74-4d01-97c7-19d9a72a233a' and intakenumber = 'I231010498630';
-- Update
update cjams.Intakeservicerequest 
set narrative = '<p class="ql-align-justify">This case has been accepted as a CPS Investigative Response case for allegations of sexual abuse.&nbsp;&nbsp;This case has been assigned to CPS Worker, Deion Copeland and Supervisor, Antwan Chambers in Division #3.&nbsp;</p><p class="ql-align-justify">&nbsp;</p><p class="ql-align-justify"><strong><u>Casehead</u></strong>:&nbsp;</p><p class="ql-align-justify">Name:&nbsp;Linda Anderson, Maternal Grandmother, Caregiver</p><p class="ql-align-justify">DOB:&nbsp;9/14-1966</p><p class="ql-align-justify">Address: current: 509 Woodfin Road, Newport New, VA 23601, new address: March 29, 2023 is </p><p class="ql-align-justify">4235 Seideel Avenue, Baltimore, MD 21206</p><p class="ql-align-justify">Phone:&nbsp;443-726-8601, 443-769-3656</p><p class="ql-align-justify">Race:&nbsp;AA</p><p class="ql-align-justify"><strong><u>&nbsp;</u></strong></p><p class="ql-align-justify">Name:&nbsp;Teneka Gordon, Biological Mother</p><p class="ql-align-justify">DOB:&nbsp;7/11/1990</p><p class="ql-align-justify">Address: 1715 Guildford Avenue, Baltimore, MD 21218</p><p class="ql-align-justify">Phone: Ms. Anderson has mother’s number</p><p class="ql-align-justify">Race:&nbsp;AA</p><p class="ql-align-justify"><strong><u>&nbsp;</u></strong></p><p class="ql-align-justify">Name:&nbsp;Dimitri Bush, Mother’s Boyfriend (Det. Looking for him in State of MD,)</p><p class="ql-align-justify">DOB:&nbsp;April 17,19xx, age 30-35, light skin, hazel eyes, height 5.6 to 5.8, Tatoo on neck</p><p class="ql-align-justify">Address: 1715 Guildford Avenue, Baltimore, MD 21218</p><p class="ql-align-justify">Phone:&nbsp;Unknown</p><p class="ql-align-justify">Race:&nbsp;AA</p><p class="ql-align-justify"><strong><u>&nbsp;</u></strong></p><p class="ql-align-justify"><strong><u>Alleged Victim Child(ren)</u></strong>:</p><p class="ql-align-justify">Kishai L. Gordon, DOB:&nbsp;11/22/2010, age 12, female, AA, Grade </p><p class="ql-align-justify"><strong>&nbsp;</strong></p><p class="ql-align-justify"><strong><u>Other Child:</u></strong></p><p class="ql-align-justify">Kyree Millner, DOB:&nbsp;4/28/14, male </p><p class="ql-align-justify">Kevin Millner, DOB:&nbsp;2/15/2013, male</p><p class="ql-align-justify">&nbsp;</p><p class="ql-align-justify"><strong><u>Describe the Situation:&nbsp;</u></strong></p><p class="ql-align-justify">The caller explained, Kishai Gordon and her siblings (Kyree Millner, DOB:&nbsp;4/28/14 &amp; Kevin Millner, DOB:&nbsp;2/15/2013) visited their mother, Ms. Teneka Gordon at 1715 Guildford Avenue, Baltimore, MD 21218 at least 3 times in 2022. During the children’s visits, Mr. Dimitri Bush mother’s boyfriend and alleged maltreator had access to the children.&nbsp;&nbsp;&nbsp;</p><p class="ql-align-justify">&nbsp;</p><p class="ql-align-justify">Today, Kishai disclosed to the caller that Mr. Bush would licked her on the legs, stomach and her genital area during visits at her mother’s home.&nbsp;Kishai disclosed that Mr. Bush told her that he would kill her mother if Kishai told anybody about their sexual in counter(s).&nbsp;&nbsp;</p><p class="ql-align-justify">&nbsp;</p><p class="ql-align-justify">Note:&nbsp;Kishai and her 2 brothers were removed from their mother, Ms. Gordon and now live with their grandmother Ms. Linda Anderson.</p><p class="ql-align-justify">&nbsp;</p><p class="ql-align-justify">This writer was informed, that Mr. Bush has a warrant for his arrest for touching another friend’s daughter and that Detective Price of BCAC is investigating this incident.&nbsp;Mr. Bush allegedly was locked up for a year but released this past June 2022.</p><p class="ql-align-justify">&nbsp;</p><p class="ql-align-justify"><br></p>', updatedby = 'CDM-36677',
updatedon= now()  
where intakeserviceid = '24e9b3a6-4b74-4d01-97c7-19d9a72a233a' and intakenumber = 'I231010498630';

--SDM tab
--Backup
select * from intakeservrequestsdmmaltreatment where intakeservicerequestsdmid = '0e3fc8ec-10d0-4bd6-85c8-1b3fbbeec74a';
--Update
update intakeservrequestsdmmaltreatment set maltreatorsname='DIMITRI BUSH',updatedby = 'CDM-36677',
updatedon= now() where sdmmaltreatmentid = '86932c9c-9d56-4ab5-800c-42130f1dda55';

-- Person tab
INSERT INTO cjams.personrole
(personroleid, activeflag, personid, ishouseholdmember, iscollateralcontact, drugexposednewbornflag, drugexposedtypekey, otherdrugs, safehavenbabyflag, probationsearchconductedflag, sexoffenderregisteredflag, dangertoself, dangertoselfreason, isdangertoworker, dangertoworkerreason, ismentalillness, mentalillnessdetail, ismentalimpair, mentalimpairdetail, insertedby, insertedon, updatedby, updatedon, intakenumber, intakeserviceid, servicecaseid, etl_userid, etl_load_date)
VALUES('dc0c4b9f-443a-4a33-8017-6c2dd559e5d2'::uuid,1, '71d0963b-d590-4868-8b52-87f3de6961f6', 0, 0, 0, 'null', NULL, 0, 0, 0, 0, '', 0, '', 0, '', 0, '', 'CDM-36677', now(), 'CDM-36677', now(), 'I231010498630', '24e9b3a6-4b74-4d01-97c7-19d9a72a233a', NULL, NULL, NULL);

INSERT INTO cjams.personroletype
(personroletypeid,personroleid, roletype, activeflag, isprimary, insertedby, insertedon, updatedby, updatedon )
VALUES('1dd0a89e-e0df-4fac-86f4-0e51b289754e','dc0c4b9f-443a-4a33-8017-6c2dd559e5d2'::uuid, 'AM', 1, '1',
'CDM-36677', now(), 
'CDM-36677', now()
);

INSERT INTO cjams.actor
(actorid, activeflag, personid, actortype, dangerlevel, dangerreason, insertedby, insertedon, updatedby, updatedon, expirationdate, "timestamp", primarylanguageid, secondarylanguageid, employeetypeid, employeetypename, medicaideligibility, blockgranteligibility, recipientstatus, livingarrangementtypekey, interpreterrequired, guardianname, guardianinfo, ramentalhealth, ramentalretarted, ramentalretartedtype, manualupdateflag, intakeserviceid, iscollateralcontact, old_id, ismentalillness, mentalillnessdetail, ismentalimpair, mentalimpairdetail, ishouseholdmember, isdangertoworker, dangertoworkerreason, sphouseholdmemberflag, spchildflag, spreporteranonymousflag, spreporternoletterflag, spexpungementflag, fetalalcoholspctrmdisordflag, drugexposednewbornflag, probationsearchconductedflag, sexoffenderregisteredflag, otherdrugs, unknownreporterflag, spproviderid, servicecaseid, fk_id, fk_c_id, personroletypeid, drugexposedkey, intakenumber, etl_userid, etl_load_date, objectid, objecttype)
VALUES('8d798021-2ad0-428a-a984-dbccce431b0b'::uuid, 1, '71d0963b-d590-4868-8b52-87f3de6961f6', 'AM', NULL, NULL, 'CDM-36677', now(), 'CDM-36677', now(), NULL, NULL, NULL, NULL, NULL, NULL, true, true, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N', '24e9b3a6-4b74-4d01-97c7-19d9a72a233a', 0, NULL, 2, '', 2, '', 2, 2, '', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, '1dd0a89e-e0df-4fac-86f4-0e51b289754e'::uuid, NULL, 'I231010498630', NULL, NULL, NULL, NULL);

INSERT INTO cjams.intakeservicerequestactor
(intakeservicerequestactorid, actorid, intakeservicerequestpersontypekey, rapersontypekey, insertedby, insertedon, updatedby, updatedon, expirationdate, "timestamp", intakeserviceid, routingaddressid, employeetypeid, employeetypename, medicaideligibility, blockgranteligibility, livingarrangementtypekey, guardianname, guardianinfo, ramentalhealth, ramentalretarted, ramentalretartedtype, refusessn, refusedob, activeflag, reported, isprimary, personid, old_id, ismaltreator, rcprimaryroletypekey, ncpspriorhistoryflag, householdnumber, ssnverifytypekey, rchandicapflag, rchomelessflag, lvgarrangementtypekey, livingprefixtypekey, lvgfirstname, lvgmiddlename, lvglastname, lvgsuffixtypekey, lvgrelationshiptypekey, lvgcomments, rchouseholdflag, rcchildflag, nonparticipatingflag, householdheadflag, rcinsertedon, rcinsertedby, rcupdatedon, rcupdatedby, rcactiveflag, livingwith, rcreporteranonymousflag, rcreporternoletterflag, clientflag, rcexpungementflag, rcdatavalidflag, rcclientmergeid, arclientid, arsummaryid, altrespclientid, participatingchildflag, aractiveflag, screeningpersonid, prexpungementflag, prdatavalidflag, prinsertedby, prupdatedby, practiveflag, referralclientid, caseclientid, crexpungementflag, crdatavalidflag, crinsertedby, crupdatedby, sphouseholdmemberflag, spchildflag, spreporteranonymousflag, spreporternoletterflag, spexpungementflag, fetalalcoholspctrmdisordflag, drugexposednewbornflag, probationsearchconductedflag, sexoffenderregisteredflag, otherdrugs, unknownreporterflag, spproviderid, fk_id, isvictim, servicecaseid, fk_cl_id, intakenumber, isheadofhousehold, etl_userid, etl_load_date, objectid, objecttype)
VALUES('46c95e4b-16aa-4d27-9b1b-abba8cfc5621', '8d798021-2ad0-428a-a984-dbccce431b0b', 'AM', NULL, 'CDM-36677', now(), 'CDM-36677', now(), NULL, NULL, '24e9b3a6-4b74-4d01-97c7-19d9a72a233a', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, true, true, '71d0963b-d590-4868-8b52-87f3de6961f6', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'I231010498630', false, NULL, NULL, NULL, NULL);


select * from actorrelationship where intakeservicerequestactorid in ('46c95e4b-16aa-4d27-9b1b-abba8cfc5621','76185124-15b2-4a48-9253-6855684fc58d');
-- -- UPDATE cjams.actorrelationship
-- -- SET relationshiptypekey='SELF', insertedby='a1a0dd48-12f8-4fe0-8d17-15dae74fe2ca', insertedon='2023-02-22 12:59:21.224', updatedby='a1a0dd48-12f8-4fe0-8d17-15dae74fe2ca', updatedon='2023-02-22 12:59:21.224', "timestamp"=NULL, effectivedate='2023-02-22 12:59:21.224', expirationdate=NULL, activeflag=1, intakeservicerequestactorid='76185124-15b2-4a48-9253-6855684fc58d', old_id=NULL, client1id=NULL, client2id=NULL, caregiverflag=NULL, paternityestdflag=NULL, paternityestddate=NULL, paternitycourtorderflag=NULL, maternityestdflag=NULL, maternityestddate=NULL, maternitycourtorderflag=NULL, "comments"=NULL, startdate=NULL, enddate=NULL, sysgenflag=NULL, origclientid=NULL, caseid=NULL, referralid=NULL, expungementflag=NULL, datavalidflag=NULL, clientmergeid=NULL, fk1_id=NULL, fk2_id=NULL, fk3_id=NULL, person1id=NULL, person2id=NULL, servicecaseid=NULL, intakeserviceid=NULL, intakenumber='I231010498630', etl_userid=NULL, etl_load_date=NULL
-- -- WHERE actorrelationshipid='89dc5936-2bd4-4de4-826a-0bb8a113ba33';

UPDATE cjams.actorrelationship
SET updatedby = 'CDM-36677',updatedon= now(),intakeservicerequestactorid='46c95e4b-16aa-4d27-9b1b-abba8cfc5621' WHERE actorrelationshipid='89dc5936-2bd4-4de4-826a-0bb8a113ba33';


-- Contact tab
select activeflag,* from contactparticipant where intakeservicerequestactorid in ('46c95e4b-16aa-4d27-9b1b-abba8cfc5621','76185124-15b2-4a48-9253-6855684fc58d');

-- UPDATE cjams.contactparticipant
-- SET activeflag=0, progressnoteid='9806f9ca-b015-4aa2-9769-09b91ca5408b', participanttypekey='IP', intakeservicerequestactorid='76185124-15b2-4a48-9253-6855684fc58d', firstname=NULL, lastname=NULL, address1=NULL, address2=NULL, city=NULL, state=NULL, zipcode=NULL, email=NULL, phonenumber=NULL, activeflag=0, effectivedate='2023-06-05 10:24:21.526', insertedby='cf98ac59-7642-4719-9c9d-48a20496ff49', insertedon='2023-06-05 10:24:21.526', updatedby='cf98ac59-7642-4719-9c9d-48a20496ff49', updatedon='2023-06-05 10:24:21.526', old_id=NULL, participantid='76185124-15b2-4a48-9253-6855684fc58d', etl_userid=NULL, etl_load_date=NULL
-- WHERE contactparticipantid='6c402394-3671-4f29-82b2-be905b2c938a';
-- UPDATE cjams.contactparticipant
-- SET activeflag=1, progressnoteid='9806f9ca-b015-4aa2-9769-09b91ca5408b', participanttypekey='IP', intakeservicerequestactorid='76185124-15b2-4a48-9253-6855684fc58d', firstname=NULL, lastname=NULL, address1=NULL, address2=NULL, city=NULL, state=NULL, zipcode=NULL, email=NULL, phonenumber=NULL, activeflag=1, effectivedate='2023-06-05 10:24:43.466', insertedby='cf98ac59-7642-4719-9c9d-48a20496ff49', insertedon='2023-06-05 10:24:43.466', updatedby='cf98ac59-7642-4719-9c9d-48a20496ff49', updatedon='2023-06-05 10:24:43.466', old_id=NULL, participantid='76185124-15b2-4a48-9253-6855684fc58d', etl_userid=NULL, etl_load_date=NULL
-- WHERE contactparticipantid='2b32f0e3-59bb-480f-a6b8-85d188aad8c0';
-- UPDATE cjams.contactparticipant
-- SET activeflag=0, progressnoteid='49276d32-1aa8-42e7-8f10-c2e4e19baf6a', participanttypekey='IP', intakeservicerequestactorid='76185124-15b2-4a48-9253-6855684fc58d', firstname=NULL, lastname=NULL, address1=NULL, address2=NULL, city=NULL, state=NULL, zipcode=NULL, email=NULL, phonenumber=NULL, activeflag=0, effectivedate='2023-06-09 20:06:23.017', insertedby='cf98ac59-7642-4719-9c9d-48a20496ff49', insertedon='2023-06-09 20:06:23.017', updatedby='cf98ac59-7642-4719-9c9d-48a20496ff49', updatedon='2023-06-09 20:06:23.017', old_id=NULL, participantid='76185124-15b2-4a48-9253-6855684fc58d', etl_userid=NULL, etl_load_date=NULL
-- WHERE contactparticipantid='b0dbb5da-4c54-429d-8acf-98338842e30d';
-- UPDATE cjams.contactparticipant
-- SET activeflag=1, progressnoteid='49276d32-1aa8-42e7-8f10-c2e4e19baf6a', participanttypekey='IP', intakeservicerequestactorid='76185124-15b2-4a48-9253-6855684fc58d', firstname=NULL, lastname=NULL, address1=NULL, address2=NULL, city=NULL, state=NULL, zipcode=NULL, email=NULL, phonenumber=NULL, activeflag=1, effectivedate='2023-06-09 20:06:26.221', insertedby='cf98ac59-7642-4719-9c9d-48a20496ff49', insertedon='2023-06-09 20:06:26.221', updatedby='cf98ac59-7642-4719-9c9d-48a20496ff49', updatedon='2023-06-09 20:06:26.221', old_id=NULL, participantid='76185124-15b2-4a48-9253-6855684fc58d', etl_userid=NULL, etl_load_date=NULL
-- WHERE contactparticipantid='04689fd2-314f-4b0a-ab0b-3f9398057e50';

UPDATE cjams.contactparticipant
set updatedby = 'CDM-36677',updatedon= now(),intakeservicerequestactorid='46c95e4b-16aa-4d27-9b1b-abba8cfc5621' WHERE 
intakeservicerequestactorid in ('46c95e4b-16aa-4d27-9b1b-abba8cfc5621','76185124-15b2-4a48-9253-6855684fc58d') and activeflag = 1;


-- Investigation-finding tab
-- select * from investigationallegationmaltreators where intakeservicerequestactorid in ('46c95e4b-16aa-4d27-9b1b-abba8cfc5621','76185124-15b2-4a48-9253-6855684fc58d');
select * from investigationallegationmaltreators WHERE investigationallegationmaltreatorsid='d128d8a9-8f97-43ea-9e01-2a27d7346d0e' and investigationallegationid='d830ddec-4d2c-488f-a147-f770adf5e610' and activeflag=1;
UPDATE cjams.investigationallegationmaltreators
SET intakeservicerequestactorid='46c95e4b-16aa-4d27-9b1b-abba8cfc5621', updatedby='CDM-34944', updatedon=now()
WHERE investigationallegationmaltreatorsid='d128d8a9-8f97-43ea-9e01-2a27d7346d0e' and investigationallegationid='d830ddec-4d2c-488f-a147-f770adf5e610' and activeflag=1;

--Contact tab
update intakesnapshot 
set
jsondata = replace(jsondata :: text , '"maltreatorsname": " Demetrius  Wilkes "', '"maltreatorsname": "DIMITRI BUSH"')::json,
updatedby = 'CDM-36677',
updatedon= now()
where
intakenumber = 'I231010498630' AND activeflag=1;

update intakesnapshot 
set
jsondata = jsonb_set(jsondata, '{persondetails}',
jsonb_set(jsondata->'persondetails', '{Person}',
jsonb_set(jsondata->'persondetails'->'Person', '{0}',
jsonb_set(jsondata->'persondetails'->'Person'->0, '{Lastname}', '"BUSH"')))),
updatedby = 'CDM-36677',
updatedon= now()
where
intakenumber = 'I231010498630' AND activeflag=1;

update intakesnapshot 
set
jsondata = jsonb_set(jsondata, '{persondetails}',
jsonb_set(jsondata->'persondetails', '{Person}',
jsonb_set(jsondata->'persondetails'->'Person', '{0}',
jsonb_set(jsondata->'persondetails'->'Person'->0, '{cjamspid}', '"1633728"')))),
updatedby = 'CDM-36677',
updatedon= now()
where
intakenumber = 'I231010498630' AND activeflag=1;

update intakesnapshot 
set
jsondata = jsonb_set(jsondata, '{persondetails}',
jsonb_set(jsondata->'persondetails', '{Person}',
jsonb_set(jsondata->'persondetails'->'Person', '{0}',
jsonb_set(jsondata->'persondetails'->'Person'->0, '{fullName}', '"DIMITRI BUSH"')))),
updatedby = 'CDM-36677',
updatedon= now()
where
intakenumber = 'I231010498630' AND activeflag=1;

update intakesnapshot 
set
jsondata = jsonb_set(jsondata, '{persondetails}',
jsonb_set(jsondata->'persondetails', '{Person}',
jsonb_set(jsondata->'persondetails'->'Person', '{0}',
jsonb_set(jsondata->'persondetails'->'Person'->0, '{Firstname}', '"DIMITRI"')))),
updatedby = 'CDM-36677',
updatedon= now()
where
intakenumber = 'I231010498630' AND activeflag=1;