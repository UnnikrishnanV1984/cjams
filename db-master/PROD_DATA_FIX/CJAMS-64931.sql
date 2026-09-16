/*
Issue Description:CJAMS-64931 3302930::Removal end date need to be taken out
Category/Module: Placement 
Root cause: This child's removal was end dated in error. while he is 21 the courts have kept him committed we need the end date taken out
            Case ID - 3302930
            CJAMS PID - 2986306 
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
    updatedby = 'CJAMS-64931',
    updatedon = now()
where intakeservreqchildremovalid='ab37cfb5-cc32-4491-a6b2-0032ff77b01e'
and activeflag =1;

update personprogramarea 
set enddate = null, 
updatedby ='CJAMS-64931', 
updatedon = now()  
where personprogramid ='962e5bf1-4d51-4c71-83be-240f137a771b' 
and activeflag = 1;

update tb_client_eligibility
set end_dt = null,
    update_user_id = 'CJAMS-64931',
    update_ts = now()
where removal_id = 198915
and delete_sw = 'N';

INSERT INTO cjams.intakeservreqchildremoval_history
(intakeservreqchildremovalhistoryid, modifieddata, 
rowtype, intakeservreqchildremovalid, intakeserviceid, fathername, mothername, rmvdfrmpersonname, removalreasontypeid, removaladd1, removaladd2, removalzip, removalstatecd, removalcity, activeflag, insertedby, insertedon, updatedby, updatedon, agencytypekey, old_id, intakeservicerequestactorid, rmvdfrmisractorid, removaldate, parent2signeddate, primarycaregiverid, vpaparentssigneddate, vpadsssigneddate, dateoffindingctwdecision, childphysicaladdressafterremoval, nameofsubjectctwfinding, clientidofsubjectctwfinding, courtorderdelaytimeframe, reasonableeffortsnotnecessaryduetoemergentcircumstances, whoisresponsibleforplacementandcare, ctwdecision, relationshipofsubjectctwfinding, specifiedrelativedatechildlastlivedwith, specifiedrelativephysicaladdress, specifiedrelativename, specifiedrelativeclientid, specifiedrelativerelationshipid, sheltergranted, courtorderdelayremoval, magistrateorjudgename, typeofvpa, eavpaagreementflag, vpabegindate, ctwsanctioningchildremoval, childphysicalremovaldate, petitionfiledate, dateofremovalcourthearing, judgesigned, hearingdate, physicalremovalafterdetermination, removalcourtorderdate, childphysicalremovaladdress, specifiedrelativephysicaladdressafterremoval, dateofreasonableeffortscourthearing, reasonableeffortsmade, issafehavenbaby, returndate, childremovedfromtypekey, familystructuretypekey, "comments", vpastartdate, vpaenddate, childrelativelastdate, approvalstatustypekey, caseid, nocaregivercustodyflag, origremovalid, datavalidflag, clientmergeid, removaltime, returntime, removaltransts, returntransts, afcarseditapplyflag, parentssigntypekey, parent2comments, fk1_id, agencysigneddate, isbothparentssigned, childfactorsentry, removaltypekey, primarycaregiveractorid, vpachildsigneddate, vpayouthsigneddate, vpaguardiansigneddate, removalreasontypekey, removalid, exitdate, seccaregiveractorid, seccaregiveradd, primarycaregiveradd, isverifiedreporteradd, isverifiedcaregiver1add, isverifiedcaregiver2add, relativeactorid, isdisability, servicecaseid, assessmentid, personid, ischildphysicalremovaladdressverified, isuploadedmanually, isshelterauthcompleted, ischildaddressasprimaryaddress, removalexitreason, parent1id, parent2id, guardianid, volrelinquishment, etl_userid, etl_load_date, actualdata, removalcircumstances, transferagency, otherpublicagency, locationofadoption, justification, environmentatremovalkey, childremovalluggage, luggageprovided, placementdisposableortrashbag, luggagecomments, luggageupdatedby, luggageupdatedon, showcontactpage)
VALUES(gen_random_uuid(), '{"status": "Updated", "data": [ {"key": "comments","data_type": "text", "new_value": "the child removal was re-opened with the datafix ticket CJAMS-64931.","display_name": "Comments"}]}', 'HISTORY', 'ab37cfb5-cc32-4491-a6b2-0032ff77b01e', 'a2b77278-e97e-4e8c-b07a-d9369a0778ba', 'ANGELO BARNES', NULL, 'Grandmother (Paternal)', NULL, NULL, NULL, NULL, NULL, NULL, 1, 'CJAMS-64931', '2026-01-14 15:31:31.233', 'CJAMS-64931', '2026-01-14 15:31:31.233', NULL, '198915', '8c225ca4-285f-4af9-b18e-a65265ad0f3c', NULL, '2020-02-06 00:00:00.000', NULL, 2986297, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Grandmother (Paternal)', '293', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, NULL, '2020-02-06 16:00:00.000', '2025-12-10 10:00:00.000', '2020-02-12', NULL, 1, NULL, NULL, '3302930', NULL, NULL, NULL, 'JD', '51843321-eda0-4865-84a7-7722a1f36a6a', NULL, NULL, NULL, NULL, 198915, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 1, '4c24e9c6-0e28-48b1-83e6-8d26b77e57e7', NULL, '1be83ba9-8870-4c65-bd04-41a676805af7', NULL, NULL, NULL, 1, '', NULL, NULL, NULL, NULL, 'Data Migration', '2020-06-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, true, NULL, NULL, NULL, 'Morris Richmond', '2026-01-14 15:30:42.363', NULL);

update placement 
set exittypekey = 'CIPS', 
    updatedon = now(), 
    updatedby = 'CJAMS-64931'
where placementid = '2639fa58-b1db-4ad5-91c2-7f426ca79247'
and intakeservreqchildremovalid = 'ab37cfb5-cc32-4491-a6b2-0032ff77b01e'
and activeflag = 1;

update placementrevision 
set exittypekey = 'CIPS', 
    updatedon = now(), 
    updatedby = 'CJAMS-64931' 
where placementid = '2639fa58-b1db-4ad5-91c2-7f426ca79247'
and placementrevisionid = 'c0b9356e-1a04-4019-b5ec-22bcb3159fff' 
and activeflag =1;

