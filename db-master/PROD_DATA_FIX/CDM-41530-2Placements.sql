/*
Issue Description:
1. Remove the "End Date - 05/24/2024" for Provider Placement - "The Children's Home - Diagnostic & Treatment"
2. Living Arrangement - Relative/fictive Kin home - Dated (11/16/2023 - 01/17/2024): Change the "Exit Type" reason from "Permanently Leaving Custody and Care" to "Change in Placement Structure".
3. Remove the Child Removal "End Date - 01/17/2024"
4. Remove the OOH Program "End Date - 01/17/2024"
Category/Module: Error
Root cause: The provider placement, removal, and program assignment were end-dated and approved already
Fix provided: DB queries to remove dates/update exit type
Data/Code fix ticket#: CDM-41530
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

-------------------1. Removing end date from Provider Placement-----------------
--Removing end date from placement
update placement
set enddatetime = null, endtime = null, exitreasontypekey = null, exittypekey = null, updatedby = 'CDM-41530', updatedon = now()
where placementid = '719c60dd-dda8-4ecb-9bb9-c1a96b914cfe' and activeflag = 1;

--Removing end date from placementrevision
update placementrevision
set exitdate = null, exittime = null, exitreasontypkey = null, exittypekey = null, updatedby = 'CDM-41530', updatedon = now()
where placementid = '719c60dd-dda8-4ecb-9bb9-c1a96b914cfe' and activeflag = 1;

--Removing end date from livingarrangement
update livingarrangement
set livingenddate = null, updatedby = 'CDM-41530', updatedon = now()
where placementid = '719c60dd-dda8-4ecb-9bb9-c1a96b914cfe' and activeflag = 1;

-------------------2. Updating exit type from Living Arrangement-----------------
--Updating exit type in placement
update placement
set exittypekey = 'CIPS', updatedby = 'CDM-41530', updatedon = now()
where placementid = '67cbc7ee-7a3e-404d-bcc1-96babe2f59cf' and activeflag = 1;

--Updating exit type in placementrevision
update placementrevision
set exittypekey = 'CIPS', updatedby = 'CDM-41530', updatedon = now()
where placementid = '67cbc7ee-7a3e-404d-bcc1-96babe2f59cf' and activeflag = 1;

-------------------3. Removing end date from Child Removal-----------------
--Removing end date from intakeservreqchildremoval
update intakeservreqchildremoval
set exitdate = null, returntransts = null, updatedby = 'CDM-41530', updatedon = now()
where intakeservreqchildremovalid = '2af74e8e-176f-42bb-b8fe-318b13b3c0a9' and activeflag = 1;

--Removing end date from intakeservreqchildremoval_history
update intakeservreqchildremoval_history
set exitdate = null, returntransts = null, updatedby = 'CDM-41530', updatedon = now()
where intakeservreqchildremovalid = '2af74e8e-176f-42bb-b8fe-318b13b3c0a9' and activeflag = 1;

--Removing end date from tb_client_eligibility
update tb_client_eligibility
set end_dt = null, update_user_id = 'CDM-41530', update_ts = now()
where eligibility_id = 10070800;

-------------------3. Removing end date from Program Assignment-----------------
--Removing end date from personprogramarea
update personprogramarea
set enddate = null, updatedby = 'CDM-41530', updatedon = now()
where personprogramid = 'b42a73c9-80a7-45e7-9d0f-53d042c61173' and activeflag = 1;