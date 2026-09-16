/*
Issue Description:
1. Remove the Child Removal End date
2. Remove the OOH Program Assignment End date 
3. Change the Provider Placement Exit Type from "Permanently Leaving Custody & Care" to "Change in Placement Structure"
Category/Module: Error
Root cause: OOH removal end date was entered in error
Fix provided: DB queries to remove dates/update exit type
Data/Code fix ticket#: CDM-41571
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

------------------------1. Removing Child Removal End date----------------------
--Removing end date in intakeservreqchildremoval
update intakeservreqchildremoval
set exitdate = null, returntransts = null, updatedby = 'CDM-41571', updatedon = now()
where intakeservreqchildremovalid = 'b30bd4c3-c1a7-482d-8288-bea9c536569b' and activeflag = 1;

--Removing end date in intakeservicereqchildremoval_history
update intakeservreqchildremoval_history
set exitdate = null, returntransts = null, updatedby = 'CDM-41571', updatedon = now()
where intakeservreqchildremovalid = 'b30bd4c3-c1a7-482d-8288-bea9c536569b' and activeflag = 1;

--Removing end date in tb_client_eligibility
update tb_client_eligibility
set end_dt = null, update_user_id = 'CDM-41571', update_ts = now()
where eligibility_id = 10004442;

------------------2. Removing OOH Program Assignment End date-------------------
--Removing end date from personprogramarea
update personprogramarea
set enddate = null, updatedby = 'CDM-41571', updatedon = now()
where personprogramid = 'a3afd97a-27b4-442c-a686-9c0ea9c7079b' and activeflag = 1;

--------------------3. Changing Provider Placement Exit Type--------------------
--Updating exit type in placement
update placement
set exittypekey = 'CIPS', updatedby = 'CDM-41571', updatedon = now()
where placementid = '909cedaa-8554-4f94-915d-cf3a936c9dd4' and activeflag = 1;

--Updating exit type in placementrevision
update placementrevision
set exittypekey = 'CIPS', updatedby = 'CDM-41571', updatedon = now()
where placementid = '909cedaa-8554-4f94-915d-cf3a936c9dd4' and activeflag = 1;