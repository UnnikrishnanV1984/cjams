/*
  Issue Description:CDM-41217
    Category/ Module:Person
    Root cause: Person Is Missing from Persons Card, might be due to migration issue or case connect issue after live. Case connect happended in 4/2021
    Pull request# for code fix:
    Reason why no related code fix: 
    Status of the code fix if already submitted and expected prod fix date:
    Backup before update/ delete: 
*/

INSERT INTO cjams.actor
(actorid, activeflag, personid, actortype, dangerlevel, dangerreason, insertedby, insertedon, updatedby, updatedon, expirationdate, "timestamp", primarylanguageid, secondarylanguageid, employeetypeid, employeetypename, medicaideligibility, blockgranteligibility, recipientstatus, livingarrangementtypekey, interpreterrequired, guardianname, guardianinfo, ramentalhealth, ramentalretarted, ramentalretartedtype, manualupdateflag, intakeserviceid, iscollateralcontact, old_id, ismentalillness, mentalillnessdetail, ismentalimpair, mentalimpairdetail, ishouseholdmember, isdangertoworker, dangertoworkerreason, sphouseholdmemberflag, spchildflag, spreporteranonymousflag, spreporternoletterflag, spexpungementflag, fetalalcoholspctrmdisordflag, drugexposednewbornflag, probationsearchconductedflag, sexoffenderregisteredflag, otherdrugs, unknownreporterflag, spproviderid, servicecaseid, fk_id, fk_c_id, personroletypeid, drugexposedkey, intakenumber, etl_userid, etl_load_date, objectid, objecttype)
VALUES('7b343c30-baf3-4a4c-acb0-462bc86a1acc', 1, 'd520b1c4-07f1-4e5f-ab29-428e8c28950a', 'CHILD', NULL, NULL, 'CDM-41217 ', now(), 'CDM-41217', now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N', NULL, 0, null, 0, NULL, 0, NULL, 1, 0, ' ', 1, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, '5dc062ff-ea8c-4cc4-9519-8551ff8073bf', null, '3239339', NULL, NULL, '3239339', null, null, NULL, NULL);

UPDATE cjams.intakeservicerequestactor
SET actorid='7b343c30-baf3-4a4c-acb0-462bc86a1acc', updatedby='CDM-41217', updatedon=now()
WHERE intakeservicerequestactorid in ('203db19b-1bf3-4fae-8993-dbe488dd28f4','3c3c00c4-4649-4bee-b344-8f3412e17c74');

INSERT INTO cjams.personrole
(personroleid, activeflag, personid, ishouseholdmember, iscollateralcontact, drugexposednewbornflag, drugexposedtypekey, otherdrugs, safehavenbabyflag, probationsearchconductedflag, sexoffenderregisteredflag, dangertoself, dangertoselfreason, isdangertoworker, dangertoworkerreason, ismentalillness, mentalillnessdetail, ismentalimpair, mentalimpairdetail, insertedby, insertedon, updatedby, updatedon, intakenumber, intakeserviceid, servicecaseid, etl_userid, etl_load_date, islivingalone, livingwithfocusperson, emergencycontact, initialresponse, initialresponseupdatedby, initialresponseupdatedon)
VALUES('c1272b45-7fb8-4e72-9c51-f9f8ab3aaedc', 1, 'd520b1c4-07f1-4e5f-ab29-428e8c28950a', 1, 0, 0, '""', '', 0, 0, 0, 2, '', 2, '', 2, '', 2, '', 'CDM-41217', now(), 'CDM-41217', now(), 'I202100350027', '34280d4d-65e0-4e13-a74b-4f961d7e0898','330905b4-3c20-4606-bbd4-00c112dc6cd3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);




