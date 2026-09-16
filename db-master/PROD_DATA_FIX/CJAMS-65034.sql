/*
Issue Description:CJAMS-65034 231030123241::Removal end date need to be taken out
Category/Module: Placement 
Root cause: This child's removal was end dated in error. 
            Case ID - 231030123241
            CJAMS PID - 200021571 
Fix provided: Data fix has been done to remove child removal end date and OOH Program assignment date
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
*/


update intakeservreqchildremoval 
set exitdate = null,
    returntransts = null,
	removalexitreason = null,
    updatedby = 'CJAMS-65034',
    updatedon = now()
where intakeservreqchildremovalid='63dcde38-5c07-4ab5-afe0-b595c20d8579'
and activeflag =1;

update personprogramarea 
set enddate = null, 
updatedby ='CJAMS-65034', 
updatedon = now()  
where personprogramid ='3164a46e-d84c-42a0-bfdf-925869f3c136' 
and activeflag = 1;

update tb_client_eligibility
set end_dt = null,
    update_user_id = 'CJAMS-65034',
    update_ts = now()
where removal_id = 274728
and delete_sw = 'N';

INSERT INTO cjams.intakeservreqchildremoval_history
(intakeservreqchildremovalhistoryid, modifieddata, rowtype, intakeservreqchildremovalid, intakeserviceid, fathername, mothername, rmvdfrmpersonname, removalreasontypeid, removaladd1, removaladd2, removalzip, removalstatecd, removalcity, activeflag, insertedby, insertedon, updatedby, updatedon, agencytypekey, old_id, intakeservicerequestactorid, rmvdfrmisractorid, removaldate, parent2signeddate, primarycaregiverid, vpaparentssigneddate, vpadsssigneddate, dateoffindingctwdecision, childphysicaladdressafterremoval, nameofsubjectctwfinding, clientidofsubjectctwfinding, courtorderdelaytimeframe, reasonableeffortsnotnecessaryduetoemergentcircumstances, whoisresponsibleforplacementandcare, ctwdecision, relationshipofsubjectctwfinding, specifiedrelativedatechildlastlivedwith, specifiedrelativephysicaladdress, specifiedrelativename, specifiedrelativeclientid, specifiedrelativerelationshipid, sheltergranted, courtorderdelayremoval, magistrateorjudgename, typeofvpa, eavpaagreementflag, vpabegindate, ctwsanctioningchildremoval, childphysicalremovaldate, petitionfiledate, dateofremovalcourthearing, judgesigned, hearingdate, physicalremovalafterdetermination, removalcourtorderdate, childphysicalremovaladdress, specifiedrelativephysicaladdressafterremoval, dateofreasonableeffortscourthearing, reasonableeffortsmade, issafehavenbaby, returndate, childremovedfromtypekey, familystructuretypekey, "comments", vpastartdate, vpaenddate, childrelativelastdate, approvalstatustypekey, caseid, nocaregivercustodyflag, origremovalid, datavalidflag, clientmergeid, removaltime, returntime, removaltransts, returntransts, afcarseditapplyflag, parentssigntypekey, parent2comments, fk1_id, agencysigneddate, isbothparentssigned, childfactorsentry, removaltypekey, primarycaregiveractorid, vpachildsigneddate, vpayouthsigneddate, vpaguardiansigneddate, removalreasontypekey, removalid, exitdate, seccaregiveractorid, seccaregiveradd, primarycaregiveradd, isverifiedreporteradd, isverifiedcaregiver1add, isverifiedcaregiver2add, relativeactorid, isdisability, servicecaseid, assessmentid, personid, ischildphysicalremovaladdressverified, isuploadedmanually, isshelterauthcompleted, ischildaddressasprimaryaddress, removalexitreason, parent1id, parent2id, guardianid, volrelinquishment, etl_userid, etl_load_date, actualdata, removalcircumstances, transferagency, otherpublicagency, locationofadoption, justification, environmentatremovalkey, childremovalluggage, luggageprovided, placementdisposableortrashbag, luggagecomments, luggageupdatedby, luggageupdatedon, showcontactpage)
VALUES(gen_random_uuid(), '{"status": "Updated", "data": [ {"key": "comments","data_type": "text", "new_value": "the child removal was re-opened with the datafix ticket CJAMS-65034.","display_name": "Comments"}]}'::json, 'HISTORY', '63dcde38-5c07-4ab5-afe0-b595c20d8579'::uuid, NULL, NULL, NULL, NULL, NULL, '9039 Curve Ln, Lusby, MD', NULL, '65559999', NULL, NULL, 1, 'CJAMS-65034', now(), 'CJAMS-65034', now(), 'AFH', NULL, 'e147a56d-1eb2-43cb-8b1e-088f31b4dddd'::uuid, NULL, '2023-05-30 00:00:00.000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Reasonable efforts were made to keep the child in the home. The family declined assistance ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-05-30 15:30:00.000', '2026-02-02 09:30:00.000', '2023-06-02', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'JD', '8563cf31-ce61-4250-83bb-3eab51d788cb'::uuid, NULL, NULL, NULL, NULL, 274728, NULL, '63f63014-8d3c-4d06-9a3a-b2591771348a'::uuid, '9039 Curve Ln, Lusby, MD', '9039 Curve Ln, Lusby, MD', 1, 1, 1, NULL, NULL, '61bd28e7-c39a-464f-8cb7-bf7730a5cea3'::uuid, NULL, '7d786502-9716-4643-a9e7-881e56ca3256'::uuid, NULL, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{"intakeservreqchildremovalid":"63dcde38-5c07-4ab5-afe0-b595c20d8579","familystructuretypekey":null,"environmentatremovalkey":"LEGUHO","agencytypekey":"AFH","isdisability":null,"removaltypekey":"JD","removaldate":"2023-05-30T00:00:00","exitdate":null,"exittime":null,"removaltime":"2023-05-30T19:30:00.000Z","rmvdfrmpersonname":null,"primarycaregiveractorid":"8563cf31-ce61-4250-83bb-3eab51d788cb","seccaregiveractorid":"63f63014-8d3c-4d06-9a3a-b2591771348a","removaladd1":"9039 Curve Ln, Lusby, MD","vpabegindate":null,"vpaenddate":null,"vpaparentssigneddate":null,"parent2signeddate":null,"vpaguardiansigneddate":null,"parent1id":null,"parent2id":null,"guardianid":null,"vpa2parentssigneddate":null,"parent2sigmissreason":null,"primarycaregiveradd":"9039 Curve Ln, Lusby, MD","ischildaddressasprimaryaddress":1,"childhomeaddress":null,"childphysicalremovaladdress":null,"ischildphysicalremovaladdressverified":null,"seccaregiveradd":"9039 Curve Ln, Lusby, MD","isverifiedcaregiver1add":1,"isverifiedcaregiver2add":1,"vpayouthsigneddate":null,"isbothparentssigned":null,"volrelinquishment":null,"agencysigneddate":null,"removalreason":["ADT"],"removalexitreason":null,"transferagency":null,"otherpublicagency":null,"locationofadoption":null,"caregiverreason":null,"reasonableefforts":["REPERCH"],"notmakingefforts":null,"specifiedrelativename":null,"returndate":null,"returntime":null,"specifiedrelativedatechildlastlivedwith":null,"exitreason":null,"parent2comments":null,"comments":"Reasonable efforts were made to keep the child in the home. The family declined assistance ","reasonableeffortsmade":null,"isverifiedreporteradd":1,"placement":"","familyhistory":"","childdesc":null,"justification":"Saved to ensure information ","removalcircumstances":{"abandonment":true,"caretakeralcoholuse":false,"caretakerdruguse":false,"caretakersignificantimpairment":false,"caretakerignificantimpphysical":false,"childalcoholuse":false,"childbehaviorproblem":false,"childdruguse":false,"childrequestedplacement":false,"deathofcaretaker":false,"diagnosedcondition":false,"domesticviolence":false,"failuretoreturn":false,"familyconflict":false,"homelessness":false,"inadequateaccesstomhs":false,"inadequateaccesstomedicalservices":false,"inadequatehousing":false,"incarcerationofcaretaker":false,"medicalneglect":false,"neglect":false,"parentalimmigration":false,"physicalabuse":false,"prenatalalcoholexposure":false,"prenataldrugexposure":false,"psychologicalemotionalabuse":false,"publicagencytitleive":false,"runaway":false,"sexualabuse":false,"sextrafficking":false,"tribaltitleive":false,"voluntaryrelinquishment":false,"whereaboutsunknown":false},"familystructuretypekeyref":null,"environmentAtRemovalkeyref":"Legal guardian household","agencytypekeyref":"Agency Foster Home","removaltypekeyref":"Judicial Determination","primarycaregiveractoridref":"Fransina Avery - 200021575","seccaregiveractoridref":"Antonio Avery - 201252478","parent1idref":null,"parent2idref":null,"removalreasonref":"Abandonment","removalexitreasonref":null,"reasonableeffortsref":", Reasonable efforts have been made but have been unsuccessful in preventing or eliminating the need for removal of child from childs home","notmakingeffortsref":null,"isuploadedmanually":1,"isshelterauthcompleted":1}'::json, '{"abandonment":true,"caretakeralcoholuse":false,"caretakerdruguse":false,"caretakersignificantimpairment":false,"caretakerignificantimpphysical":false,"childalcoholuse":false,"childbehaviorproblem":false,"childdruguse":false,"childrequestedplacement":false,"deathofcaretaker":false,"diagnosedcondition":false,"domesticviolence":false,"failuretoreturn":false,"familyconflict":false,"homelessness":false,"inadequateaccesstomhs":false,"inadequateaccesstomedicalservices":false,"inadequatehousing":false,"incarcerationofcaretaker":false,"medicalneglect":false,"neglect":false,"parentalimmigration":false,"physicalabuse":false,"prenatalalcoholexposure":false,"prenataldrugexposure":false,"psychologicalemotionalabuse":false,"publicagencytitleive":false,"runaway":false,"sexualabuse":false,"sextrafficking":false,"tribaltitleive":false,"voluntaryrelinquishment":false,"whereaboutsunknown":false}'::json, NULL, NULL, NULL, NULL, 'LEGUHO', true, NULL, NULL, NULL, 'Samantha Stasen', '2026-02-02 15:20:22.878', NULL);

update placement 
set exittypekey = 'CIPS', 
    updatedon = now(), 
    updatedby = 'CJAMS-65034'
where placementid = '14ef9217-7eb8-4157-8371-3f30a7612e81'
and intakeservreqchildremovalid = '63dcde38-5c07-4ab5-afe0-b595c20d8579'
and activeflag = 1;

update placementrevision 
set exittypekey = 'CIPS', 
    updatedon = now(), 
    updatedby = 'CJAMS-65034' 
where placementid = '14ef9217-7eb8-4157-8371-3f30a7612e81'
and placementrevisionid = '8e0f525c-45d3-4a94-a6b4-8dac3224b17f' 
and activeflag =1;
