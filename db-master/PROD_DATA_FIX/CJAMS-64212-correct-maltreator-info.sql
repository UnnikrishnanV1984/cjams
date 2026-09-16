/*
Issue: CJAMS-64212 Wrong Person Named as Maltreator
Category/Module: Person / role
Root cause: User incorrectly selected the maltreator information and data fix is needed to correct it.
Fix provided:  Data fix has been done for
             1) Remove the Alleged Maltreator role from TAMMY L BRILL (PID# 1269761)
             2) Add Paul E Lucas (CJAMS PID# 204570089) Person card with role as Alleged Maltreator to CPS IR # CW2082362
             3) Remove the Intake # I261013709496
Data/Code fix ticket#: CJAMS-64212
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User entry error and data fix needed.
*/

INSERT INTO cjams.actor
(actorid, activeflag, personid, actortype, dangerlevel, dangerreason, insertedby, insertedon, updatedby, updatedon, expirationdate, "timestamp", primarylanguageid, secondarylanguageid, employeetypeid, employeetypename, medicaideligibility, blockgranteligibility, recipientstatus, livingarrangementtypekey, interpreterrequired, guardianname, guardianinfo, ramentalhealth, ramentalretarted, ramentalretartedtype, manualupdateflag, intakeserviceid, iscollateralcontact, old_id, ismentalillness, mentalillnessdetail, ismentalimpair, mentalimpairdetail, ishouseholdmember, isdangertoworker, dangertoworkerreason, sphouseholdmemberflag, spchildflag, spreporteranonymousflag, spreporternoletterflag, spexpungementflag, fetalalcoholspctrmdisordflag, drugexposednewbornflag, probationsearchconductedflag, sexoffenderregisteredflag, otherdrugs, unknownreporterflag, spproviderid, servicecaseid, fk_id, fk_c_id, personroletypeid, drugexposedkey, intakenumber, etl_userid, etl_load_date, objectid, objecttype, startdate, enddate, householdswitch)
VALUES(gen_random_uuid(), 1, 'ca9833d9-f765-4e19-9f43-84be53b037fe', 'RA', NULL, NULL, 'CJAMS-64212', now(), 'CJAMS-64212', now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N', '159d45a3-cc08-43dc-ac69-0c8aa6d1d0bc', 0, '1269761', 0, NULL, 0, NULL, 1, 0, ' ', 1, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, NULL, NULL, '1269761', 'CW2082362', NULL, NULL, 'CW2082362', 'Data Migration', '2020-04-18', NULL, NULL, NULL, NULL, NULL);



INSERT INTO cjams.intakeservicerequestactor
(intakeservicerequestactorid, actorid, intakeservicerequestpersontypekey, rapersontypekey, insertedby, insertedon, updatedby, updatedon, expirationdate, "timestamp", intakeserviceid, routingaddressid, employeetypeid, employeetypename, medicaideligibility, blockgranteligibility, livingarrangementtypekey, guardianname, guardianinfo, ramentalhealth, ramentalretarted, ramentalretartedtype, refusessn, refusedob, activeflag, reported, isprimary, personid, old_id, ismaltreator, rcprimaryroletypekey, ncpspriorhistoryflag, householdnumber, ssnverifytypekey, rchandicapflag, rchomelessflag, lvgarrangementtypekey, livingprefixtypekey, lvgfirstname, lvgmiddlename, lvglastname, lvgsuffixtypekey, lvgrelationshiptypekey, lvgcomments, rchouseholdflag, rcchildflag, nonparticipatingflag, householdheadflag, rcinsertedon, rcinsertedby, rcupdatedon, rcupdatedby, rcactiveflag, livingwith, rcreporteranonymousflag, rcreporternoletterflag, clientflag, rcexpungementflag, rcdatavalidflag, rcclientmergeid, arclientid, arsummaryid, altrespclientid, participatingchildflag, aractiveflag, screeningpersonid, prexpungementflag, prdatavalidflag, prinsertedby, prupdatedby, practiveflag, referralclientid, caseclientid, crexpungementflag, crdatavalidflag, crinsertedby, crupdatedby, sphouseholdmemberflag, spchildflag, spreporteranonymousflag, spreporternoletterflag, spexpungementflag, fetalalcoholspctrmdisordflag, drugexposednewbornflag, probationsearchconductedflag, sexoffenderregisteredflag, otherdrugs, unknownreporterflag, spproviderid, fk_id, isvictim, servicecaseid, fk_cl_id, intakenumber, isheadofhousehold, etl_userid, etl_load_date, objectid, objecttype)
VALUES(gen_random_uuid(), (select actorid from actor where updatedby='CJAMS-64212'), 'AM', NULL, 'CJAMS-64212', now(), 'CJAMS-64212', now(), NULL, NULL, '159d45a3-cc08-43dc-ac69-0c8aa6d1d0bc', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, false, 1, true, false, 'ca9833d9-f765-4e19-9f43-84be53b037fe', 'CW2082362', NULL, NULL, 1, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 0, NULL, NULL, NULL, NULL, 1, NULL, 0, 0, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 1, 810793, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1269761', NULL, NULL, NULL, 'CW2082362', false, 'Data Migration', '2020-04-18', NULL, NULL);


INSERT INTO cjams.personrole
(personroleid, activeflag, personid, ishouseholdmember, iscollateralcontact, drugexposednewbornflag, drugexposedtypekey, otherdrugs, safehavenbabyflag, probationsearchconductedflag, sexoffenderregisteredflag, dangertoself, dangertoselfreason, isdangertoworker, dangertoworkerreason, ismentalillness, mentalillnessdetail, ismentalimpair, mentalimpairdetail, insertedby, insertedon, updatedby, updatedon, intakenumber, intakeserviceid, servicecaseid, etl_userid, etl_load_date, islivingalone, livingwithfocusperson, emergencycontact, initialresponse, initialresponseupdatedby, initialresponseupdatedon)
VALUES(gen_random_uuid(), 1, 'ca9833d9-f765-4e19-9f43-84be53b037fe', 1, 0, 0, NULL, NULL, 0, 0, 0, 2, ' ', 2, ' ', 2, NULL, 2, ' ', 'CJAMS-64212', now(), 'CJAMS-64212',now(), 'CW2082362', '159d45a3-cc08-43dc-ac69-0c8aa6d1d0bc', NULL, 'Data Migration', '2020-04-18', NULL, NULL, NULL, NULL, NULL, NULL);


update intakeservicerequestactor
set activeflag = 0,
    updatedby = 'CJAMS-64212',
    updatedon = now()
where intakeservicerequestactorid = 'a3919ccf-8bec-4c11-95b7-a147dbda2ac0'
and activeflag =1;


--Delete intake I261013709496

update intakedastaging
set activeflag=0,
    updatedby = 'CJAMS-64212',
    updatedon = now()
where intakenumber='I261013709496'
and activeflag =1;

update intakedastatus
set activeflag=0,
    updatedby = 'CJAMS-64212',
    updatedon = now()
where intakenumber='I261013709496'
and activeflag =1;

update routing 
set activeflag =0,
    updatedby = 'CJAMS-64212',
    updatedon = now()
where objectid = 'I261013709496'
and activeflag = 1;