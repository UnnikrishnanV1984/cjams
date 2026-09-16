/*
Issue Description: Need fix to remove the Child Removal End date and change the placement Exit Type from "Permanently Leaving Custody & Care" to "Change in Placement Structure"
Category/Module: Support
Root cause: Application does not allow certain entries in placement or removal to be edited
Fix provided: DB queries to change entries per user request
Data/Code fix ticket#: CDM-43200
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating intakeservreqchildremoval
update intakeservreqchildremoval
set exitdate = null, updatedby = 'CDM-43200', updatedon = now()
where intakeservreqchildremovalid = '5fdecd95-888e-4894-a36d-af709c6d2d87' and activeflag = 1;

--Updating intakeservreqchildremoval_history
update intakeservreqchildremoval_history
set exitdate = null, updatedby = 'CDM-43200', updatedon = now()
where intakeservreqchildremovalhistoryid = 'fa3e04cd-38e7-48ef-8200-581bc4ab61b1' and activeflag = 1;

--Updating placement
update placement
set exittypekey = 'CIPS', updatedby = 'CDM-43200', updatedon = now()
where placementid = '2905ac40-c997-49cf-950b-8d803605563a' and activeflag = 1;

--Updating placementrevision
update placementrevision
set exittypekey = 'CIPS', updatedby = 'CDM-43200', updatedon = now()
where placementrevisionid = 'e1c30a76-59dc-4385-b8e7-0b87e8a52eb2' and activeflag = 1;

--Updating personprogramarea
update personprogramarea
set enddate = null, updatedby = 'CDM-43200', updatedon = now()
where personprogramid = '1e5bffb1-1408-4961-a5f9-3fe2e068f4de' and activeflag = 1;

--Update tb_client_eligibility
update tb_client_eligibility
set end_dt = null, update_user_id = 'CDM-43200', update_ts = now()
where eligibility_id = 10022361;