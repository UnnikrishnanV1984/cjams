/*
Issue Description:CJAMS-65026 
Category/Module: Placement 
Root cause: User requested to do following data fixes in the case 3286395:
	1. Remove the Child Removal End Date
	2. Remove the OOH program End Date
	3. Update the Placement Exit Type from Permanently Leaving Custody & Care to Change in Placement Structure.

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
    updatedby = 'CJAMS-65026',
    updatedon = now()
where intakeservreqchildremovalid='6c01badd-dc13-4eee-b841-11df5ff40669'
and activeflag =1;


update personprogramarea 
set enddate = null, 
updatedby ='CJAMS-65026', 
updatedon = now()  
where personprogramid ='4eca71f7-e9ec-4d22-8495-041f38857c6d' 
and activeflag = 1;

update tb_client_eligibility
set end_dt = null,
    update_user_id = 'CJAMS-65026',
    update_ts = now()
where removal_id = 254849
and delete_sw = 'N';

INSERT INTO cjams.intakeservreqchildremoval_history
(modifieddata, 
rowtype, intakeservreqchildremovalid, intakeserviceid, fathername, mothername, rmvdfrmpersonname, removalreasontypeid, removaladd1, removaladd2, removalzip, removalstatecd, removalcity, activeflag, insertedby, insertedon, updatedby, updatedon, agencytypekey, old_id, intakeservicerequestactorid, rmvdfrmisractorid, removaldate, parent2signeddate, primarycaregiverid, vpaparentssigneddate, vpadsssigneddate, dateoffindingctwdecision, childphysicaladdressafterremoval, nameofsubjectctwfinding, clientidofsubjectctwfinding, courtorderdelaytimeframe, reasonableeffortsnotnecessaryduetoemergentcircumstances, whoisresponsibleforplacementandcare, ctwdecision, relationshipofsubjectctwfinding, specifiedrelativedatechildlastlivedwith, specifiedrelativephysicaladdress, specifiedrelativename, specifiedrelativeclientid, specifiedrelativerelationshipid, sheltergranted, courtorderdelayremoval, magistrateorjudgename, typeofvpa, eavpaagreementflag, vpabegindate, ctwsanctioningchildremoval, childphysicalremovaldate, petitionfiledate, dateofremovalcourthearing, judgesigned, hearingdate, physicalremovalafterdetermination, removalcourtorderdate, childphysicalremovaladdress, specifiedrelativephysicaladdressafterremoval, dateofreasonableeffortscourthearing, reasonableeffortsmade, issafehavenbaby, returndate, childremovedfromtypekey, familystructuretypekey, "comments", vpastartdate, vpaenddate, childrelativelastdate, approvalstatustypekey, caseid, nocaregivercustodyflag, origremovalid, datavalidflag, clientmergeid, removaltime, returntime, removaltransts, returntransts, afcarseditapplyflag, parentssigntypekey, parent2comments, fk1_id, agencysigneddate, isbothparentssigned, childfactorsentry, removaltypekey, primarycaregiveractorid, vpachildsigneddate, vpayouthsigneddate, vpaguardiansigneddate, removalreasontypekey, removalid, exitdate, seccaregiveractorid, seccaregiveradd, primarycaregiveradd, isverifiedreporteradd, isverifiedcaregiver1add, isverifiedcaregiver2add, relativeactorid, isdisability, servicecaseid, assessmentid, personid, ischildphysicalremovaladdressverified, isuploadedmanually, isshelterauthcompleted, ischildaddressasprimaryaddress, removalexitreason, parent1id, parent2id, guardianid, volrelinquishment, etl_userid, etl_load_date, actualdata, removalcircumstances, transferagency, otherpublicagency, locationofadoption, justification, environmentatremovalkey, childremovalluggage, luggageprovided, placementdisposableortrashbag, luggagecomments, luggageupdatedby, luggageupdatedon, showcontactpage)
VALUES('{"status": "Updated", "data": [ {"key": "comments","data_type": "text", "new_value": "the child removal was re-opened with the datafix ticket CJAMS-65026.","display_name": "Comments"}]}'::json, 
'HISTORY', '6c01badd-dc13-4eee-b841-11df5ff40669'::uuid, NULL, NULL, NULL, NULL, NULL, '2623 N EVERLY DR, Frederick, MD', NULL, '65559999', NULL, NULL, 1, 'CJAMS-65026', now(), 'CJAMS-65026', now(), 'AFH', NULL, 'ae9f6d5e-b548-4fd7-8864-e0e469bc538c'::uuid, NULL, '2022-11-11 00:00:00.000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-11-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '295', 'Child has been in maternal grandfather''s custody since age 2. Grandfather had a stroke and was unable to care for the child. He entered into a time limited voluntary placement agreement.', NULL, '2023-05-09 00:00:00.000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-11-11 18:00:00.000', '2025-12-22 11:30:00.000', '2022-11-14', NULL, NULL, NULL, NULL, NULL, '2022-11-11 00:00:00.000', 2, NULL, 'TLV', '401495d6-790d-4f28-af29-c43cbe5241dc'::uuid, NULL, NULL, '2022-11-11', NULL, 254849, NULL, NULL, NULL, '2623 N EVERLY DR, Frederick, MD', 1, 1, 0, NULL, NULL, '5969d797-34c8-4e22-b0b4-a4b412e94054'::uuid, NULL, '619b5bba-0158-4eb2-adf7-696e5e0b6eca'::uuid, NULL, 1, 1, 1, NULL, NULL, NULL, 4215586, 1, NULL, NULL, '{"intakeservreqchildremovalid":"6c01badd-dc13-4eee-b841-11df5ff40669","familystructuretypekey":"295","environmentatremovalkey":"RELHLD","agencytypekey":"AFH","isdisability":null,"removaltypekey":"TLV","removaldate":"2022-11-11T00:00:00","exitdate":null,"exittime":null,"removaltime":"2022-11-11T23:00:00.000Z","rmvdfrmpersonname":null,"primarycaregiveractorid":"401495d6-790d-4f28-af29-c43cbe5241dc","seccaregiveractorid":null,"removaladd1":"2623 N EVERLY DR, Frederick, MD","vpabegindate":"2022-11-11","vpaenddate":"2023-05-09T00:00:00","vpaparentssigneddate":null,"parent2signeddate":null,"vpaguardiansigneddate":"2022-11-11","parent1id":null,"parent2id":null,"guardianid":4215586,"vpa2parentssigneddate":null,"parent2sigmissreason":null,"primarycaregiveradd":"2623 N EVERLY DR, Frederick, MD","ischildaddressasprimaryaddress":1,"childhomeaddress":null,"childphysicalremovaladdress":null,"ischildphysicalremovaladdressverified":null,"seccaregiveradd":null,"isverifiedcaregiver1add":1,"isverifiedcaregiver2add":null,"vpayouthsigneddate":null,"isbothparentssigned":2,"volrelinquishment":1,"agencysigneddate":"2022-11-11T00:00:00","removalreason":["CIIO"],"removalexitreason":null,"transferagency":null,"otherpublicagency":null,"locationofadoption":null,"caregiverreason":null,"reasonableefforts":["NREM"],"notmakingefforts":["SIE"],"specifiedrelativename":null,"returndate":null,"returntime":null,"specifiedrelativedatechildlastlivedwith":null,"exitreason":null,"parent2comments":null,"comments":"Child has been in maternal grandfather''s custody since age 2. Grandfather had a stroke and was unable to care for the child. He entered into a time limited voluntary placement agreement.","reasonableeffortsmade":null,"isverifiedreporteradd":1,"placement":"","familyhistory":"","childdesc":null,"justification":"Child has been in maternal grandfather''s custody since age 2. Grandfather had a stroke and was unable to care for the child. He entered into a time limited voluntary placement agreement.","removalcircumstances":{"abandonment":false,"caretakeralcoholuse":false,"caretakerdruguse":false,"caretakersignificantimpairment":false,"caretakerignificantimpphysical":false,"childalcoholuse":false,"childbehaviorproblem":false,"childdruguse":false,"childrequestedplacement":false,"deathofcaretaker":false,"diagnosedcondition":false,"domesticviolence":false,"failuretoreturn":false,"familyconflict":false,"homelessness":false,"inadequateaccesstomhs":false,"inadequateaccesstomedicalservices":false,"inadequatehousing":false,"incarcerationofcaretaker":false,"medicalneglect":false,"neglect":false,"parentalimmigration":false,"physicalabuse":false,"prenatalalcoholexposure":false,"prenataldrugexposure":false,"psychologicalemotionalabuse":false,"publicagencytitleive":false,"runaway":false,"sexualabuse":false,"sextrafficking":false,"tribaltitleive":false,"voluntaryrelinquishment":false,"whereaboutsunknown":false},"familystructuretypekeyref":"Single Male","environmentAtRemovalkeyref":"Relative household","agencytypekeyref":"Agency Foster Home","removaltypekeyref":"Time-limited Voluntary Placement","primarycaregiveractoridref":"ALVA EDISON THOMPSON Jr. - 4215586","seccaregiveractoridref":null,"parent1idref":null,"parent2idref":null,"removalreasonref":"Caregiver''s Inability to Cope Due to Illness or Other Reason","removalexitreasonref":null,"reasonableeffortsref":", Due to the Emergent Nature of the Situation, Reasonable Efforts could not be made","notmakingeffortsref":"Safety Influences exists and can not be controlled with an in-home safety plan","isuploadedmanually":1,"isshelterauthcompleted":1}'::json, '{"abandonment":false,"caretakeralcoholuse":false,"caretakerdruguse":false,"caretakersignificantimpairment":false,"caretakerignificantimpphysical":false,"childalcoholuse":false,"childbehaviorproblem":false,"childdruguse":false,"childrequestedplacement":false,"deathofcaretaker":false,"diagnosedcondition":false,"domesticviolence":false,"failuretoreturn":false,"familyconflict":false,"homelessness":false,"inadequateaccesstomhs":false,"inadequateaccesstomedicalservices":false,"inadequatehousing":false,"incarcerationofcaretaker":false,"medicalneglect":false,"neglect":false,"parentalimmigration":false,"physicalabuse":false,"prenatalalcoholexposure":false,"prenataldrugexposure":false,"psychologicalemotionalabuse":false,"publicagencytitleive":false,"runaway":false,"sexualabuse":false,"sextrafficking":false,"tribaltitleive":false,"voluntaryrelinquishment":false,"whereaboutsunknown":false}'::json, NULL, NULL, NULL, NULL, 'RELHLD', true, NULL, NULL, NULL, 'Marquia Coleman', '2025-12-23 12:45:55.540', NULL);

update placement 
set exittypekey = 'CIPS', 
    updatedon = now(), 
    updatedby = 'CJAMS-65026'
where placementid = '5127b3b8-82a4-42a9-b0c4-a205ad0c67f9'
and intakeservreqchildremovalid = '6c01badd-dc13-4eee-b841-11df5ff40669'
and activeflag = 1;

update placementrevision 
set exittypekey = 'CIPS', 
    updatedon = now(), 
    updatedby = 'CJAMS-65026' 
where placementid = '5127b3b8-82a4-42a9-b0c4-a205ad0c67f9'
and placementrevisionid = '522957b7-8675-4e98-b119-7ac910915654' 
and activeflag =1;