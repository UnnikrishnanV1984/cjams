/*
Issue: CJAMS-64417 Removal needs to be re-opened
Category/Module: Child Removal
Root cause: This is not a defect as the Removal was end dated by the system due to placement exit reason is Permanently Leaving Custody & Care.
            Client ID: 200989586 (Meilyn Rivas Bonilla)
            Data fix needed to do the following changes
            1) Remove the removal end date
            2) Remove the OOH program assignment end date
            3) Update the Placement Exit Type from Permanently Leaving Custody & Care to Change in Placement Structure.
Fix provided:  Data fix has been done to remova the removal end data, Remove the OOH program assignment data and change the exit type to Change in Placement structure.
Data/Code fix ticket#: CJAMS-64417
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error. He closed the placement with reason Permanently Leaving custoday and Care which endate the child removal. 
*/


update intakeservreqchildremoval 
set exitdate = null,
	returntransts = null,
	returndate = null,
	returntime = null,
	removalexitreason = null,
    updatedby = 'CJAMS-64417',
    updatedon = now()
where intakeservreqchildremovalid='ce5a5db6-9065-44f4-b7ff-0e8ab0e290f6'
and activeflag =1;



update personprogramarea 
set enddate = null, 
updatedby ='CJAMS-64417', 
updatedon = now()  
where personprogramid ='fcd95234-bb39-4e6d-943b-6ae3267d05ee' 
and activeflag = 1;


update placement  
set exittypekey = 'CIP', --	Change in Placement
    remarks = 'Placement Exited as the part of data fix ticket CJAMS-64417',
	updatedon = now(), 
	updatedby = 'CJAMS-64417'
where placementid = '1f5af3c6-78ea-44a5-baba-33432d7c0a08'
	and activeflag = 1 ;


update placementrevision 
set exittypekey = 'CIP', --	Change in Placement
    remarks = 'Placement Exited as the part of data fix ticket CJAMS-64417',
	updatedon = now(), 
	updatedby = 'CJAMS-64417'
where placementid = '1f5af3c6-78ea-44a5-baba-33432d7c0a08'
	and activeflag = 1 ;


update tb_client_eligibility
set end_dt = null,
    update_user_id = 'CJAMS-64417',
    update_ts = now()
where removal_id = 364440
and delete_sw = 'N';


INSERT INTO cjams.intakeservreqchildremoval_history
(intakeservreqchildremovalhistoryid, modifieddata, rowtype, intakeservreqchildremovalid, intakeserviceid, fathername, mothername, rmvdfrmpersonname, removalreasontypeid, removaladd1, removaladd2, removalzip, removalstatecd, removalcity, activeflag, insertedby, insertedon, updatedby, updatedon, agencytypekey, old_id, intakeservicerequestactorid, rmvdfrmisractorid, removaldate, parent2signeddate, primarycaregiverid, vpaparentssigneddate, vpadsssigneddate, dateoffindingctwdecision, childphysicaladdressafterremoval, nameofsubjectctwfinding, clientidofsubjectctwfinding, courtorderdelaytimeframe, reasonableeffortsnotnecessaryduetoemergentcircumstances, whoisresponsibleforplacementandcare, ctwdecision, relationshipofsubjectctwfinding, specifiedrelativedatechildlastlivedwith, specifiedrelativephysicaladdress, specifiedrelativename, specifiedrelativeclientid, specifiedrelativerelationshipid, sheltergranted, courtorderdelayremoval, magistrateorjudgename, typeofvpa, eavpaagreementflag, vpabegindate, ctwsanctioningchildremoval, childphysicalremovaldate, petitionfiledate, dateofremovalcourthearing, judgesigned, hearingdate, physicalremovalafterdetermination, removalcourtorderdate, childphysicalremovaladdress, specifiedrelativephysicaladdressafterremoval, dateofreasonableeffortscourthearing, reasonableeffortsmade, issafehavenbaby, returndate, childremovedfromtypekey, familystructuretypekey, "comments", vpastartdate, vpaenddate, childrelativelastdate, approvalstatustypekey, caseid, nocaregivercustodyflag, origremovalid, datavalidflag, clientmergeid, removaltime, returntime, removaltransts, returntransts, afcarseditapplyflag, parentssigntypekey, parent2comments, fk1_id, agencysigneddate, isbothparentssigned, childfactorsentry, removaltypekey, primarycaregiveractorid, vpachildsigneddate, vpayouthsigneddate, vpaguardiansigneddate, removalreasontypekey, removalid, exitdate, seccaregiveractorid, seccaregiveradd, primarycaregiveradd, isverifiedreporteradd, isverifiedcaregiver1add, isverifiedcaregiver2add, relativeactorid, isdisability, servicecaseid, assessmentid, personid, ischildphysicalremovaladdressverified, isuploadedmanually, isshelterauthcompleted, ischildaddressasprimaryaddress, removalexitreason, parent1id, parent2id, guardianid, volrelinquishment, etl_userid, etl_load_date, actualdata, removalcircumstances, transferagency, otherpublicagency, locationofadoption, justification, environmentatremovalkey, childremovalluggage, luggageprovided, placementdisposableortrashbag, luggagecomments, luggageupdatedby, luggageupdatedon, showcontactpage)
VALUES(gen_random_uuid(), '{"status": "Updated", "data": [ {"key": "comments","data_type": "text", "new_value": "the child removal was re-opened with the datafix ticket CJAMS-64417.","display_name": "Comments"}]}', 'HISTORY', 'ce5a5db6-9065-44f4-b7ff-0e8ab0e290f6', NULL, NULL, NULL, NULL, NULL, '13266 Musicmaster Dr, Silver Spring, MD', NULL, '65559999', NULL, NULL, 1, 'CJAMS-64417', 'now()', 'CJAMS-64417', 'now()', 'PTFH', NULL, '219b3f57-97c4-4922-a274-776b449bd6c3', NULL, '2025-10-02 00:00:00.000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Child had been safety planned with father due to sexual abuse by step-father while under mothers care. However child recently returned to mother''s care in violation of the safety plan and mother stopped cooperating with the Department and stopped child''s trauma therapy.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-10-02 13:30:00.000', NULL, '2025-10-03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'JD', '5a743ddb-bbdd-4459-bce9-12d2e2bba0f1', NULL, NULL, NULL, NULL, 364440, NULL, 'a23a0975-fb9f-42ba-9d70-e465cb45e9ee', '1210 Raydale Rd, Hyattsville, MD', '13266 Musicmaster Dr, Silver Spring, MD', 1, 1, 1, NULL, NULL, 'ea461ea1-0ab8-4613-af1b-b085f8435177', NULL, '989432ef-6a2c-4ab1-ac36-4a27283cc009', NULL, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{"intakeservreqchildremovalid":null,"familystructuretypekey":null,"environmentatremovalkey":"PAHOLD","agencytypekey":"PTFH","isdisability":null,"removaltypekey":"JD","removaldate":"10/02/2025","exitdate":null,"exittime":null,"removaltime":"2025-10-03T17:30:54.138Z","rmvdfrmpersonname":null,"primarycaregiveractorid":"5a743ddb-bbdd-4459-bce9-12d2e2bba0f1","seccaregiveractorid":"a23a0975-fb9f-42ba-9d70-e465cb45e9ee","removaladd1":"13266 Musicmaster Dr, Silver Spring, MD","vpabegindate":null,"vpaenddate":null,"vpaparentssigneddate":null,"parent2signeddate":null,"vpaguardiansigneddate":null,"parent1id":null,"parent2id":null,"guardianid":null,"vpa2parentssigneddate":null,"parent2sigmissreason":null,"primarycaregiveradd":"13266 Musicmaster Dr, Silver Spring, MD","ischildaddressasprimaryaddress":1,"childhomeaddress":null,"childphysicalremovaladdress":null,"ischildphysicalremovaladdressverified":null,"seccaregiveradd":"1210 Raydale Rd, Hyattsville, MD","isverifiedcaregiver1add":1,"isverifiedcaregiver2add":1,"vpayouthsigneddate":null,"isbothparentssigned":null,"volrelinquishment":null,"agencysigneddate":null,"removalreason":null,"removalexitreason":null,"transferagency":null,"otherpublicagency":null,"locationofadoption":null,"caregiverreason":null,"reasonableefforts":["FSS","INCC","REPERCH","REMNH"],"notmakingefforts":null,"specifiedrelativename":null,"returndate":null,"returntime":null,"specifiedrelativedatechildlastlivedwith":null,"exitreason":null,"parent2comments":null,"comments":"Child had been safety planned with father due to sexual abuse by step-father while under mothers care. However child recently returned to mother''s care in violation of the safety plan and mother stopped cooperating with the Department and stopped child''s trauma therapy.","reasonableeffortsmade":null,"isverifiedreporteradd":1,"placement":null,"familyhistory":null,"childdesc":null,"justification":null,"removalcircumstances":{"abandonment":null,"caretakeralcoholuse":null,"caretakerdruguse":null,"caretakersignificantimpairment":null,"caretakerignificantimpphysical":null,"childalcoholuse":null,"childbehaviorproblem":null,"childdruguse":null,"childrequestedplacement":null,"deathofcaretaker":null,"diagnosedcondition":null,"domesticviolence":null,"failuretoreturn":null,"familyconflict":null,"homelessness":null,"inadequateaccesstomhs":null,"inadequateaccesstomedicalservices":null,"inadequatehousing":null,"incarcerationofcaretaker":null,"medicalneglect":null,"neglect":null,"parentalimmigration":null,"physicalabuse":null,"prenatalalcoholexposure":null,"prenataldrugexposure":null,"psychologicalemotionalabuse":null,"publicagencytitleive":null,"runaway":null,"sexualabuse":null,"sextrafficking":null,"tribaltitleive":null,"voluntaryrelinquishment":null,"whereaboutsunknown":null},"familystructuretypekeyref":null,"environmentAtRemovalkeyref":"Parent household","agencytypekeyref":"Private Treatment Foster Home","removaltypekeyref":"Judicial Determination","primarycaregiveractoridref":"Yeni Carolina Bonilla Medrano - 200989580","seccaregiveractoridref":"Oscar Ernesto Rivas Campos - 204183129","parent1idref":null,"parent2idref":null,"removalreasonref":null,"removalexitreasonref":null,"reasonableeffortsref":", Family Support Services, Individual Crisis Counseling, Reasonable efforts have been made but have been unsuccessful in preventing or eliminating the need for removal of child from childs home, Routine/Emergency Mental Health","notmakingeffortsref":null,"isuploadedmanually":1,"isshelterauthcompleted":1,"luggagecomments":""}', '{"abandonment":null,"caretakeralcoholuse":null,"caretakerdruguse":null,"caretakersignificantimpairment":null,"caretakerignificantimpphysical":null,"childalcoholuse":null,"childbehaviorproblem":null,"childdruguse":null,"childrequestedplacement":null,"deathofcaretaker":null,"diagnosedcondition":null,"domesticviolence":null,"failuretoreturn":null,"familyconflict":null,"homelessness":null,"inadequateaccesstomhs":null,"inadequateaccesstomedicalservices":null,"inadequatehousing":null,"incarcerationofcaretaker":null,"medicalneglect":null,"neglect":null,"parentalimmigration":null,"physicalabuse":null,"prenatalalcoholexposure":null,"prenataldrugexposure":null,"psychologicalemotionalabuse":null,"publicagencytitleive":null,"runaway":null,"sexualabuse":null,"sextrafficking":null,"tribaltitleive":null,"voluntaryrelinquishment":null,"whereaboutsunknown":null}', NULL, NULL, NULL, NULL, 'PAHOLD', false, false, false, NULL, NULL, NULL, false);
