/*

   Issue Description: CDM-39694-Maltreator removal

   Category/ Module  : Person

   Root cause: User requestred to remove Maltreator from case

   Fix provided :Datafix to remove person

   Code fix ticket#:

   Reason why no related code fix: 

   Status of the code fix if already submitted and expected prod fix date: 

   Backup before update/ delete:

*/

INSERT INTO cjams.person
(personid,activeflag, principalident, firstname, lastname, middlename, salutation, suffix, dangerlevel, dangerreason, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id, "timestamp", dob, religiontypekey, maritalstatustypekey, gendertypekey, racetypekey, deceaseddate, ethnicgrouptypekey, incometypekey, interpreterrequired, firstnamesoundex, lastnamesoundex, ssnverified, userphoto, refusessn, refusedob, dangertoself, dangertoselfreason, personphysicalattributetypeid, maidenname, socialmediasource, dateofdeath, prefx, occupation, deceased, stateid, fein, complaintnumber, cjisnumber, petitionid, tribalassociation, physicalattributes, isdraft, interfaceid, strengths, needs, nationalitytypekey, isapproxdod, primarylanguageid, secondarylanguageid, livingsituationkey, licensedfacilitykey, otherlicensedfacility, livingsituationdesc, reporteranonymousflag, url, expungementflag, dobflag, nameunknownflag, actiontypekey, adoptedflag, everbeenadoptedflag, sysdetadptflag, previousadoptionagetypekey, confirmationentitytypekey, clientflag, approximateageno, ssnno, citizenalenagetypekey, alienregistrationtext, doddate, physicalbuildtypekey, skintonetypekey, eyecolortypekey, haircolortypekey, hairtexturetypekey, distinguishedcomments, criminalrecordflag, stateverifieddate, countytypekey, primarycitizenshiptypekey, seccitizenshiptypekey, providerid, datepictaken, datavalidflag, outofstateflag, disabilityflag, afcarsageoutflag, afcarsperiodsent, fetalalcoholspctrmdisordflag, substanceexposednewbornflag, otherdrugs, substanceexposednewbornsourcetypekey, substanceexposednewbornsourceid, substanceexposednewborntimetamp, isapproxdob, otherprimarylanguagetypekey, citizenalenageflag, otherreligion, isqualifiedalien, verificationremarks, alienstatustypekey, safehavenbabyflag, fk_id, personflag, preadoptiondate, aname, batchrunflag, isuscitizen, hairtextureotherdesc, haircolorotherdesc, isglasses, employername, clienttitle, biologicalmothermarriedsw, etl_userid, etl_load_date, livingarrangementkey, livingarrangementdesc, cferesourcehomechild, icwastatusinquiry, icwaeligibleformembership, icwatribename, icwaunderdefinition, icwanotification, icwatribelegalnotice, intercountryadoption, priorlegalguardianship, preplacementguardianshipdate, federallyrecognizedtribe, substanceclasses, othersubstances, senstatusflag, ispostmdmflag, postmdmreturnstatus, isbioadoptedflag)
VALUES(gen_random_uuid (),1, NULL, 'unnamed', 'unnamed', '', NULL, '', NULL, NULL, 'CDM-39694', now(), 'CDM-39694', now(), '2024-06-13 14:23:02.008', NULL, NULL, NULL, '1900-01-01 00:00:00.000', NULL, NULL, 'U', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', false, false, 0, '', NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 569247256, NULL, NULL, NULL, 0, 'ENG', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.actor
(actorid, activeflag, personid, actortype, dangerlevel, dangerreason, insertedby, insertedon, updatedby, updatedon, expirationdate, "timestamp", primarylanguageid, secondarylanguageid, employeetypeid, employeetypename, medicaideligibility, blockgranteligibility, recipientstatus, livingarrangementtypekey, interpreterrequired, guardianname, guardianinfo, ramentalhealth, ramentalretarted, ramentalretartedtype, manualupdateflag, intakeserviceid, iscollateralcontact, old_id, ismentalillness, mentalillnessdetail, ismentalimpair, mentalimpairdetail, ishouseholdmember, isdangertoworker, dangertoworkerreason, sphouseholdmemberflag, spchildflag, spreporteranonymousflag, spreporternoletterflag, spexpungementflag, fetalalcoholspctrmdisordflag, drugexposednewbornflag, probationsearchconductedflag, sexoffenderregisteredflag, otherdrugs, unknownreporterflag, spproviderid, servicecaseid, fk_id, fk_c_id, personroletypeid, drugexposedkey, intakenumber, etl_userid, etl_load_date, objectid, objecttype)
VALUES(gen_random_uuid (), 1, (select p.personid from person p where p.insertedby = 'CDM-39694'), 'RA', NULL, NULL, 'CDM-39694', now(), 'CDM-39694', now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N', '1e31b349-d46d-4737-9391-21a7615f8045', 0, '2240816', 0, NULL, 0, NULL, 1, 0, ' ', 1, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, NULL, NULL, '2240816', 'CW2240816', NULL, NULL, 'CW2240816', 'Data Migration', '2020-06-20', NULL, NULL);

update intakeservicerequestactor 
set personid = (select p1.personid from person p1 where p1.insertedby ='CDM-39694'),
actorid = (select a.actorid from actor a where a.insertedby ='CDM-39694'),
	updatedon = now(), 
	updatedby = 'CDM-39694'
where intakeservicerequestactorid  = 'ad1b899b-287c-42f4-ae50-e834d29ddfe6'
	and activeflag = 1;













