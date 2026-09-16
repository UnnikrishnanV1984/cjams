
/*
Issue Description: Child Profile Disappeared from Investigation
Category/Module: Person: household
Root cause: User requested to insert new child record in to DB.
Fix provided: Data fix done to Insert new child record in to DB.
Data/Code fix ticket#: CJAMS-67379
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
*/

-- To add in the intakenumber = 'I261014011708'
update actor set intakenumber = 'I261014011708', updatedby = 'CJAMS-67379', updatedon = now()
where actorid  = '1ef10f6b-8cf3-4f64-a280-9718338f4928'
    and activeflag  = 1;

update intakeservicerequestactor set intakenumber = 'I261014011708', updatedby = 'CJAMS-67379', updatedon = now()
where actorid  = '1ef10f6b-8cf3-4f64-a280-9718338f4928'
    and activeflag  = 1;


-- To add in CPS IR    99a05412-714c-4ea0-8a85-4c48923389b5    261023742370
INSERT INTO cjams.actor
(actorid, activeflag, personid, actortype, dangerlevel, dangerreason, insertedby, insertedon, updatedby, updatedon, expirationdate, "timestamp", primarylanguageid, secondarylanguageid, employeetypeid, employeetypename, medicaideligibility, blockgranteligibility, recipientstatus, livingarrangementtypekey, interpreterrequired, guardianname, guardianinfo, ramentalhealth, ramentalretarted, ramentalretartedtype, manualupdateflag, intakeserviceid, iscollateralcontact, old_id, ismentalillness, mentalillnessdetail, ismentalimpair, mentalimpairdetail, ishouseholdmember, isdangertoworker, dangertoworkerreason, sphouseholdmemberflag, spchildflag, spreporteranonymousflag, spreporternoletterflag, spexpungementflag, fetalalcoholspctrmdisordflag, drugexposednewbornflag, probationsearchconductedflag, sexoffenderregisteredflag, otherdrugs, unknownreporterflag, spproviderid, servicecaseid, fk_id, fk_c_id, personroletypeid, drugexposedkey, intakenumber, etl_userid, etl_load_date, objectid, objecttype, startdate, enddate, householdswitch, isexpunged)
VALUES(cjams.gen_random_uuid(), 1, '0644c94d-6f2e-4c75-90f2-ba072c34faa6'::uuid, 'CHILD', NULL, NULL, 'CJAMS-67379', now(), 'CJAMS-67379', now(), NULL, NULL, NULL, NULL, NULL, NULL, true, true, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N', '99a05412-714c-4ea0-8a85-4c48923389b5'::uuid, 0, NULL, 0, '', 0, '', 1, 0, '', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, '', NULL, NULL, NULL, NULL, NULL, 'f7f2c96f-3687-4ec7-a678-9da8f2111f6a'::uuid, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0);

INSERT INTO cjams.intakeservicerequestactor
(intakeservicerequestactorid, actorid, intakeservicerequestpersontypekey, rapersontypekey, insertedby, insertedon, updatedby, updatedon, 
expirationdate, "timestamp", intakeserviceid, routingaddressid, employeetypeid, employeetypename, medicaideligibility, blockgranteligibility,
livingarrangementtypekey, guardianname, guardianinfo, ramentalhealth, ramentalretarted, ramentalretartedtype, refusessn, refusedob, activeflag, 
reported, isprimary, personid, old_id, ismaltreator, rcprimaryroletypekey, ncpspriorhistoryflag, householdnumber, ssnverifytypekey, 
rchandicapflag, rchomelessflag, lvgarrangementtypekey, livingprefixtypekey, lvgfirstname, lvgmiddlename, lvglastname, lvgsuffixtypekey, 
lvgrelationshiptypekey, lvgcomments, rchouseholdflag, rcchildflag, nonparticipatingflag, householdheadflag, rcinsertedon, rcinsertedby,
rcupdatedon, rcupdatedby, rcactiveflag, livingwith, rcreporteranonymousflag, rcreporternoletterflag, clientflag, rcexpungementflag, 
rcdatavalidflag, rcclientmergeid, arclientid, arsummaryid, altrespclientid, participatingchildflag, aractiveflag, screeningpersonid, 
prexpungementflag, prdatavalidflag, prinsertedby, prupdatedby, practiveflag, referralclientid, caseclientid, crexpungementflag, 
crdatavalidflag, crinsertedby, crupdatedby, sphouseholdmemberflag, spchildflag, spreporteranonymousflag, spreporternoletterflag, 
spexpungementflag, fetalalcoholspctrmdisordflag, drugexposednewbornflag, probationsearchconductedflag, sexoffenderregisteredflag, otherdrugs, 
unknownreporterflag, spproviderid, fk_id, isvictim, servicecaseid, fk_cl_id, intakenumber, isheadofhousehold, etl_userid, etl_load_date, objectid, objecttype, isexpunged)
VALUES(cjams.gen_random_uuid(),
(select actorid from cjams.actor where insertedby= 'CJAMS-67379' and personid  = '0644c94d-6f2e-4c75-90f2-ba072c34faa6'),
'CHILD', NULL, 'CJAMS-67379', now(), 'CJAMS-67379', now(), NULL, NULL, '99a05412-714c-4ea0-8a85-4c48923389b5'::uuid, 
NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, true, true, '0644c94d-6f2e-4c75-90f2-ba072c34faa6'::uuid, 
NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, 
NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, NULL, NULL, NULL, NULL, 0);