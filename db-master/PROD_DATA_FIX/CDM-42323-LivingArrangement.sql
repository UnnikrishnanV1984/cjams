/*
Issue Description: 1. Need to change the Living Arrangement - Relative/fictive Kin home Exit date - * 10/02/2024 *to "07/07/2023 12 PM" and Change the Exit Type from ** "Permanently Leaving Custody & Care" to "Change in Placement Structure".
2. Need to remove the Child Removal End date (10/02/2024) 
Category/Module: Error
Root cause: Old placement dates and description need to be changed to close the case
Fix provided: DB queries to change placement dates and child removal end date
Data/Code fix ticket#: CDM-42323
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--1. Updating placement
update placement
set enddatetime = '2023-07-07 12:00:00', endtime = '12:00', exittypekey = 'CIPS', updatedby = 'CDM-42323', updatedon = now()
where placementid = '897cd065-fd5b-4155-b073-783c61e3ca0b' and activeflag = 1;

--1. Updating placementrevision
update placementrevision
set exitdate = '2023-07-07 12:00:00', exittime = '12:00', exittypekey = 'CIPS', updatedby = 'CDM-42323', updatedon = now()
where placementrevisionid = '81ac56de-8a69-485d-9963-03784aa54e62' and activeflag = 1;

--1. Updating livingarrangement
update livingarrangement
set livingenddate = '2023-07-07 12:00:00', updatedby = 'CDM-42323', updatedon = now()
where livingid = '81431dae-c80d-4e97-8ae0-25c5f6972a1d' and activeflag = 1;

--2. Updating intakeservreqchildremoval
update intakeservreqchildremoval
set exitdate = null, updatedby = 'CDM-42323', updatedon = now(), returntransts = null
where intakeservreqchildremovalid = '7b736db1-2260-4f10-9d1f-7a8bfac1fd0b' and activeflag = 1;

--2. Updating intakeservreqchildremoval_history
update intakeservreqchildremoval_history
set exitdate = null, updatedby = 'CDM-42323', updatedon = now()
where intakeservreqchildremovalhistoryid = '048bf795-ad0f-4842-a815-8c9cb4ebbcac' and activeflag = 1;

--2. Updating tb_client_eligibility
update tb_client_eligibility
set end_dt = null, update_ts = now(), update_user_id = 'CDM-42323'
where eligibility_id in (166424, 10110752);

--2. Updating personprogramarea
update personprogramarea
set enddate = null, updatedby = 'CDM-42323', updatedon = now()
where personprogramid = '46e720bf-b779-454c-9308-5cae561b1641' and activeflag = 1;