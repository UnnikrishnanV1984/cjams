/*
Issue Description:CJAMS-63806 Incorrect Removal End Date
Category/Module: Placement 
Root cause:User mistakenly ended permanently leaving care when ending placement as a result removal was ended with incorrect date.
           The removal end date should be 11/03/25, NOT 10/30/25
Removal end date needs to be removed for user to create a placment Need placement to complete GAP Screen
            We need to do data fix for the case and client 
            1) Remove the Child Removal End Date on 10/30/2025
            2) Remove the OOH Program Assignment End Date on 10/30/2025
            3) Update the Foster Care-Home Living Arrangement exit type from Permanently Leaving Custody & Care. to Change In Placement Structure.
            Client ID: 3876441 (Halle Penny)
            Once data fix is completed and deployed to the production, user can manually ended the child removal with 11/03/2025.
Fix provided: Data fix has been done to remove the child removal end date and OOH Program assignment date and Update the Foster Care-Home Living Arrangement exit type from Permanently Leaving Custody & Care. to Change In Placement reason as runaway.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User requested for a data fix to continue the GAP flow to break the link.
*/


update intakeservreqchildremoval 
set exitdate = null,
    returntransts = null,
    returndate = null,
    returntime = null,
    removalexitreason = null,
    updatedby = 'CJAMS-63806',
    updatedon = now()
where intakeservreqchildremovalid='04250b33-9f09-47d7-9e83-c17c6315453e'
and activeflag =1;

update personprogramarea 
set enddate = null, 
updatedby ='CJAMS-63806', 
updatedon = now()  
where personprogramid ='2229f9dc-137b-4885-92b0-f8f8b700571a' 
and activeflag = 1;

update tb_client_eligibility
set end_dt = null,
    update_user_id = 'CJAMS-63806',
    update_ts = now()
where removal_id = 364940
and delete_sw = 'N';


--Updating placement
update placement
set exittypekey = 'CIP', exitreasontypekey = 'CIPR', updatedby = 'CJAMS-63719', updatedon = now()
where placementid = 'e1216ea6-2b33-4e49-9709-4c441144cdf6' and activeflag = 1;

--Updating placementrevision
update placementrevision
set exittypekey = 'CIP', exitreasontypkey = 'CIPR', updatedby = 'CJAMS-63719', updatedon = now()
where placementrevisionid = '34d4150e-5754-43ef-9579-96750d64ab55' and activeflag = 1;


--updating the child removal history table

INSERT INTO cjams.intakeservreqchildremoval_history
(intakeservreqchildremovalhistoryid, modifieddata, rowtype, intakeservreqchildremovalid, intakeserviceid, fathername, mothername, rmvdfrmpersonname, removalreasontypeid, removaladd1, removaladd2, removalzip, removalstatecd, removalcity, activeflag, insertedby, insertedon, updatedby, updatedon, agencytypekey, old_id, intakeservicerequestactorid, rmvdfrmisractorid, removaldate, parent2signeddate, primarycaregiverid, vpaparentssigneddate, vpadsssigneddate, dateoffindingctwdecision, childphysicaladdressafterremoval, nameofsubjectctwfinding, clientidofsubjectctwfinding, courtorderdelaytimeframe, reasonableeffortsnotnecessaryduetoemergentcircumstances, whoisresponsibleforplacementandcare, ctwdecision, relationshipofsubjectctwfinding, specifiedrelativedatechildlastlivedwith, specifiedrelativephysicaladdress, specifiedrelativename, specifiedrelativeclientid, specifiedrelativerelationshipid, sheltergranted, courtorderdelayremoval, magistrateorjudgename, typeofvpa, eavpaagreementflag, vpabegindate, ctwsanctioningchildremoval, childphysicalremovaldate, petitionfiledate, dateofremovalcourthearing, judgesigned, hearingdate, physicalremovalafterdetermination, removalcourtorderdate, childphysicalremovaladdress, specifiedrelativephysicaladdressafterremoval, dateofreasonableeffortscourthearing, reasonableeffortsmade, issafehavenbaby, returndate, childremovedfromtypekey, familystructuretypekey, "comments", vpastartdate, vpaenddate, childrelativelastdate, approvalstatustypekey, caseid, nocaregivercustodyflag, origremovalid, datavalidflag, clientmergeid, removaltime, returntime, removaltransts, returntransts, afcarseditapplyflag, parentssigntypekey, parent2comments, fk1_id, agencysigneddate, isbothparentssigned, childfactorsentry, removaltypekey, primarycaregiveractorid, vpachildsigneddate, vpayouthsigneddate, vpaguardiansigneddate, removalreasontypekey, removalid, exitdate, seccaregiveractorid, seccaregiveradd, primarycaregiveradd, isverifiedreporteradd, isverifiedcaregiver1add, isverifiedcaregiver2add, relativeactorid, isdisability, servicecaseid, assessmentid, personid, ischildphysicalremovaladdressverified, isuploadedmanually, isshelterauthcompleted, ischildaddressasprimaryaddress, removalexitreason, parent1id, parent2id, guardianid, volrelinquishment, etl_userid, etl_load_date, actualdata, removalcircumstances, transferagency, otherpublicagency, locationofadoption, justification, environmentatremovalkey, childremovalluggage, luggageprovided, placementdisposableortrashbag, luggagecomments, luggageupdatedby, luggageupdatedon, showcontactpage)
VALUES(gen_random_uuid(), '{"status": "Updated", "data": [ {"key": "comments","data_type": "text", "new_value": "The child removal was re-opened with the datafix ticket CJAMS-63806.","display_name": "Comments"}]}'::json, 'HISTORY', '04250b33-9f09-47d7-9e83-c17c6315453e'::uuid, NULL, NULL, NULL, NULL, NULL, '1802 Metzerott Rd, Hyattsville, MD20783', NULL, '65559999', NULL, NULL, 1, 'CJAMS-63806', now(), 'CJAMS-63806', now(), 'AFH', NULL, '19d6c8e8-0b14-43a3-b075-bd5b10b5c2c3'::uuid, NULL, '2025-10-03 00:00:00.000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Childs Maternal Grandmother took the child to Children''s National Hospital after child ran away and child''s erratic aggressive behaviors. Grandmother reported while child was on depression medication for a month the child''s behaviors did not get better. Family was homeless from June to September and was afraid of being put out of their home they moved into recently, as the police have been called to the address twice because of child''s behaviors. Grandmother reports the child makes the family feel unsafe and threatens to harm them and because of grandmothers age and primary caregiver she is unable to care for the child.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-03 20:37:00.000', NULL, '2025-10-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'JD', '5b5f9913-06f3-4b73-b03f-bc8c8bc28fdc'::uuid, NULL, NULL, NULL, NULL, 364940, NULL, NULL, NULL, '1802 Metzerott Rd, Hyattsville, MD20783', 1, 1, 0, NULL, NULL, '699afd1b-ab6f-4074-9127-b89993d8a38d'::uuid, NULL, 'c5734e47-2489-4e72-9583-15101b3d0ceb'::uuid, NULL, 0, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{"intakeservreqchildremovalid":null,"familystructuretypekey":null,"environmentatremovalkey":"MEHEFA","agencytypekey":"AFH","isdisability":null,"removaltypekey":"JD","removaldate":"10/03/2025","exitdate":null,"exittime":null,"removaltime":"2025-10-08T00:37:12.840Z","rmvdfrmpersonname":null,"primarycaregiveractorid":"5b5f9913-06f3-4b73-b03f-bc8c8bc28fdc","seccaregiveractorid":null,"removaladd1":"1802 Metzerott Rd, Hyattsville, MD20783","vpabegindate":null,"vpaenddate":null,"vpaparentssigneddate":null,"parent2signeddate":null,"vpaguardiansigneddate":null,"parent1id":null,"parent2id":null,"guardianid":null,"vpa2parentssigneddate":null,"parent2sigmissreason":null,"primarycaregiveradd":"1802 Metzerott Rd, Hyattsville, MD20783","ischildaddressasprimaryaddress":1,"childhomeaddress":null,"childphysicalremovaladdress":null,"ischildphysicalremovaladdressverified":null,"seccaregiveradd":null,"isverifiedcaregiver1add":1,"isverifiedcaregiver2add":null,"vpayouthsigneddate":null,"isbothparentssigned":null,"volrelinquishment":null,"agencysigneddate":null,"removalreason":null,"removalexitreason":null,"transferagency":null,"otherpublicagency":null,"locationofadoption":null,"caregiverreason":null,"reasonableefforts":["REPERCH"],"notmakingefforts":null,"specifiedrelativename":null,"returndate":null,"returntime":null,"specifiedrelativedatechildlastlivedwith":null,"exitreason":null,"parent2comments":null,"comments":"Childs Maternal Grandmother took the child to Children''s National Hospital after child ran away and child''s erratic aggressive behaviors. Grandmother reported while child was on depression medication for a month the child''s behaviors did not get better. Family was homeless from June to September and was afraid of being put out of their home they moved into recently, as the police have been called to the address twice because of child''s behaviors. Grandmother reports the child makes the family feel unsafe and threatens to harm them and because of grandmothers age and primary caregiver she is unable to care for the child.","reasonableeffortsmade":null,"isverifiedreporteradd":1,"placement":null,"familyhistory":null,"childdesc":null,"justification":null,"removalcircumstances":{"abandonment":null,"caretakeralcoholuse":null,"caretakerdruguse":null,"caretakersignificantimpairment":null,"caretakerignificantimpphysical":null,"childalcoholuse":null,"childbehaviorproblem":null,"childdruguse":null,"childrequestedplacement":null,"deathofcaretaker":null,"diagnosedcondition":null,"domesticviolence":null,"failuretoreturn":null,"familyconflict":null,"homelessness":null,"inadequateaccesstomhs":null,"inadequateaccesstomedicalservices":null,"inadequatehousing":null,"incarcerationofcaretaker":null,"medicalneglect":null,"neglect":null,"parentalimmigration":null,"physicalabuse":null,"prenatalalcoholexposure":null,"prenataldrugexposure":null,"psychologicalemotionalabuse":null,"publicagencytitleive":null,"runaway":null,"sexualabuse":null,"sextrafficking":null,"tribaltitleive":null,"voluntaryrelinquishment":null,"whereaboutsunknown":null},"familystructuretypekeyref":null,"environmentAtRemovalkeyref":"Medical/mental health facility","agencytypekeyref":"Agency Foster Home","removaltypekeyref":"Judicial Determination","primarycaregiveractoridref":"Sharon Derr - 3899725","seccaregiveractoridref":null,"parent1idref":null,"parent2idref":null,"removalreasonref":null,"removalexitreasonref":null,"reasonableeffortsref":", Reasonable efforts have been made but have been unsuccessful in preventing or eliminating the need for removal of child from childs home","notmakingeffortsref":null,"isuploadedmanually":null,"isshelterauthcompleted":0,"luggagecomments":""}'::json, '{"abandonment":null,"caretakeralcoholuse":null,"caretakerdruguse":null,"caretakersignificantimpairment":null,"caretakerignificantimpphysical":null,"childalcoholuse":null,"childbehaviorproblem":null,"childdruguse":null,"childrequestedplacement":null,"deathofcaretaker":null,"diagnosedcondition":null,"domesticviolence":null,"failuretoreturn":null,"familyconflict":null,"homelessness":null,"inadequateaccesstomhs":null,"inadequateaccesstomedicalservices":null,"inadequatehousing":null,"incarcerationofcaretaker":null,"medicalneglect":null,"neglect":null,"parentalimmigration":null,"physicalabuse":null,"prenatalalcoholexposure":null,"prenataldrugexposure":null,"psychologicalemotionalabuse":null,"publicagencytitleive":null,"runaway":null,"sexualabuse":null,"sextrafficking":null,"tribaltitleive":null,"voluntaryrelinquishment":null,"whereaboutsunknown":null}'::json, NULL, NULL, NULL, NULL, 'MEHEFA', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
