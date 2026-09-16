/*
Issue: CJAMS-66955 Removal needs to be re-opened
Category/Module: Child Removal
Root cause: This is not a defect as the Removal was end dated by the system due to placement exit reason is Permanently Leaving Custody & Care.
            Data fix needed to do the following changes
            1) Remove the removal end date
            2) Remove the OOH program assignment end date
            3) Update the Placement Exit Type from Permanently Leaving Custody & Care to Change in Placement Structure.
Fix provided:  Data fix has been done to remova the removal end data, Remove the OOH program assignment data and change the exit type to Change in Placement structure.
Data/Code fix ticket#: CJAMS-66955
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
    updatedby = 'CJAMS-66955',
    updatedon = now()
where intakeservreqchildremovalid='bac2ad80-f013-4a6f-bef9-b7fd473f7bd7'
and activeflag =1;

update personprogramarea 
set enddate = null, 
updatedby ='CJAMS-66955', 
updatedon = now()  
where personprogramid ='cfc6a17a-6751-4fe5-a541-2cce79012470' 
and activeflag = 1;

update placement  
set exittypekey = 'CIPS', --	Change in Placement Structure
    remarks = 'Placement Exited as the part of data fix ticket CJAMS-66955',
	updatedon = now(), 
	updatedby = 'CJAMS-66955'
where placementid = 'e73d419e-9f2b-4e93-913b-6b311fd78822'
	and activeflag = 1 ;

update placementrevision 
set exittypekey = 'CIPS', --	Change in Placement Structure
    remarks = 'Placement Exited as the part of data fix ticket CJAMS-66955',
	updatedon = now(), 
	updatedby = 'CJAMS-66955'
where placementid = 'e73d419e-9f2b-4e93-913b-6b311fd78822'
	and activeflag = 1 ;

update tb_client_eligibility
set end_dt = null,
    update_user_id = 'CJAMS-66955',
    update_ts = now()
where removal_id = 183903
and delete_sw = 'N';

INSERT INTO cjams.intakeservreqchildremoval_history
(intakeservreqchildremovalhistoryid, modifieddata, rowtype, intakeservreqchildremovalid, intakeserviceid, fathername, mothername, rmvdfrmpersonname, removalreasontypeid, removaladd1, removaladd2, removalzip, removalstatecd, removalcity, activeflag, insertedby, insertedon, updatedby, updatedon, agencytypekey, old_id, intakeservicerequestactorid, rmvdfrmisractorid, removaldate, parent2signeddate, primarycaregiverid, vpaparentssigneddate, vpadsssigneddate, dateoffindingctwdecision, childphysicaladdressafterremoval, nameofsubjectctwfinding, clientidofsubjectctwfinding, courtorderdelaytimeframe, reasonableeffortsnotnecessaryduetoemergentcircumstances, whoisresponsibleforplacementandcare, ctwdecision, relationshipofsubjectctwfinding, specifiedrelativedatechildlastlivedwith, specifiedrelativephysicaladdress, specifiedrelativename, specifiedrelativeclientid, specifiedrelativerelationshipid, sheltergranted, courtorderdelayremoval, magistrateorjudgename, typeofvpa, eavpaagreementflag, vpabegindate, ctwsanctioningchildremoval, childphysicalremovaldate, petitionfiledate, dateofremovalcourthearing, judgesigned, hearingdate, physicalremovalafterdetermination, removalcourtorderdate, childphysicalremovaladdress, specifiedrelativephysicaladdressafterremoval, dateofreasonableeffortscourthearing, reasonableeffortsmade, issafehavenbaby, returndate, childremovedfromtypekey, familystructuretypekey, "comments", vpastartdate, vpaenddate, childrelativelastdate, approvalstatustypekey, caseid, nocaregivercustodyflag, origremovalid, datavalidflag, clientmergeid, removaltime, returntime, removaltransts, returntransts, afcarseditapplyflag, parentssigntypekey, parent2comments, fk1_id, agencysigneddate, isbothparentssigned, childfactorsentry, removaltypekey, primarycaregiveractorid, vpachildsigneddate, vpayouthsigneddate, vpaguardiansigneddate, removalreasontypekey, removalid, exitdate, seccaregiveractorid, seccaregiveradd, primarycaregiveradd, isverifiedreporteradd, isverifiedcaregiver1add, isverifiedcaregiver2add, relativeactorid, isdisability, servicecaseid, assessmentid, personid, ischildphysicalremovaladdressverified, isuploadedmanually, isshelterauthcompleted, ischildaddressasprimaryaddress, removalexitreason, parent1id, parent2id, guardianid, volrelinquishment, etl_userid, etl_load_date, actualdata, removalcircumstances, transferagency, otherpublicagency, locationofadoption, justification, environmentatremovalkey, childremovalluggage, luggageprovided, placementdisposableortrashbag, luggagecomments, luggageupdatedby, luggageupdatedon, showcontactpage)
VALUES(gen_random_uuid(), '{"status": "Updated", "data": [ {"key": "comments","data_type": "text", "new_value": "The child removal was re-opened with the datafix ticket CJAMS-66955","display_name": "Comments"}]}'::json, 'HISTORY', 'bac2ad80-f013-4a6f-bef9-b7fd473f7bd7', '5315d11c-7831-4738-b030-0f1ee02e4400', 'CLEMENTINA IBE', NULL, 'Grandmother (Maternal)', NULL, NULL, NULL, NULL, NULL, NULL, 1, 'CJAMS-66955', now(), 'CJAMS-66955', now(), NULL, '183903', '69e54f44-b54b-4ac5-af5f-d04ca2d5d190'::uuid, NULL, '2017-03-01 00:00:00.000', NULL, 1375708, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Grandmother (Maternal)', '293', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, NULL, '2017-03-01 12:00:00.000', '2026-03-26 08:00:00.000', '2017-03-02', '2026-03-27', 1, NULL, NULL, '3273495', NULL, NULL, NULL, 'JD', '72b36f0e-55b9-4afc-995e-7329da4f00ed'::uuid, NULL, NULL, NULL, NULL, 183903, '2026-03-26 08:00:00.000', NULL, NULL, NULL, NULL, 1, NULL, NULL, 0, '2e3f5945-0429-48c5-bb17-e6e4d71d87ba'::uuid, NULL, '63900137-a96a-4206-88f6-fa49e41bdcdc'::uuid, NULL, NULL, NULL, 1, 'EMANIND', NULL, NULL, NULL, NULL, 'Data Migration', '2020-05-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, true, NULL, NULL, NULL, 'Julie Boyd', '2026-03-27 12:20:30.332', NULL);
