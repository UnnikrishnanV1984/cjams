/*
Issue Description: remove the Child Removal & OOH Program Assignment End Date as requested.
Category/Module: Bug
Root cause: user could not abe to delete end dates ,they can only create.
Fix provided: DB queries  update enddate intakeservreqchildremoval,personprogramarea tables
Data/Code fix ticket#: CJAMS-63303
Regression Impacts: N/A 
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
update personprogramarea
set enddate = null, updatedby = 'CJAMS-63303', updatedon = now()
where personprogramid = '0b8d1d5f-9aba-40cf-a871-9fae8ec1cc12' and activeflag=1;


update intakeservreqchildremoval
set exitdate = null ,updatedby = 'CJAMS-63303', updatedon = now(),
returntransts = Null,returndate = Null,returntime = Null,removalexitreason = NULL
where intakeservreqchildremovalid = 'c95efa36-80c8-4c53-81f6-a0c73c5f96be' and activeflag =1;

update intakeservreqchildremoval_history 
set exitdate = null ,updatedby = 'CJAMS-63303', updatedon = now()
where intakeservreqchildremovalhistoryid in ('21ae8d7c-4c9d-4ca1-8e7d-0bffc7459419',
'cc79a850-1474-4c9b-93d4-14a04d55ff51',
'6fc5ebb1-47c5-4502-96b9-f575af1666fd',
'5590e305-c18b-402b-986c-85ef10877aa1',
'8d695f7c-e741-4d95-86bc-52d90da2e2a2') and activeflag =1;

update tb_client_eligibility 
set end_dt = null, update_ts = now(),update_user_id  = 'CJAMS-63303'
where eligibility_id  = 10080768 and delete_sw = 'N';



update placement
set exittypekey='CIPS',updatedby = 'CJAMS-63303', updatedon = now()
where placementid = 'a3dce906-f7a4-45f3-b56e-9bc084f39c41' and activeflag=1;

update placementrevision
set exittypekey='CIPS',updatedby = 'CJAMS-63303', updatedon = now()
where placementrevisionid = '68d29542-b66c-4ff8-8509-598ddb13b2a8' and activeflag=1;


INSERT INTO cjams.intakeservreqchildremoval_history
(intakeservreqchildremovalhistoryid,modifieddata,  rowtype, intakeservreqchildremovalid, intakeserviceid, fathername, mothername, rmvdfrmpersonname, removalreasontypeid, removaladd1, removaladd2, removalzip, removalstatecd, removalcity, activeflag, insertedby, insertedon, updatedby, updatedon, agencytypekey, old_id, intakeservicerequestactorid, rmvdfrmisractorid, removaldate, parent2signeddate, primarycaregiverid, vpaparentssigneddate, vpadsssigneddate, dateoffindingctwdecision, childphysicaladdressafterremoval, nameofsubjectctwfinding, clientidofsubjectctwfinding, courtorderdelaytimeframe, reasonableeffortsnotnecessaryduetoemergentcircumstances, whoisresponsibleforplacementandcare, ctwdecision, relationshipofsubjectctwfinding, specifiedrelativedatechildlastlivedwith, specifiedrelativephysicaladdress, specifiedrelativename, specifiedrelativeclientid, specifiedrelativerelationshipid, sheltergranted, courtorderdelayremoval, magistrateorjudgename, typeofvpa, eavpaagreementflag, vpabegindate, ctwsanctioningchildremoval, childphysicalremovaldate, petitionfiledate, dateofremovalcourthearing, judgesigned, hearingdate, physicalremovalafterdetermination, removalcourtorderdate, childphysicalremovaladdress, specifiedrelativephysicaladdressafterremoval, dateofreasonableeffortscourthearing, reasonableeffortsmade, issafehavenbaby, returndate, childremovedfromtypekey, familystructuretypekey, "comments", vpastartdate, vpaenddate, childrelativelastdate, approvalstatustypekey, caseid, nocaregivercustodyflag, origremovalid, datavalidflag, clientmergeid, removaltime, returntime, removaltransts, returntransts, afcarseditapplyflag, parentssigntypekey, parent2comments, fk1_id, agencysigneddate, isbothparentssigned, childfactorsentry, removaltypekey, primarycaregiveractorid, vpachildsigneddate, vpayouthsigneddate, vpaguardiansigneddate, removalreasontypekey, removalid, exitdate, seccaregiveractorid, seccaregiveradd, primarycaregiveradd, isverifiedreporteradd, isverifiedcaregiver1add, isverifiedcaregiver2add, relativeactorid, isdisability, servicecaseid, assessmentid, personid, ischildphysicalremovaladdressverified, isuploadedmanually, isshelterauthcompleted, ischildaddressasprimaryaddress, removalexitreason, parent1id, parent2id, guardianid, volrelinquishment, etl_userid, etl_load_date,  transferagency, otherpublicagency, locationofadoption, justification, environmentatremovalkey, childremovalluggage, luggageprovided, placementdisposableortrashbag, luggagecomments, luggageupdatedby, luggageupdatedon, showcontactpage)
VALUES( gen_random_uuid(), '{"status": "Updated", "data": [ {"key": "comments","data_type": "text", "new_value": "the child removal was re-opened with the datafix ticket CJAMS-63303.","display_name": "Comments"}]}','HISTORY', 'c95efa36-80c8-4c53-81f6-a0c73c5f96be', NULL, NULL, NULL, NULL, NULL, '1114 N Mount St,Sarah''s Hope Family Shelter, Baltimore, MD', NULL, '65559999', NULL, NULL, 1, '45391f16-58de-4b24-bd7e-12cdc4ff4335', '2024-04-01 10:34:17.000', 'CJAMS-63303', now(), 'AFH', NULL, 'd50d1a91-a98e-47fd-b8c0-63b3a534486c', NULL, '2024-03-29 00:00:00.000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '293', 'Four children left unattended at the shelter without an identified caregiver. The mother left the shelter with her youngest child, Halo (age one) on March 24, 2024. However her other children, Carter, age 13, Kaden, age 10, Kyon, age 8, and Kamal, age 6 also left the shelter on March 24, 2024. The children returned to the shelter yesterday without an identified caregiver. Per Kaden, they went to their Uncle Devin''s house. Kaden and his siblings would not give any further information. Shelter staff have not been able to make contact with the mother and the mother has not called the shelter to inquire about the children.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-03-29 10:30:00.000', NULL, '2024-04-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'JD', '622918e6-e004-4258-92da-5ebd489ca417', NULL, NULL, NULL, NULL, 308309, NULL, NULL, NULL, '1114 N Mount St,Sarah''s Hope Family Shelter, Baltimore, MD', 1, 1, 0, NULL, NULL, '9812840a-54da-4e09-b867-c24655fefdbd', NULL, '6061a4ed-17be-4fb5-8e39-73e78a8f94fd', NULL, 1, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
NULL, NULL, NULL, NULL, 'OTHER', NULL, NULL, NULL, NULL, NULL, NULL, NULL);

