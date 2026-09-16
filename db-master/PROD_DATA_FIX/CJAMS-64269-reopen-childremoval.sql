/*
Issue: CJAMS-64269 Removal Tab
Category/Module: Child Removal
Root cause: User wanted to add new placement to the case 3275172 but couldn't do it as removal is endated by the placement Permanently Leaving Custody & Care.
            Data fix needed to re-open the child removal so that user can add a new placement.
Fix provided:  Data fix has been done to make following changes in the case
               Client ID: 200663261 (Luther Molock III)
               1) Remove the Child Removal End Date
               2) Remove the OOH Program End Date
               3) Update the Exit Type from Permanently Leaving Custody & Care to Change in Placement Structure.
Data/Code fix ticket#:  CJAMS-64269
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
*/



update intakeservreqchildremoval 
set exitdate = null,
	returntransts = null,
	returndate = null,
	returntime = null,
	removalexitreason = null,
    updatedby = 'CJAMS-62469',
    updatedon = now()
where intakeservreqchildremovalid='d2c8e0c5-f1cb-4d5e-a0ce-14afab9c1183'
and activeflag =1;


update personprogramarea 
set enddate = null, 
updatedby ='CJAMS-62469', 
updatedon = now()  
where personprogramid ='9ad9c248-9c2c-4735-b88d-6e1d3d4015a5' 
and activeflag = 1;


update tb_client_eligibility
set end_dt = null,
    update_user_id = 'CJAMS-62469',
    update_ts = now()
where removal_id = 254731
and delete_sw = 'N';

update placement  
set exittypekey = 'CIP', --	Change in Placement
    --exitreasontypekey = 'CIPO', -- Other
	remarks = 'Placement exit type changed to CIP  as the part of data fix ticket CJAMS-64269',
	updatedon = now(), 
	updatedby = 'CJAMS-64269'
where placementid = 'c753f205-3e3d-4f98-8b97-419b0b305ccf'
	and activeflag = 1 ;


update placementrevision 
set exitreasontypkey = 'CIP',
    --exittypekey = ''CIPO', -- Other 
    updatedon = now(), 
    updatedby = 'CJAMS-64269' 
where placementid ='c753f205-3e3d-4f98-8b97-419b0b305ccf' 
and activeflag =1;

INSERT INTO cjams.intakeservreqchildremoval_history
(intakeservreqchildremovalhistoryid, modifieddata, rowtype, intakeservreqchildremovalid, intakeserviceid, fathername, mothername, rmvdfrmpersonname, removalreasontypeid, removaladd1, removaladd2, removalzip, removalstatecd, removalcity, activeflag, insertedby, insertedon, updatedby, updatedon, agencytypekey, old_id, intakeservicerequestactorid, rmvdfrmisractorid, removaldate, parent2signeddate, primarycaregiverid, vpaparentssigneddate, vpadsssigneddate, dateoffindingctwdecision, childphysicaladdressafterremoval, nameofsubjectctwfinding, clientidofsubjectctwfinding, courtorderdelaytimeframe, reasonableeffortsnotnecessaryduetoemergentcircumstances, whoisresponsibleforplacementandcare, ctwdecision, relationshipofsubjectctwfinding, specifiedrelativedatechildlastlivedwith, specifiedrelativephysicaladdress, specifiedrelativename, specifiedrelativeclientid, specifiedrelativerelationshipid, sheltergranted, courtorderdelayremoval, magistrateorjudgename, typeofvpa, eavpaagreementflag, vpabegindate, ctwsanctioningchildremoval, childphysicalremovaldate, petitionfiledate, dateofremovalcourthearing, judgesigned, hearingdate, physicalremovalafterdetermination, removalcourtorderdate, childphysicalremovaladdress, specifiedrelativephysicaladdressafterremoval, dateofreasonableeffortscourthearing, reasonableeffortsmade, issafehavenbaby, returndate, childremovedfromtypekey, familystructuretypekey, "comments", vpastartdate, vpaenddate, childrelativelastdate, approvalstatustypekey, caseid, nocaregivercustodyflag, origremovalid, datavalidflag, clientmergeid, removaltime, returntime, removaltransts, returntransts, afcarseditapplyflag, parentssigntypekey, parent2comments, fk1_id, agencysigneddate, isbothparentssigned, childfactorsentry, removaltypekey, primarycaregiveractorid, vpachildsigneddate, vpayouthsigneddate, vpaguardiansigneddate, removalreasontypekey, removalid, exitdate, seccaregiveractorid, seccaregiveradd, primarycaregiveradd, isverifiedreporteradd, isverifiedcaregiver1add, isverifiedcaregiver2add, relativeactorid, isdisability, servicecaseid, assessmentid, personid, ischildphysicalremovaladdressverified, isuploadedmanually, isshelterauthcompleted, ischildaddressasprimaryaddress, removalexitreason, parent1id, parent2id, guardianid, volrelinquishment, etl_userid, etl_load_date, actualdata, removalcircumstances, transferagency, otherpublicagency, locationofadoption, justification, environmentatremovalkey, childremovalluggage, luggageprovided, placementdisposableortrashbag, luggagecomments, luggageupdatedby, luggageupdatedon, showcontactpage)
VALUES(gen_random_uuid(), '{"status": "Updated", "data": [ {"key": "comments","data_type": "text", "new_value": "the child removal was re-opened with the datafix ticket CJAMS-64269.","display_name": "Comments"}]}'::json, 'HISTORY', 'd2c8e0c5-f1cb-4d5e-a0ce-14afab9c1183'::uuid, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '65559999', NULL, NULL, 1, 'CJAMS-62469', 'now()', 'CJAMS-62469', 'now()', 'KHRF', NULL, 'dea47338-328c-4e08-9e8b-5f61b55fdb21'::uuid, NULL, '2022-10-06 00:00:00.000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '298', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-10-06 12:00:00.000', NULL, '2022-10-07', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'JD', 'cd4d7853-50d3-457a-ba34-20b8aa02613e'::uuid, NULL, NULL, NULL, NULL, 254731, NULL, NULL, NULL, '613 HUBERT ST, Cambridge, MD', 1, 1, 0, NULL, NULL, '0748589c-0706-4858-9342-e9b2101d6188'::uuid, NULL, 'b82382f7-3a71-4c15-aad9-f3ee1ae4a772'::uuid, NULL, 0, 0, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{"intakeservreqchildremovalid":null,"familystructuretypekey":"298","agencytypekey":"KHRF","isdisability":null,"removaltypekey":"JD","removaldate":"10/06/2022","exitdate":null,"exittime":null,"removaltime":"2022-10-07T16:00:45.464Z","rmvdfrmpersonname":null,"primarycaregiveractorid":"cd4d7853-50d3-457a-ba34-20b8aa02613e","seccaregiveractorid":null,"removaladd1":null,"vpabegindate":null,"vpaenddate":null,"vpaparentssigneddate":null,"parent2signeddate":null,"vpaguardiansigneddate":null,"parent1id":null,"parent2id":null,"guardianid":null,"vpa2parentssigneddate":null,"parent2sigmissreason":null,"primarycaregiveradd":"613 HUBERT ST, Cambridge, MD","ischildaddressasprimaryaddress":2,"childhomeaddress":null,"childphysicalremovaladdress":null,"ischildphysicalremovaladdressverified":null,"seccaregiveradd":null,"isverifiedcaregiver1add":1,"isverifiedcaregiver2add":null,"vpayouthsigneddate":null,"isbothparentssigned":null,"volrelinquishment":null,"agencysigneddate":null,"removalreason":["DAP","HG"],"removalexitreason":null,"transferagency":null,"otherpublicagency":null,"locationofadoption":null,"caregiverreason":null,"reasonableefforts":["FPS","FSS"],"notmakingefforts":null,"specifiedrelativename":null,"returndate":null,"returntime":null,"specifiedrelativedatechildlastlivedwith":null,"exitreason":null,"parent2comments":null,"comments":null,"reasonableeffortsmade":null,"isverifiedreporteradd":null,"placement":null,"familyhistory":null,"childdesc":null,"justification":null,"removalcircumstances":{"abandonment":null,"caretakeralcoholuse":null,"caretakerdruguse":null,"caretakersignificantimpairment":null,"caretakerignificantimpphysical":null,"childalcoholuse":null,"childbehaviorproblem":null,"childdruguse":null,"childrequestedplacement":null,"deathofcaretaker":null,"diagnosedcondition":null,"domesticviolence":null,"failuretoreturn":null,"familyconflict":null,"homelessness":null,"inadequateaccesstomhs":null,"inadequateaccesstomedicalservices":null,"inadequatehousing":null,"incarcerationofcaretaker":null,"medicalneglect":null,"neglect":null,"parentalimmigration":null,"physicalabuse":null,"prenatalalcoholexposure":null,"prenataldrugexposure":null,"psychologicalemotionalabuse":null,"publicagencytitleive":null,"runaway":null,"sexualabuse":null,"sextrafficking":null,"tribaltitleive":null,"voluntaryrelinquishment":null,"whereaboutsunknown":null},"familystructuretypekeyref":"Unmarried Couple","agencytypekeyref":"Kinship Home (Relative or ‘Fictive Kin’)","removaltypekeyref":"Judicial Determination","primarycaregiveractoridref":"RAJAME COOPER - 1054198","seccaregiveractoridref":null,"parent1idref":null,"parent2idref":null,"removalreasonref":"Drug Abuse (Parent), Neglect","removalexitreasonref":null,"reasonableeffortsref":", Family Preservation Services, Family Support Services","notmakingeffortsref":null,"isuploadedmanually":null,"isshelterauthcompleted":0}'::json, '{"abandonment":null,"caretakeralcoholuse":null,"caretakerdruguse":null,"caretakersignificantimpairment":null,"caretakerignificantimpphysical":null,"childalcoholuse":null,"childbehaviorproblem":null,"childdruguse":null,"childrequestedplacement":null,"deathofcaretaker":null,"diagnosedcondition":null,"domesticviolence":null,"failuretoreturn":null,"familyconflict":null,"homelessness":null,"inadequateaccesstomhs":null,"inadequateaccesstomedicalservices":null,"inadequatehousing":null,"incarcerationofcaretaker":null,"medicalneglect":null,"neglect":null,"parentalimmigration":null,"physicalabuse":null,"prenatalalcoholexposure":null,"prenataldrugexposure":null,"psychologicalemotionalabuse":null,"publicagencytitleive":null,"runaway":null,"sexualabuse":null,"sextrafficking":null,"tribaltitleive":null,"voluntaryrelinquishment":null,"whereaboutsunknown":null}'::json, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
