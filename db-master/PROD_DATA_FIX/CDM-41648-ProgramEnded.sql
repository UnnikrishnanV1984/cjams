/*
Issue Description: Need data fix for the below,
Case# 3261844, Client ID: 3894588 (AMARIE WOODARD)
1. Need to Remove the End date (06/24/2024) for Provider Placement (KIMBERLY PIERCE)
2. Need to Remove the Child Removal End Date (06/24/2024) and newly created (open) removal record also.
3. Need to Remove the OOH Program Assignment End Date (06/24/2024) and newly created (open) OOH Program record also.
Category/Module: Error
Root cause: Entries were incorrectly entered by user
Fix provided: DB queries to rectify/remove entries
Data/Code fix ticket#: CDM-41648
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

----------------------1. Provider Placement End Date---------------------------
--Removing end date from placement
update placement 
set enddate = null, endtime = null, updatedby = 'CDM-41648', updatedon = now()
where placementid = '7ccb8f9a-f340-4823-8338-31cda5652383' and activeflag = 1;

--Removing records from placementrevision
delete from placementrevision
where placementrevisionid in ('529ef4ac-4cd9-4ecd-a791-8b82ad782675', 'd27b1810-ee8e-4318-93ab-641ae155691f');

--Removing end date from livingarrangement
update livingarrangement 
set livingenddate = null, updatedby = 'CDM-41648', updatedon = now()
where placementid = '7ccb8f9a-f340-4823-8338-31cda5652383' and activeflag = 1;

/*
--Backup insert queries
insert into placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitreasontypkey, approvalstatustypkey, approvaldate, isoriginal,
insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, exittypekey, remarks, isvoided, requestedby, requesteddate,
approvedby, approveddate, status, leastrestrictiveplacement)
values ('529ef4ac-4cd9-4ecd-a791-8b82ad782675', '7ccb8f9a-f340-4823-8338-31cda5652383', '2024-08-15 00:00:00', '2023-01-08 00:00:00',
'08:00', 'REUNIF', '3047', '2024-08-15 00:00:00', '1', now(), 'CDM-41648', now(), 'CDM-41648', 1, 2246291, 'PLCC',
'Child reunify with parent.', 0, '50506cc6-9c5c-4b58-bec1-bb84fdd29c05', '2024-08-15 16:20:02', '50506cc6-9c5c-4b58-bec1-bb84fdd29c05',
'2024-08-15 17:14:56', 'Approved', 'Family style setting.');

insert into placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, exitreasontypkey, approvalstatustypkey, approvaldate, isoriginal,
insertedon, insertedby, updatedon, updatedby, activeflag, alternateid, exittypekey, remarks, isvoided, requestedby, requesteddate,
approvedby, approveddate, status, leastrestrictiveplacement)
values ('d27b1810-ee8e-4318-93ab-641ae155691f', '7ccb8f9a-f340-4823-8338-31cda5652383', '2024-08-15 00:00:00', '2023-01-08 00:00:00',
'08:00', 'REUNIF', '3047', null, '1', now(), 'CDM-41648', now(), 'CDM-41648', 0, 2246159, 'PLCC', 
'Child reunify with parent.', 0, '50506cc6-9c5c-4b58-bec1-bb84fdd29c05', '2024-08-15 16:20:02', '50506cc6-9c5c-4b58-bec1-bb84fdd29c05',
'2024-08-15 17:14:56', 'Approved', 'Family style setting.');
*/


----------------------2. Child Removal End Date---------------------------
--Removing new childremoval record
update intakeservreqchildremoval
set activeflag = 0, updatedby = 'CDM-41648', updatedon = now()
where intakeservreqchildremovalid = 'b5f0047e-e3eb-4fc8-bbf2-f3dae568d9d7' and activeflag = 1;

update intakeservreqchildremoval_history
set activeflag = 0, updatedby = 'CDM-41648', updatedon = now()
where intakeservreqchildremovalid = 'b5f0047e-e3eb-4fc8-bbf2-f3dae568d9d7' and activeflag = 1;

update tb_client_eligibility
set delete_sw = 'Y', update_user_id = 'CDM-41648', update_ts = now()
where eligibility_id = 10107383;

update routing
set activeflag = 0, updatedby = 'CDM-41648', updatedon = now()
where routingid = '7cf1cd18-3fe5-46ce-815b-2b1414758b84' and activeflag = 1;

--Removing end date from other record
update intakeservreqchildremoval
set exitdate = null, returntransts = null, updatedby = 'CDM-41648', updatedon = now()
where intakeservreqchildremovalid = '8cbe004a-5d2c-4e10-bcff-c1a28163102e' and activeflag = 1;

update intakeservreqchildremoval_history
set exitdate = null, returntransts = null, updatedby = 'CDM-41648', updatedon = now()
where intakeservreqchildremovalid = '8cbe004a-5d2c-4e10-bcff-c1a28163102e' and activeflag = 1;

update tb_client_eligibility
set end_dt = null, update_user_id = 'CDM-41648', update_ts = now()
where eligibility_id = 10013115;

----------------------1. OOH Program Assignments---------------------------
--Removing end date from old personprogramarea record
update personprogramarea
set enddate = null, updatedby = 'CDM-41648', updatedon = now()
where personprogramid = '09a4a836-1321-4909-af8c-aa343e4a99c7' and activeflag = 1;

--Removing new personprogramarea record
update personprogramarea
set activeflag = 0, updatedby = 'CDM-41648', updatedon = now()
where personprogramid = '996589b4-a7cc-4db2-89db-efe59fa7ffdb' and activeflag = 1;