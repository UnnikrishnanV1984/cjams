/* 
    Issue Description: CDM-38443
  Category/ Module  : Decision
  Root cause: User request to remove alleged maltreator
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: 
  Backup before update/ delete: 
*/



INSERT INTO cjams.person
(personid,activeflag, principalident, firstname, lastname, middlename, salutation, suffix, dangerlevel, dangerreason, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id, "timestamp", dob, religiontypekey, maritalstatustypekey, gendertypekey, racetypekey, deceaseddate, ethnicgrouptypekey, incometypekey, interpreterrequired, firstnamesoundex, lastnamesoundex, ssnverified, userphoto, refusessn, refusedob, dangertoself, dangertoselfreason, personphysicalattributetypeid, maidenname, socialmediasource, dateofdeath, prefx, occupation, deceased, stateid, fein, complaintnumber, cjisnumber, petitionid, tribalassociation, physicalattributes, isdraft, interfaceid, strengths, needs, nationalitytypekey, isapproxdod, primarylanguageid, secondarylanguageid, livingsituationkey, licensedfacilitykey, otherlicensedfacility, livingsituationdesc, reporteranonymousflag, url, expungementflag, dobflag, nameunknownflag, actiontypekey, adoptedflag, everbeenadoptedflag, sysdetadptflag, previousadoptionagetypekey, confirmationentitytypekey, clientflag, approximateageno, ssnno, citizenalenagetypekey, alienregistrationtext, doddate, physicalbuildtypekey, skintonetypekey, eyecolortypekey, haircolortypekey, hairtexturetypekey, distinguishedcomments, criminalrecordflag, stateverifieddate, countytypekey, primarycitizenshiptypekey, seccitizenshiptypekey, providerid, datepictaken, datavalidflag, outofstateflag, disabilityflag, afcarsageoutflag, afcarsperiodsent, fetalalcoholspctrmdisordflag, substanceexposednewbornflag, otherdrugs, substanceexposednewbornsourcetypekey, substanceexposednewbornsourceid, substanceexposednewborntimetamp, isapproxdob, otherprimarylanguagetypekey, citizenalenageflag, otherreligion, isqualifiedalien, verificationremarks, alienstatustypekey, safehavenbabyflag, fk_id, personflag, preadoptiondate, aname, batchrunflag, isuscitizen, hairtextureotherdesc, haircolorotherdesc, isglasses, employername, clienttitle, biologicalmothermarriedsw, etl_userid, etl_load_date, livingarrangementkey, livingarrangementdesc, cferesourcehomechild, icwastatusinquiry, icwaeligibleformembership, icwatribename, icwaunderdefinition, icwanotification, icwatribelegalnotice, intercountryadoption, priorlegalguardianship, preplacementguardianshipdate, federallyrecognizedtribe, substanceclasses, othersubstances, senstatusflag, ispostmdmflag, postmdmreturnstatus, isbioadoptedflag)
VALUES('499d5aa7-37d5-412c-835a-440d73a745e8',1, NULL, 'unnamed', 'unnamed', '', NULL, '', NULL, NULL, 'CDM-38443', now(), 'CDM-38443', now(), '2024-06-13 14:23:02.008', NULL, NULL, NULL, '1900-01-01 00:00:00.000', NULL, NULL, 'U', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', false, false, 0, '', NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 569247256, NULL, NULL, NULL, 0, 'ENG', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, '', '', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, '', '', NULL, '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


INSERT INTO cjams.actor
(actorid, activeflag, personid, actortype, dangerlevel, dangerreason, insertedby, insertedon, updatedby, updatedon, expirationdate, "timestamp", primarylanguageid, secondarylanguageid, employeetypeid, employeetypename, medicaideligibility, blockgranteligibility, recipientstatus, livingarrangementtypekey, interpreterrequired, guardianname, guardianinfo, ramentalhealth, ramentalretarted, ramentalretartedtype, manualupdateflag, intakeserviceid, iscollateralcontact, old_id, ismentalillness, mentalillnessdetail, ismentalimpair, mentalimpairdetail, ishouseholdmember, isdangertoworker, dangertoworkerreason, sphouseholdmemberflag, spchildflag, spreporteranonymousflag, spreporternoletterflag, spexpungementflag, fetalalcoholspctrmdisordflag, drugexposednewbornflag, probationsearchconductedflag, sexoffenderregisteredflag, otherdrugs, unknownreporterflag, spproviderid, servicecaseid, fk_id, fk_c_id, personroletypeid, drugexposedkey, intakenumber, etl_userid, etl_load_date, objectid, objecttype)
VALUES('bf8181c6-5eba-48d4-84ec-589d74dc17dc', 1, '499d5aa7-37d5-412c-835a-440d73a745e8', 'RA', NULL, NULL, 'CDM-38443', now(), 'CDM-38443', now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'N', 'ffc5664c-367b-47c4-b35b-8291e9bb2393', 0, '2091692', 0, NULL, 0, NULL, 1, 0, ' ', 1, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, NULL, NULL, '2091692', 'CW2646055', NULL, NULL, 'CW2646055', 'Data Migration', '2020-07-25', NULL, NULL);

update cjams.intakeservicerequestactor
set personid = '499d5aa7-37d5-412c-835a-440d73a745e8',
actorid='bf8181c6-5eba-48d4-84ec-589d74dc17dc',
	updatedon = now(), 
	updatedby = 'CDM-38443'
where intakeservicerequestactorid  = '0d075f05-7d0c-4a9a-a1b1-df52ce5554a9'
	and activeflag = 1;
