/*
   Issue Description: CDM-23328
   Category/ Module  : Prod data fix to case connect
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

INSERT INTO cjams.actor
(actorid, activeflag, personid, actortype, dangerlevel, dangerreason, insertedby, insertedon, updatedby, updatedon, expirationdate, "timestamp", primarylanguageid, secondarylanguageid, employeetypeid, employeetypename, medicaideligibility, blockgranteligibility, recipientstatus, livingarrangementtypekey, interpreterrequired, guardianname, guardianinfo, ramentalhealth, ramentalretarted, ramentalretartedtype, manualupdateflag, intakeserviceid, iscollateralcontact, old_id, ismentalillness, mentalillnessdetail, ismentalimpair, mentalimpairdetail, ishouseholdmember, isdangertoworker, dangertoworkerreason, sphouseholdmemberflag, spchildflag, spreporteranonymousflag, spreporternoletterflag, spexpungementflag, fetalalcoholspctrmdisordflag, drugexposednewbornflag, probationsearchconductedflag, sexoffenderregisteredflag, otherdrugs, unknownreporterflag, spproviderid, servicecaseid, fk_id, fk_c_id, personroletypeid, drugexposedkey, intakenumber, etl_userid, etl_load_date, objectid, objecttype)
VALUES('693961a0-8ed0-45f5-b1f7-171504f2d7ef'::uuid, 1, 'e40dea3a-1d55-46d6-a2da-4cd167956310'::uuid, 'CHILD', NULL, NULL, 'CDM-23328', now(), 'CDM-23328', now(), NULL, NULL, NULL, NULL, NULL, NULL, true, true, true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N', '27edf5f4-362e-4860-b9cf-69ba4a4f89a6'::uuid, 0, NULL, 0, '', 0, '', 1, 0, '', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, '', NULL, NULL, 'a436c73e-fa2e-4454-94dc-34067880ecbd'::uuid, NULL, NULL, 'e6f4100a-986b-4b8b-b100-a0fd6d159f68'::uuid, NULL, 'I221010264225', NULL, NULL, NULL, NULL) on conflict do nothing;

-- 09fb118f-e2f5-4fd8-ab76-5296882718b2
update intakeservicerequestactor set actorid = '693961a0-8ed0-45f5-b1f7-171504f2d7ef', updatedby = 'CDM-23328', updatedon = now()
where intakeservicerequestactorid = '29080435-3ac7-4405-831e-41c027418b87';