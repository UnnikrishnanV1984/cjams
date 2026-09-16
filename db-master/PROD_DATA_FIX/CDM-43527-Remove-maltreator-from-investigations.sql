/*
-- Issue Description: CDM-43527-
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: Please expunge remove the alleged maltreator role from CJAMS PID #1033414 for CPS-IR #CW2023683 and CPS-IR #CW2135703. Please make the Alleged Maltreator an unknown person for these investigations
-- Fix Provided: Datafix has been promoted to update expunge the cases.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

INSERT INTO cjams.person
(personid, activeflag, principalident, firstname, lastname, middlename, salutation, suffix, dangerlevel, dangerreason, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id, "timestamp", dob, religiontypekey, maritalstatustypekey, gendertypekey)
VALUES(gen_random_uuid() , 1, NULL, 'Unknown', 'Unknown', '', NULL, '', NULL, NULL, 'CDM43527', now(), 'CDM43527', now(), now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.actor
(actorid, activeflag, personid, actortype, dangerlevel, dangerreason, insertedby, insertedon, updatedby, updatedon, expirationdate, "timestamp", primarylanguageid, secondarylanguageid, employeetypeid, employeetypename, medicaideligibility, blockgranteligibility, recipientstatus, livingarrangementtypekey, interpreterrequired, guardianname, guardianinfo, ramentalhealth, ramentalretarted, ramentalretartedtype, manualupdateflag, intakeserviceid, iscollateralcontact, old_id, ismentalillness, mentalillnessdetail, ismentalimpair, mentalimpairdetail, ishouseholdmember, isdangertoworker, dangertoworkerreason, sphouseholdmemberflag, spchildflag, spreporteranonymousflag, spreporternoletterflag, spexpungementflag, fetalalcoholspctrmdisordflag, drugexposednewbornflag, probationsearchconductedflag, sexoffenderregisteredflag, otherdrugs, unknownreporterflag, spproviderid, servicecaseid, fk_id, fk_c_id, personroletypeid, drugexposedkey, intakenumber, etl_userid, etl_load_date, objectid, objecttype, startdate, enddate)
VALUES(gen_random_uuid() , 1,   (select personid from person where insertedby = 'CDM43527' limit 1) , 'AM', NULL, NULL,  'CDM43527', now(),  'CDM43527',now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N', '49fd91d8-dea4-4f8d-902b-6e4b5a95fbba'::uuid, 0, '1033414', 0, NULL, 0, NULL, 1, 0, ' ', 1, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, NULL, NULL, '1033414', 'CW2023683', NULL, NULL, 'CW2023683', 'Data Migration', now(), NULL, NULL, NULL, NULL);


update intakeservicerequestactor
set actorid = (select actorid from actor where personid = (select personid from person where insertedby = 'CDM43527' limit 1) limit 1),
	personid = (select personid from person where insertedby = 'CDM43527' limit 1),
	updatedby = 'CDM43527', updatedon = now()
where intakeservicerequestactorid = 'c71b6e9a-31e0-4def-a52a-0f2c50e9ea3c' and activeflag = 1 and intakenumber = 'CW2023683';




INSERT INTO cjams.person
(personid, activeflag, principalident, firstname, lastname, middlename, salutation, suffix, dangerlevel, dangerreason, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id, "timestamp", dob, religiontypekey, maritalstatustypekey, gendertypekey)
VALUES(gen_random_uuid() , 1, NULL, 'Unknown', 'Unknown', '', NULL, '', NULL, NULL, 'CDM-43527', now(), 'CDM-43527', now(), now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.actor
(actorid, activeflag, personid, actortype, dangerlevel, dangerreason, insertedby, insertedon, updatedby, updatedon, expirationdate, "timestamp", primarylanguageid, secondarylanguageid, employeetypeid, employeetypename, medicaideligibility, blockgranteligibility, recipientstatus, livingarrangementtypekey, interpreterrequired, guardianname, guardianinfo, ramentalhealth, ramentalretarted, ramentalretartedtype, manualupdateflag, intakeserviceid, iscollateralcontact, old_id, ismentalillness, mentalillnessdetail, ismentalimpair, mentalimpairdetail, ishouseholdmember, isdangertoworker, dangertoworkerreason, sphouseholdmemberflag, spchildflag, spreporteranonymousflag, spreporternoletterflag, spexpungementflag, fetalalcoholspctrmdisordflag, drugexposednewbornflag, probationsearchconductedflag, sexoffenderregisteredflag, otherdrugs, unknownreporterflag, spproviderid, servicecaseid, fk_id, fk_c_id, personroletypeid, drugexposedkey, intakenumber, etl_userid, etl_load_date, objectid, objecttype, startdate, enddate)
VALUES(gen_random_uuid(), 1, (select personid from person where insertedby = 'CDM-43527'), 'AM', NULL, NULL, 'CDM-43527', now(), 'CDM-43527', now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N', '834dd2b8-eaa9-4cde-9243-f62cd59134a5'::uuid, 0, '1064785', 0, NULL, 0, NULL, 1, 0, ' ', 1, 1, 0, 0, 0, 0, 0, 0, 0, NULL, 0, NULL, NULL, '1064785', 'CW2135703', NULL, NULL, 'CW2135703', 'CDM-43527', now(), NULL, NULL, NULL, NULL);


update intakeservicerequestactor
set actorid = (select actorid from actor where personid = (select personid from person where insertedby = 'CDM-43527' limit 1) limit 1),
	personid = (select personid from person where insertedby = 'CDM-43527' limit 1),
	updatedby = 'CDM-43527', updatedon = now()
where intakeservicerequestactorid = 'a610f802-98de-46b7-b708-d88200ffdd0c' and activeflag = 1 and intakenumber ='CW2135703';



select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
( 'IR'::character varying,
'CW2023683'::character varying,
null::date
) ;


select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
( 'IR'::character varying,
'CW2135703'::character varying,
null::date
) ;
