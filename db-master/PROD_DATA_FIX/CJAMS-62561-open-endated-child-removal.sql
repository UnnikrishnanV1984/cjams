/*
Issue Description: CJAMS-62561 break the link
Category/Module: Child removal 
Root cause: As per system design, the child must be placed with the placement structure as Pre-Finalized Adoptive Home to complete the adoption break the link.
            In this case, the child is placed with the private provider and placement structure is selected as Treatment Foster Care (Private)
            Client ID: 4490727
            Provider ID: 5000487 (Arrow Child & Family - CPA TFC Baltimore)
            Need a data fix to do the following in order to break the link
            1) Remove the Child Removal End Date for client ID# 4105995 (AMY FLORESVISCARRA) and ID# 4490727 (PATRICK K PORTILLOFLORES)
            2) Remove the OOH Program Assignment End Date for client ID# 4105995 (AMY FLORESVISCARRA) and ID# 4490727 (PATRICK K PORTILLOFLORES)
Fix provided: Data fix done to make following changes for
              Client ID: 4105995 , 4490727
              Case ID: 3278452
              so that break the link can be completed.
              Removed the Child Removal End Date for client ID# 4105995 (AMY FLORESVISCARRA) and ID# 4490727 (PATRICK K PORTILLOFLORES)
              Remove the OOH Program Assignment End Date for client ID# 4105995 (AMY FLORESVISCARRA) and ID# 4490727 (PATRICK K PORTILLOFLORES)
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix:This is a per the system design and we need data fix to resolve it.
*/


update intakeservreqchildremoval 
set exitdate = null,
    returntransts = null,
    returntime = null,
    returndate = null,
    removalexitreason = null,
    updatedby = 'CJAMS-62561',
    updatedon = now()
where intakeservreqchildremovalid in ('4db6afd3-7c66-424a-baa1-7440f709612c', '8c6483b0-42af-4148-8f1e-1a9fe1f26853')
and activeflag =1;


update personprogramarea 
set enddate = null, 
updatedby ='CJAMS-62561', 
updatedon = now()  
where personprogramid  in ('2317550c-5eb4-41f3-92a6-37c869f088ad' , '11b58f7b-1534-43db-99fe-c0fe45caea07') 
and activeflag = 1;

update tb_client_eligibility
set end_dt = null,
    update_user_id = 'CJAMS-62561',
    update_ts = now()
where removal_id in (199831,200177)
and delete_sw = 'N';


INSERT INTO cjams.intakeservreqchildremoval_history
(intakeservreqchildremovalhistoryid, modifieddata, rowtype, intakeservreqchildremovalid, intakeserviceid, fathername, mothername, rmvdfrmpersonname, removalreasontypeid, removaladd1, removaladd2, removalzip, removalstatecd, removalcity, activeflag, insertedby, insertedon, updatedby, updatedon, agencytypekey, old_id, intakeservicerequestactorid, rmvdfrmisractorid, removaldate, parent2signeddate, primarycaregiverid, vpaparentssigneddate, vpadsssigneddate, dateoffindingctwdecision, childphysicaladdressafterremoval, nameofsubjectctwfinding, clientidofsubjectctwfinding, courtorderdelaytimeframe, reasonableeffortsnotnecessaryduetoemergentcircumstances, whoisresponsibleforplacementandcare, ctwdecision, relationshipofsubjectctwfinding, specifiedrelativedatechildlastlivedwith, specifiedrelativephysicaladdress, specifiedrelativename, specifiedrelativeclientid, specifiedrelativerelationshipid, sheltergranted, courtorderdelayremoval, magistrateorjudgename, typeofvpa, eavpaagreementflag, vpabegindate, ctwsanctioningchildremoval, childphysicalremovaldate, petitionfiledate, dateofremovalcourthearing, judgesigned, hearingdate, physicalremovalafterdetermination, removalcourtorderdate, childphysicalremovaladdress, specifiedrelativephysicaladdressafterremoval, dateofreasonableeffortscourthearing, reasonableeffortsmade, issafehavenbaby, returndate, childremovedfromtypekey, familystructuretypekey, "comments", vpastartdate, vpaenddate, childrelativelastdate, approvalstatustypekey, caseid, nocaregivercustodyflag, origremovalid, datavalidflag, clientmergeid, removaltime, returntime, removaltransts, returntransts, afcarseditapplyflag, parentssigntypekey, parent2comments, fk1_id, agencysigneddate, isbothparentssigned, childfactorsentry, removaltypekey, primarycaregiveractorid, vpachildsigneddate, vpayouthsigneddate, vpaguardiansigneddate, removalreasontypekey, removalid, exitdate, seccaregiveractorid, seccaregiveradd, primarycaregiveradd, isverifiedreporteradd, isverifiedcaregiver1add, isverifiedcaregiver2add, relativeactorid, isdisability, servicecaseid, assessmentid, personid, ischildphysicalremovaladdressverified, isuploadedmanually, isshelterauthcompleted, ischildaddressasprimaryaddress, removalexitreason, parent1id, parent2id, guardianid, volrelinquishment, etl_userid, etl_load_date, actualdata, removalcircumstances, transferagency, otherpublicagency, locationofadoption, justification, environmentatremovalkey, childremovalluggage, luggageprovided, placementdisposableortrashbag, luggagecomments, luggageupdatedby, luggageupdatedon)
VALUES(gen_random_uuid(), '{"status":"Updated", "data": [ {"key": "comments","data_type": "text", "new_value": "the child removal was opened with the datafix ticket CJAMS-62561.","display_name": "Comments"}]}'::json, 'HISTORY', '4db6afd3-7c66-424a-baa1-7440f709612c'::uuid, '9cf43cb0-4c62-4b8c-82d7-a947c54cbada'::uuid, 'KARLA FLORES AMAYA', NULL, 'Mother (Biological)', NULL, NULL, NULL, NULL, NULL, NULL, 1, 'CJAMS-62561', now(), 'CJAMS-62561', now(), NULL, '199831', '8350ce61-c151-4e86-8bac-36f653a9dae8'::uuid, NULL, '2020-05-12 00:00:00.000', NULL, 4105992, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Mother (Biological)', '293', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, NULL, '2020-05-12 16:00:00.000', NULL, '2020-05-14', '2025-09-23', 1, NULL, NULL, '3278452', NULL, NULL, NULL, 'JD', '695b1e4e-ad9b-4e66-a52a-0de2d1be95f1'::uuid, NULL, NULL, NULL, NULL, 199831, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 1, 'ae6aecc1-164d-4a9f-8183-3a5b730ffe93'::uuid, NULL, '4fff3b1f-2928-463f-a0a1-b7a2e9ac2d25'::uuid, NULL, NULL, NULL, 1, 'ADNRE', NULL, NULL, NULL, NULL, 'Data Migration', '2020-07-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, true, NULL, NULL, NULL, 'Aaliyah Rivers', '2025-09-23 15:33:15.930');


INSERT INTO cjams.intakeservreqchildremoval_history
(intakeservreqchildremovalhistoryid, modifieddata, rowtype, intakeservreqchildremovalid, intakeserviceid, fathername, mothername, rmvdfrmpersonname, removalreasontypeid, removaladd1, removaladd2, removalzip, removalstatecd, removalcity, activeflag, insertedby, insertedon, updatedby, updatedon, agencytypekey, old_id, intakeservicerequestactorid, rmvdfrmisractorid, removaldate, parent2signeddate, primarycaregiverid, vpaparentssigneddate, vpadsssigneddate, dateoffindingctwdecision, childphysicaladdressafterremoval, nameofsubjectctwfinding, clientidofsubjectctwfinding, courtorderdelaytimeframe, reasonableeffortsnotnecessaryduetoemergentcircumstances, whoisresponsibleforplacementandcare, ctwdecision, relationshipofsubjectctwfinding, specifiedrelativedatechildlastlivedwith, specifiedrelativephysicaladdress, specifiedrelativename, specifiedrelativeclientid, specifiedrelativerelationshipid, sheltergranted, courtorderdelayremoval, magistrateorjudgename, typeofvpa, eavpaagreementflag, vpabegindate, ctwsanctioningchildremoval, childphysicalremovaldate, petitionfiledate, dateofremovalcourthearing, judgesigned, hearingdate, physicalremovalafterdetermination, removalcourtorderdate, childphysicalremovaladdress, specifiedrelativephysicaladdressafterremoval, dateofreasonableeffortscourthearing, reasonableeffortsmade, issafehavenbaby, returndate, childremovedfromtypekey, familystructuretypekey, "comments", vpastartdate, vpaenddate, childrelativelastdate, approvalstatustypekey, caseid, nocaregivercustodyflag, origremovalid, datavalidflag, clientmergeid, removaltime, returntime, removaltransts, returntransts, afcarseditapplyflag, parentssigntypekey, parent2comments, fk1_id, agencysigneddate, isbothparentssigned, childfactorsentry, removaltypekey, primarycaregiveractorid, vpachildsigneddate, vpayouthsigneddate, vpaguardiansigneddate, removalreasontypekey, removalid, exitdate, seccaregiveractorid, seccaregiveradd, primarycaregiveradd, isverifiedreporteradd, isverifiedcaregiver1add, isverifiedcaregiver2add, relativeactorid, isdisability, servicecaseid, assessmentid, personid, ischildphysicalremovaladdressverified, isuploadedmanually, isshelterauthcompleted, ischildaddressasprimaryaddress, removalexitreason, parent1id, parent2id, guardianid, volrelinquishment, etl_userid, etl_load_date, actualdata, removalcircumstances, transferagency, otherpublicagency, locationofadoption, justification, environmentatremovalkey, childremovalluggage, luggageprovided, placementdisposableortrashbag, luggagecomments, luggageupdatedby, luggageupdatedon)
VALUES(gen_random_uuid(), '{"status":"Updated", "data": [ {"key": "comments","data_type": "text", "new_value": "the child removal was opened with the datafix ticket CJAMS-62561.","display_name": "Comments"}]}'::json, 'HISTORY', '8c6483b0-42af-4148-8f1e-1a9fe1f26853'::uuid, '9cf43cb0-4c62-4b8c-82d7-a947c54cbada'::uuid, 'KARLA FLORES AMAYA', NULL, 'Mother (Biological)', NULL, NULL, NULL, NULL, NULL, NULL, 1, 'CJAMS-62561', now(), 'CJAMS-62561', now(), NULL, '200177', '506edb82-876f-4809-a163-27f72cee94cd'::uuid, NULL, '2020-05-26 00:00:00.000', NULL, 4105992, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Mother (Biological)', '293', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, NULL, '2020-05-26 12:00:00.000', NULL, '2020-07-24', '2025-09-23', 1, NULL, NULL, '3278452', NULL, NULL, NULL, 'JD', '695b1e4e-ad9b-4e66-a52a-0de2d1be95f1'::uuid, NULL, NULL, NULL, NULL, 200177, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 1, 'ae6aecc1-164d-4a9f-8183-3a5b730ffe93'::uuid, NULL, '4fff3b1f-2928-463f-a0a1-b7a2e9ac2d25'::uuid, NULL, NULL, NULL, 1, 'ADNRE', NULL, NULL, NULL, NULL, 'Data Migration', '2020-07-25', NULL, NULL, NULL, NULL, NULL, NULL, NULL, true, NULL, NULL, NULL, 'Aaliyah Rivers', '2025-09-23 15:33:15.930');




