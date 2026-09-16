/*
Issue Description:CJAMS-63813 breaking the link/placement closed
Category/Module: Placement 
Root cause:This is not a defect. As per system design and policy, the child must be placed with the provider placement and pre-finalized adoptive home placement structure to complete the adoption break the link.
           Data fix needed for the following issues
Removal end date needs to be removed for user to create a placment Need placement to complete GAP Screen
            We need to do data fix for the case and client 
            1) Remove the Child Removal End Date
            2) Remove the OOH Program Assignment End Date
            Client ID: 200850353 (Tyson Colbert)
            Child Removal End Date: 11/21/2025
Fix provided: Data fix has been done to remove the  remove the child removal end date and OOH Program assignment date.
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
    updatedby = 'CJAMS-63813',
    updatedon = now()
where intakeservreqchildremovalid='c77c3222-6724-4403-8657-1c1182b3ac21'
and activeflag =1;

update personprogramarea 
set enddate = null, 
updatedby ='CJAMS-63813', 
updatedon = now()  
where personprogramid ='0bd65f47-ef95-40a4-81a6-0f53569b6c97' 
and activeflag = 1;

update tb_client_eligibility
set end_dt = null,
    update_user_id = 'CJAMS-63813',
    update_ts = now()
where removal_id = 253335
and delete_sw = 'N';

INSERT INTO cjams.intakeservreqchildremoval_history
(intakeservreqchildremovalhistoryid, modifieddata, rowtype, intakeservreqchildremovalid, intakeserviceid, fathername, mothername, rmvdfrmpersonname, removalreasontypeid, removaladd1, removaladd2, removalzip, removalstatecd, removalcity, activeflag, insertedby, insertedon, updatedby, updatedon, agencytypekey, old_id, intakeservicerequestactorid, rmvdfrmisractorid, removaldate, parent2signeddate, primarycaregiverid, vpaparentssigneddate, vpadsssigneddate, dateoffindingctwdecision, childphysicaladdressafterremoval, nameofsubjectctwfinding, clientidofsubjectctwfinding, courtorderdelaytimeframe, reasonableeffortsnotnecessaryduetoemergentcircumstances, whoisresponsibleforplacementandcare, ctwdecision, relationshipofsubjectctwfinding, specifiedrelativedatechildlastlivedwith, specifiedrelativephysicaladdress, specifiedrelativename, specifiedrelativeclientid, specifiedrelativerelationshipid, sheltergranted, courtorderdelayremoval, magistrateorjudgename, typeofvpa, eavpaagreementflag, vpabegindate, ctwsanctioningchildremoval, childphysicalremovaldate, petitionfiledate, dateofremovalcourthearing, judgesigned, hearingdate, physicalremovalafterdetermination, removalcourtorderdate, childphysicalremovaladdress, specifiedrelativephysicaladdressafterremoval, dateofreasonableeffortscourthearing, reasonableeffortsmade, issafehavenbaby, returndate, childremovedfromtypekey, familystructuretypekey, "comments", vpastartdate, vpaenddate, childrelativelastdate, approvalstatustypekey, caseid, nocaregivercustodyflag, origremovalid, datavalidflag, clientmergeid, removaltime, returntime, removaltransts, returntransts, afcarseditapplyflag, parentssigntypekey, parent2comments, fk1_id, agencysigneddate, isbothparentssigned, childfactorsentry, removaltypekey, primarycaregiveractorid, vpachildsigneddate, vpayouthsigneddate, vpaguardiansigneddate, removalreasontypekey, removalid, exitdate, seccaregiveractorid, seccaregiveradd, primarycaregiveradd, isverifiedreporteradd, isverifiedcaregiver1add, isverifiedcaregiver2add, relativeactorid, isdisability, servicecaseid, assessmentid, personid, ischildphysicalremovaladdressverified, isuploadedmanually, isshelterauthcompleted, ischildaddressasprimaryaddress, removalexitreason, parent1id, parent2id, guardianid, volrelinquishment, etl_userid, etl_load_date, actualdata, removalcircumstances, transferagency, otherpublicagency, locationofadoption, justification, environmentatremovalkey, childremovalluggage, luggageprovided, placementdisposableortrashbag, luggagecomments, luggageupdatedby, luggageupdatedon, showcontactpage)
VALUES(gen_random_uuid(), '{"status": "Updated", "data": [ {"key": "comments","data_type": "text", "new_value": "The child removal was re-opened with the datafix ticket CJAMS-63813.","display_name": "Comments"}]}'::json, 'HISTORY', 'c77c3222-6724-4403-8657-1c1182b3ac21'::uuid, NULL, NULL, NULL, NULL, NULL, 'Harbor Hospital', NULL, '65559999', NULL, NULL, 1, 'CJAMS-63813', now(), 'CJAMS-63813', now(), 'AFH', NULL, 'd308a7f7-c913-4ca7-aee4-7abb9269b043'::uuid, NULL, '2021-12-27 00:00:00.000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '290', 'Mother tested positive for marijuana and cocaine at the time of her sons birth. Mother has extensive CPS hx and several other children that are committed to the Department.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2021-12-27 13:30:00.000', NULL, '2021-12-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'JD', 'dd1f839e-3f24-4846-bba6-0fbc4c954fa2'::uuid, NULL, NULL, NULL, NULL, 253335, NULL, '80a37aac-6e1f-4733-8777-28f0ac5283c2'::uuid, 'Unknown', 'Unknown', 1, 1, 1, NULL, NULL, 'f575b206-2461-4917-b479-f308839613bb'::uuid, NULL, '79dd905f-19ba-4b14-b957-dc0c41fcc9e1'::uuid, NULL, 1, 1, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{"intakeservreqchildremovalid":null,"familystructuretypekey":"290","agencytypekey":"AFH","isdisability":null,"removaltypekey":"JD","removaldate":"12/27/2021","exitdate":null,"exittime":null,"removaltime":"2021-12-27T18:30:38.373Z","rmvdfrmpersonname":null,"primarycaregiveractorid":"dd1f839e-3f24-4846-bba6-0fbc4c954fa2","seccaregiveractorid":"80a37aac-6e1f-4733-8777-28f0ac5283c2","removaladd1":"Harbor Hospital","vpabegindate":null,"vpaenddate":null,"vpaparentssigneddate":null,"parent2signeddate":null,"vpaguardiansigneddate":null,"parent1id":null,"parent2id":null,"guardianid":null,"vpa2parentssigneddate":null,"parent2sigmissreason":null,"primarycaregiveradd":"Unknown","ischildaddressasprimaryaddress":2,"childhomeaddress":null,"childphysicalremovaladdress":null,"ischildphysicalremovaladdressverified":null,"seccaregiveradd":"Unknown","isverifiedcaregiver1add":1,"isverifiedcaregiver2add":1,"vpayouthsigneddate":null,"isbothparentssigned":null,"volrelinquishment":null,"agencysigneddate":null,"removalreason":["DAP","HG"],"removalexitreason":null,"caregiverreason":null,"reasonableefforts":["INCC","PEA","REPERCH","READAS","REMNH","SES","SUO"],"notmakingefforts":null,"specifiedrelativename":null,"returndate":null,"returntime":null,"specifiedrelativedatechildlastlivedwith":null,"exitreason":null,"parent2comments":null,"comments":"Mother tested positive for marijuana and cocaine at the time of her sons birth. Mother has extensive CPS hx and several other children that are committed to the Department.","reasonableeffortsmade":null,"isverifiedreporteradd":1,"placement":null,"familyhistory":null,"childdesc":null,"justification":null,"familystructuretypekeyref":"Married Couple","agencytypekeyref":"Agency Foster Home","removaltypekeyref":"Judicial Determination","primarycaregiveractoridref":"TRESHAWNA MARIA COLBERT - 1437794","seccaregiveractoridref":"RAYMOND R COLBERT - 1418638","parent1idref":null,"parent2idref":null,"removalreasonref":"Drug Abuse (Parent), Neglect","removalexitreasonref":null,"reasonableeffortsref":", Individual Crisis Counseling, Parenting Education and Assistance, Reasonable efforts have been made but have been unsuccessful in preventing or eliminating the need for removal of child from childs home, Routine/Emergency Alcohol or Drug Abuse Services, Routine/Emergency Mental Health, Social/Emotional Support, Supervision/Observation","notmakingeffortsref":null,"isuploadedmanually":1,"isshelterauthcompleted":1}'::json, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
