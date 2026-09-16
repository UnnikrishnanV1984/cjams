/*
Issue Description:CJAMS-63719 breaking the link/placement closed
Category/Module: Placement 
Root cause:This is not a defect. As per system design and policy, the child must be placed with the provider placement and pre-finalized adoptive home placement structure to complete the adoption break the link.
           Data fix needed for the following issues
Removal end date needs to be removed for user to create a placment Need placement to complete GAP Screen
            We need to do data fix for the case and client 
            1) Remove the Child Removal End Date
            2) Remove the OOH Program Assignment End Date
            3) Change the Placement Exit Type from Permanently Leaving Custody & Care to Change In Placement Structure.
            Client ID: 4323169 (KAMAR KEITH DADA-BROOKS)
            Provider ID: 5089059 (Donnille Hughes)
Fix provided: Data fix has been done to remove the  remove the child removal end date and OOH Program assignment date and placement Exit Type from Permanently Leaving Custody & Care to Change In Placement Structure.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User requested for a data fix to continue the GAP flow.
*/


update intakeservreqchildremoval 
set exitdate = null,
    returntransts = null,
    returndate = null,
    returntime = null,
    removalexitreason = null,
    updatedby = 'CJAMS-63719',
    updatedon = now()
where intakeservreqchildremovalid='8d919181-f927-4ec7-aa01-e9c58a66bbce'
and activeflag =1;

update intakeservreqchildremoval
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-63719'
where intakeservreqchildremovalid='d0af5a04-593b-4581-98d3-2d831cd09da0'
and activeflag = 1;    


update personprogramarea 
set enddate = null, 
updatedby ='CJAMS-63719', 
updatedon = now()  
where personprogramid ='c8ccf11b-daad-4713-b2ec-8841f602d587' 
and activeflag = 1;

update tb_client_eligibility
set end_dt = null,
    update_user_id = 'CJAMS-63719',
    update_ts = now()
where removal_id = 194426
and delete_sw = 'N';

INSERT INTO cjams.intakeservreqchildremoval_history
(intakeservreqchildremovalhistoryid, modifieddata, rowtype, intakeservreqchildremovalid, intakeserviceid, fathername, mothername, rmvdfrmpersonname, removalreasontypeid, removaladd1, removaladd2, removalzip, removalstatecd, removalcity, activeflag, insertedby, insertedon, updatedby, updatedon, agencytypekey, old_id, intakeservicerequestactorid, rmvdfrmisractorid, removaldate, parent2signeddate, primarycaregiverid, vpaparentssigneddate, vpadsssigneddate, dateoffindingctwdecision, childphysicaladdressafterremoval, nameofsubjectctwfinding, clientidofsubjectctwfinding, courtorderdelaytimeframe, reasonableeffortsnotnecessaryduetoemergentcircumstances, whoisresponsibleforplacementandcare, ctwdecision, relationshipofsubjectctwfinding, specifiedrelativedatechildlastlivedwith, specifiedrelativephysicaladdress, specifiedrelativename, specifiedrelativeclientid, specifiedrelativerelationshipid, sheltergranted, courtorderdelayremoval, magistrateorjudgename, typeofvpa, eavpaagreementflag, vpabegindate, ctwsanctioningchildremoval, childphysicalremovaldate, petitionfiledate, dateofremovalcourthearing, judgesigned, hearingdate, physicalremovalafterdetermination, removalcourtorderdate, childphysicalremovaladdress, specifiedrelativephysicaladdressafterremoval, dateofreasonableeffortscourthearing, reasonableeffortsmade, issafehavenbaby, returndate, childremovedfromtypekey, familystructuretypekey, "comments", vpastartdate, vpaenddate, childrelativelastdate, approvalstatustypekey, caseid, nocaregivercustodyflag, origremovalid, datavalidflag, clientmergeid, removaltime, returntime, removaltransts, returntransts, afcarseditapplyflag, parentssigntypekey, parent2comments, fk1_id, agencysigneddate, isbothparentssigned, childfactorsentry, removaltypekey, primarycaregiveractorid, vpachildsigneddate, vpayouthsigneddate, vpaguardiansigneddate, removalreasontypekey, removalid, exitdate, seccaregiveractorid, seccaregiveradd, primarycaregiveradd, isverifiedreporteradd, isverifiedcaregiver1add, isverifiedcaregiver2add, relativeactorid, isdisability, servicecaseid, assessmentid, personid, ischildphysicalremovaladdressverified, isuploadedmanually, isshelterauthcompleted, ischildaddressasprimaryaddress, removalexitreason, parent1id, parent2id, guardianid, volrelinquishment, etl_userid, etl_load_date, actualdata, removalcircumstances, transferagency, otherpublicagency, locationofadoption, justification, environmentatremovalkey, childremovalluggage, luggageprovided, placementdisposableortrashbag, luggagecomments, luggageupdatedby, luggageupdatedon, showcontactpage)
VALUES(gen_random_uuid(), '{"status": "Updated", "data": [ {"key": "comments","data_type": "text", "new_value": "The child removal was re-opened with the datafix ticket CJAMS-63719.","display_name": "Comments"}]}'::json, 'HISTORY', '8d919181-f927-4ec7-aa01-e9c58a66bbce'::uuid, '75e9dcb6-5e00-48b0-b154-9e6eee5baaff'::uuid, 'DIAMOND DADA', NULL, 'Mother (Biological)', NULL, '7104 AMBASSADOR RD  Salisbury MD 21801', NULL, NULL, NULL, NULL, 1, 'CJAMS-63719', now(), 'CJAMS-63719', now(), NULL, '194426', '5cec9659-168a-4bfc-b0c4-72fad38985e3'::uuid, NULL, '2019-01-02 00:00:00.000', NULL, 1712915, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Mother (Biological)', '293', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, NULL, '2019-01-02 15:00:00.000', NULL, '2019-01-07', NULL, 1, NULL, NULL, '3240974', NULL, NULL, NULL, 'JD', '62bd6e2f-5bf7-4237-b7a4-566cb40d2904'::uuid, NULL, NULL, NULL, NULL, 194426, NULL, NULL, NULL, '7104 AMBASSADOR RD  Salisbury MD 21801', NULL, 1, NULL, NULL, 0, '470df150-c32f-4557-b573-948ef990d081'::uuid, NULL, '2dce9d9e-04cf-44cf-a9cc-d66278d09a5d'::uuid, NULL, NULL, NULL, 1, ' ', NULL, NULL, NULL, NULL, 'Data Migration', '2020-06-20', '{"intakeservreqchildremovalid":"8d919181-f927-4ec7-aa01-e9c58a66bbce","familystructuretypekey":"293","environmentatremovalkey":"PAHOLD","agencytypekey":"AFH","isdisability":0,"removaltypekey":"JD","removaldate":"2019-01-02T00:00:00","exitdate":null,"exittime":null,"removaltime":"2019-01-02T20:00:00.000Z","rmvdfrmpersonname":"Mother (Biological)","primarycaregiveractorid":"62bd6e2f-5bf7-4237-b7a4-566cb40d2904","seccaregiveractorid":null,"removaladd1":"7104 AMBASSADOR RD  Salisbury MD 21801","vpabegindate":null,"vpaenddate":null,"vpaparentssigneddate":null,"parent2signeddate":null,"vpaguardiansigneddate":null,"parent1id":null,"parent2id":null,"guardianid":null,"vpa2parentssigneddate":null,"parent2sigmissreason":null,"primarycaregiveradd":"7104 AMBASSADOR RD  Salisbury MD 21801","ischildaddressasprimaryaddress":1,"childhomeaddress":null,"childphysicalremovaladdress":null,"ischildphysicalremovaladdressverified":null,"seccaregiveradd":null,"isverifiedcaregiver1add":1,"isverifiedcaregiver2add":null,"vpayouthsigneddate":null,"isbothparentssigned":null,"volrelinquishment":null,"agencysigneddate":null,"removalreason":["DAC","HG"],"removalexitreason":" ","transferagency":null,"otherpublicagency":null,"locationofadoption":null,"caregiverreason":["DAP"],"reasonableefforts":["REPERCH"],"notmakingefforts":null,"specifiedrelativename":null,"returndate":null,"returntime":null,"specifiedrelativedatechildlastlivedwith":null,"exitreason":null,"parent2comments":null,"comments":"Assisting with updating CJAMS for AFCARS.","reasonableeffortsmade":null,"isverifiedreporteradd":1,"placement":"","familyhistory":"","childdesc":null,"justification":"Assisting with updating CJAMS for AFCARS.","removalcircumstances":{"abandonment":null,"caretakeralcoholuse":null,"caretakerdruguse":null,"caretakersignificantimpairment":null,"caretakerignificantimpphysical":null,"childalcoholuse":null,"childbehaviorproblem":null,"childdruguse":null,"childrequestedplacement":null,"deathofcaretaker":null,"diagnosedcondition":null,"domesticviolence":null,"failuretoreturn":null,"familyconflict":null,"homelessness":null,"inadequateaccesstomhs":null,"inadequateaccesstomedicalservices":null,"inadequatehousing":null,"incarcerationofcaretaker":null,"medicalneglect":null,"neglect":true,"parentalimmigration":null,"physicalabuse":null,"prenatalalcoholexposure":null,"prenataldrugexposure":null,"psychologicalemotionalabuse":null,"publicagencytitleive":null,"runaway":null,"sexualabuse":null,"sextrafficking":null,"tribaltitleive":null,"voluntaryrelinquishment":null,"whereaboutsunknown":null},"familystructuretypekeyref":"Single Female","environmentAtRemovalkeyref":"Parent household","agencytypekeyref":"Agency Foster Home","removaltypekeyref":"Judicial Determination","primarycaregiveractoridref":"DIAMOND DADA - 1712915","seccaregiveractoridref":null,"parent1idref":null,"parent2idref":null,"removalreasonref":"Drug Abuse (Child), Neglect","removalexitreasonref":null,"reasonableeffortsref":", Reasonable efforts have been made but have been unsuccessful in preventing or eliminating the need for removal of child from childs home","notmakingeffortsref":"Imminent danger exists","isuploadedmanually":1,"isshelterauthcompleted":1}'::json, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


--Updating placement
update placement
set exittypekey = 'CIPS', updatedby = 'CJAMS-63719', updatedon = now()
where placementid = 'f98581c1-9bfd-405e-9dcc-0f1e7a4aaa1d' and activeflag = 1;

--Updating placementrevision
update placementrevision
set exittypekey = 'CIPS', updatedby = 'CJAMS-63719', updatedon = now()
where placementrevisionid = 'f98581c1-9bfd-405e-9dcc-0f1e7a4aaa1d' and activeflag = 1;