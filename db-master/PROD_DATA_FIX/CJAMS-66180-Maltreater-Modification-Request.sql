/*
Issue Description: CJAMS-66180 Maltreater Modification Request
     Category/ Module  : Intake, Investigation
     Root cause: 1. Remove the Alleged Maltreator role against client ID # 1624360 (LAVENIA DAVENPORT).  
                2. Add Baxter Detraffinrid (CJAMs ID # is 2233017 and CIS # is 492038164) as Alleged Maltreator
                1. Remove the Alleged Maltreator role against client ID # 1624360 (LAVENIA DAVENPORT).  
                2. Add Baxter Detraffinrid (CJAMs ID # is 2233017 and CIS # is 492038164) as Alleged Maltreator
     Pull request# for code fix: 
     Reason why no related code fix: 
     Status of the code fix if already submitted and expected prod fix date:0
*/


UPDATE cjams.intakeservicerequestactor
SET activeflag=0, updatedon=now(), updatedby='CJAMS-66180'
WHERE intakeservicerequestactorid='07096823-aada-45b1-a083-5f96b07f49c5'
and intakeservicerequestpersontypekey='AM' and activeflag = 1;



---2. Add Baxter Detraffinrid (CJAMs ID # is 2233017 and CIS # is 492038164) as Alleged Maltreator

insert into actor
	(actorid, activeflag, personid, actortype, insertedby, insertedon, updatedby, updatedon, manualupdateflag, intakeserviceid,
	iscollateralcontact, ismentalillness, ismentalimpair, ishouseholdmember, isdangertoworker, sphouseholdmemberflag, spchildflag,
	spreporteranonymousflag, spreporternoletterflag, spexpungementflag, fetalalcoholspctrmdisordflag, drugexposednewbornflag,
	probationsearchconductedflag, sexoffenderregisteredflag, unknownreporterflag, intakenumber)
values (gen_random_uuid(), 1, '8fcfdfda-2822-435d-b11d-93b89c641b4c', 'AM', 'CJAMS-66180', now(), 'CJAMS-66180', now(),
	'N', '56064ceb-fbe5-4a35-a01f-5ae10914a232', 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'CW2278918');



    INSERT INTO cjams.intakeservicerequestactor
(intakeservicerequestactorid, actorid, intakeservicerequestpersontypekey, rapersontypekey, insertedby, insertedon, updatedby, updatedon, expirationdate, "timestamp", intakeserviceid, routingaddressid, employeetypeid, employeetypename, medicaideligibility, blockgranteligibility, livingarrangementtypekey, guardianname, guardianinfo, ramentalhealth, ramentalretarted, ramentalretartedtype, refusessn, refusedob, activeflag, reported, isprimary, personid, old_id, ismaltreator, rcprimaryroletypekey, ncpspriorhistoryflag, householdnumber, ssnverifytypekey, rchandicapflag, rchomelessflag, lvgarrangementtypekey, livingprefixtypekey, lvgfirstname, lvgmiddlename, lvglastname, lvgsuffixtypekey, lvgrelationshiptypekey, lvgcomments, rchouseholdflag, rcchildflag, nonparticipatingflag, householdheadflag, rcinsertedon, rcinsertedby, rcupdatedon, rcupdatedby, rcactiveflag, livingwith, rcreporteranonymousflag, rcreporternoletterflag, clientflag, rcexpungementflag, rcdatavalidflag, rcclientmergeid, arclientid, arsummaryid, altrespclientid, participatingchildflag, aractiveflag, screeningpersonid, prexpungementflag, prdatavalidflag, prinsertedby, prupdatedby, practiveflag, referralclientid, caseclientid, crexpungementflag, crdatavalidflag, crinsertedby, crupdatedby, sphouseholdmemberflag, spchildflag, spreporteranonymousflag, spreporternoletterflag, spexpungementflag, fetalalcoholspctrmdisordflag, drugexposednewbornflag, probationsearchconductedflag, sexoffenderregisteredflag, otherdrugs, unknownreporterflag, spproviderid, fk_id, isvictim, servicecaseid, fk_cl_id, intakenumber, isheadofhousehold, etl_userid, etl_load_date, objectid, objecttype)
VALUES(gen_random_uuid(), (select actorid from actor where updatedby='CJAMS-66180'), 'AM', NULL, 'CJAMS-66180', now(), 'CJAMS-66180', now(), NULL, NULL, '56064ceb-fbe5-4a35-a01f-5ae10914a232', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, false, 1, false, false, '8fcfdfda-2822-435d-b11d-93b89c641b4c', 'CW2278918', NULL, NULL, 0, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 0, NULL, NULL, NULL, NULL, 1, NULL, 0, 0, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 1, 810793, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2233017', NULL, NULL, NULL, 'CW2278918', false, 'Data Migration', '2020-04-18', NULL, NULL);

	


    INSERT INTO cjams.personrole
(personroleid, activeflag, personid, ishouseholdmember, iscollateralcontact, drugexposednewbornflag, drugexposedtypekey, otherdrugs, safehavenbabyflag, probationsearchconductedflag, sexoffenderregisteredflag, dangertoself, dangertoselfreason, isdangertoworker, dangertoworkerreason, ismentalillness, mentalillnessdetail, ismentalimpair, mentalimpairdetail, insertedby, insertedon, updatedby, updatedon, intakenumber, intakeserviceid, servicecaseid, etl_userid, etl_load_date)
VALUES(gen_random_uuid() ,1, '8fcfdfda-2822-435d-b11d-93b89c641b4c', 1, 0, 0, 'null', NULL, 0, 0, 0, 0, '', 0, '', 0, '', 0, '', 'CJAMS-66180', now(), 'CJAMS-66180', now(), 'CW2278918', '56064ceb-fbe5-4a35-a01f-5ae10914a232', NULL, NULL, NULL);



INSERT INTO cjams.personroletype
(personroletypeid,personroleid, roletype, activeflag, isprimary, insertedby, insertedon, updatedby, updatedon )
VALUES(gen_random_uuid() ,(select personroleid from personrole where updatedby='CJAMS-66180'), 'AM', 1, '1',
'CJAMS-66180', now(), 
'CJAMS-66180', now()
);

