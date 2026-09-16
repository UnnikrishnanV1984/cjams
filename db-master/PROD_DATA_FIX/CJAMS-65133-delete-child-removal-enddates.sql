/*
Issue:Need data fix to remove Child Removal End Date and Remove OOH Program Assignment End Date.
Root Cause: requested to remove the end date of child removal and ooh program to remain active
Fix Provided (Data Fix Only):Data fix was done by clearing the date of 01/30/2026 to restore the removal status and Cleared the date of 01/30/2026 to ensure the Out-of-Home program remains active.
Data/Code fix ticket#: CJAMS-65133
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/

update personprogramarea
set enddate=null, updatedby='CJAMS-65133', updatedon=now()
where personprogramid='20c2c567-d341-4244-acef-21fd51a875e6' and objectid='ea617180-bb98-4aed-a8c9-e7fa64cdd8a1' and activeflag=1;

update intakeservreqchildremoval
set exitdate=null, 
	returntransts = null,
	returndate = null,
	returntime = null,
	removalexitreason = null,
    updatedby='CJAMS-65133', 
    updatedon=now()
where intakeservreqchildremovalid='d43f512b-aa5d-43ec-bb7b-444c45d60b01' and intakeservicerequestactorid='38072473-dfbe-4e6c-ba13-af8700296048';

update tb_client_eligibility
set end_dt = null,
    update_user_id = 'CJAMS-65133',
    update_ts = now()
where removal_id = 296369
and delete_sw = 'N';

update personprogramarea
set enddate=null, updatedby='CJAMS-65133', updatedon=now()
where personprogramid='e0155a13-2e7f-4cf5-ad71-5d1c40b45bcd' and objectid='ea617180-bb98-4aed-a8c9-e7fa64cdd8a1' and activeflag=1;

update intakeservreqchildremoval
set exitdate=null, 
	returntransts = null,
	returndate = null,
	returntime = null,
	removalexitreason = null,
    updatedby='CJAMS-65133', 
    updatedon=now()
where intakeservreqchildremovalid='225a4ee0-85aa-4345-891c-49818838c7b2' and intakeservicerequestactorid='07b76d98-c13c-4f2b-b4ef-c803c2560620';

update tb_client_eligibility
set end_dt = null,
    update_user_id = 'CJAMS-65133',
    update_ts = now()
where removal_id = 296368
and delete_sw = 'N';

INSERT INTO cjams.intakeservreqchildremoval_history
(intakeservreqchildremovalhistoryid, modifieddata, rowtype, intakeservreqchildremovalid, intakeserviceid, fathername, mothername, rmvdfrmpersonname, removalreasontypeid, removaladd1, removaladd2, removalzip, removalstatecd, removalcity, activeflag, insertedby, insertedon, updatedby, updatedon, agencytypekey, old_id, intakeservicerequestactorid, rmvdfrmisractorid, removaldate, parent2signeddate, primarycaregiverid, vpaparentssigneddate, vpadsssigneddate, dateoffindingctwdecision, childphysicaladdressafterremoval, nameofsubjectctwfinding, clientidofsubjectctwfinding, courtorderdelaytimeframe, reasonableeffortsnotnecessaryduetoemergentcircumstances, whoisresponsibleforplacementandcare, ctwdecision, relationshipofsubjectctwfinding, specifiedrelativedatechildlastlivedwith, specifiedrelativephysicaladdress, specifiedrelativename, specifiedrelativeclientid, specifiedrelativerelationshipid, sheltergranted, courtorderdelayremoval, magistrateorjudgename, typeofvpa, eavpaagreementflag, vpabegindate, ctwsanctioningchildremoval, childphysicalremovaldate, petitionfiledate, dateofremovalcourthearing, judgesigned, hearingdate, physicalremovalafterdetermination, removalcourtorderdate, childphysicalremovaladdress, specifiedrelativephysicaladdressafterremoval, dateofreasonableeffortscourthearing, reasonableeffortsmade, issafehavenbaby, returndate, childremovedfromtypekey, familystructuretypekey, "comments", vpastartdate, vpaenddate, childrelativelastdate, approvalstatustypekey, caseid, nocaregivercustodyflag, origremovalid, datavalidflag, clientmergeid, removaltime, returntime, removaltransts, returntransts, afcarseditapplyflag, parentssigntypekey, parent2comments, fk1_id, agencysigneddate, isbothparentssigned, childfactorsentry, removaltypekey, primarycaregiveractorid, vpachildsigneddate, vpayouthsigneddate, vpaguardiansigneddate, removalreasontypekey, removalid, exitdate, seccaregiveractorid, seccaregiveradd, primarycaregiveradd, isverifiedreporteradd, isverifiedcaregiver1add, isverifiedcaregiver2add, relativeactorid, isdisability, servicecaseid, assessmentid, personid, ischildphysicalremovaladdressverified, isuploadedmanually, isshelterauthcompleted, ischildaddressasprimaryaddress, removalexitreason, parent1id, parent2id, guardianid, volrelinquishment, etl_userid, etl_load_date, actualdata, removalcircumstances, transferagency, otherpublicagency, locationofadoption, justification, environmentatremovalkey, childremovalluggage, luggageprovided, placementdisposableortrashbag, luggagecomments, luggageupdatedby, luggageupdatedon, showcontactpage)
VALUES(gen_random_uuid(), '{"status": "Updated", "data": [ {"key": "comments","data_type": "text", "new_value": "The child removal was re-opened with the datafix ticket CJAMS-65133.","display_name": "Comments"}]}'::json, 'HISTORY', 'd43f512b-aa5d-43ec-bb7b-444c45d60b01', NULL, NULL, NULL, NULL, NULL, '232 S Stricker St, Baltimore, MD', NULL, '65559999', NULL, NULL, 1, 'CJAMS-65133', now(), 'CJAMS-65133', now(), 'PTFH', NULL, '38072473-dfbe-4e6c-ba13-af8700296048', NULL, '2023-12-06 00:00:00.000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '293', 'The Croteau children were returned home under an OPS. Ms. Stewart violated the stipulations of the OPS by making herself unavailable to the agency, after she was evicted from her home. The family has been transient, moving  in-and-out of vacant homes in Southwest Baltimore. Family Preservation Caseworker Genesis Bailey and CPS-Investigator located the family who were staying in a home without electricity.   Ms. Stewart is unable to provide a stable home for her family, at this time. 
', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-12-06 14:15:00.000', NULL, '2023-12-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'JD', '7cbe748c-d472-4864-8fe1-2e899c7b73e8', NULL, NULL, NULL, NULL, 296369, NULL, NULL, NULL, '232 S Stricker St, Baltimore, MD', 1, 1, 0, NULL, NULL, 'ea617180-bb98-4aed-a8c9-e7fa64cdd8a1', NULL, '7880c987-c0cd-40cc-aaa9-e9ecade9b9a2', NULL, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{"intakeservreqchildremovalid":null,"familystructuretypekey":"293","environmentatremovalkey":"PAHOLD","agencytypekey":"PTFH","isdisability":null,"removaltypekey":"JD","removaldate":"12/06/2023","exitdate":null,"exittime":null,"removaltime":"2023-12-07T19:15:57.803Z","rmvdfrmpersonname":null,"primarycaregiveractorid":"7cbe748c-d472-4864-8fe1-2e899c7b73e8","seccaregiveractorid":null,"removaladd1":"232 S Stricker St, Baltimore, MD","vpabegindate":null,"vpaenddate":null,"vpaparentssigneddate":null,"parent2signeddate":null,"vpaguardiansigneddate":null,"parent1id":null,"parent2id":null,"guardianid":null,"vpa2parentssigneddate":null,"parent2sigmissreason":null,"primarycaregiveradd":"232 S Stricker St, Baltimore, MD","ischildaddressasprimaryaddress":1,"childhomeaddress":null,"childphysicalremovaladdress":null,"ischildphysicalremovaladdressverified":null,"seccaregiveradd":null,"isverifiedcaregiver1add":1,"isverifiedcaregiver2add":null,"vpayouthsigneddate":null,"isbothparentssigned":null,"volrelinquishment":null,"agencysigneddate":null,"removalreason":["IDH"],"removalexitreason":null,"transferagency":null,"otherpublicagency":null,"locationofadoption":null,"caregiverreason":null,"reasonableefforts":["DAESRSC"],"notmakingefforts":null,"specifiedrelativename":null,"returndate":null,"returntime":null,"specifiedrelativedatechildlastlivedwith":null,"exitreason":null,"parent2comments":null,"comments":"The Croteau children were returned home under an OPS. Ms. Stewart violated the stipulations of the OPS by making herself unavailable to the agency, after she was evicted from her home. The family has been transient, moving  in-and-out of vacant homes in Southwest Baltimore. Family Preservation Caseworker Genesis Bailey and CPS-Investigator located the family who were staying in a home without electricity.   Ms. Stewart is unable to provide a stable home for her family, at this time. \n","reasonableeffortsmade":null,"isverifiedreporteradd":1,"placement":null,"familyhistory":null,"childdesc":null,"justification":null,"removalcircumstances":{"abandonment":null,"caretakeralcoholuse":null,"caretakerdruguse":true,"caretakersignificantimpairment":null,"caretakerignificantimpphysical":null,"childalcoholuse":null,"childbehaviorproblem":null,"childdruguse":null,"childrequestedplacement":null,"deathofcaretaker":null,"diagnosedcondition":null,"domesticviolence":null,"failuretoreturn":true,"familyconflict":null,"homelessness":true,"inadequateaccesstomhs":true,"inadequateaccesstomedicalservices":true,"inadequatehousing":true,"incarcerationofcaretaker":null,"medicalneglect":null,"neglect":null,"parentalimmigration":null,"physicalabuse":null,"prenatalalcoholexposure":null,"prenataldrugexposure":null,"psychologicalemotionalabuse":null,"publicagencytitleive":null,"runaway":null,"sexualabuse":null,"sextrafficking":null,"tribaltitleive":null,"voluntaryrelinquishment":null,"whereaboutsunknown":true},"familystructuretypekeyref":"Single Female","environmentAtRemovalkeyref":"Parent household","agencytypekeyref":"Private Treatment Foster Home","removaltypekeyref":"Judicial Determination","primarycaregiveractoridref":"Tia Stewart - 1472356","seccaregiveractoridref":null,"parent1idref":null,"parent2idref":null,"removalreasonref":"Inadequate Housing","removalexitreasonref":null,"reasonableeffortsref":", Due to an alleged emergency situation, removal from the home is reasonable under the circumstances to provide for the safety of the child","notmakingeffortsref":null,"isuploadedmanually":1,"isshelterauthcompleted":1}'::json, '{"abandonment":null,"caretakeralcoholuse":null,"caretakerdruguse":true,"caretakersignificantimpairment":null,"caretakerignificantimpphysical":null,"childalcoholuse":null,"childbehaviorproblem":null,"childdruguse":null,"childrequestedplacement":null,"deathofcaretaker":null,"diagnosedcondition":null,"domesticviolence":null,"failuretoreturn":true,"familyconflict":null,"homelessness":true,"inadequateaccesstomhs":true,"inadequateaccesstomedicalservices":true,"inadequatehousing":true,"incarcerationofcaretaker":null,"medicalneglect":null,"neglect":null,"parentalimmigration":null,"physicalabuse":null,"prenatalalcoholexposure":null,"prenataldrugexposure":null,"psychologicalemotionalabuse":null,"publicagencytitleive":null,"runaway":null,"sexualabuse":null,"sextrafficking":null,"tribaltitleive":null,"voluntaryrelinquishment":null,"whereaboutsunknown":true}'::json, NULL, NULL, NULL, NULL, 'PAHOLD', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
