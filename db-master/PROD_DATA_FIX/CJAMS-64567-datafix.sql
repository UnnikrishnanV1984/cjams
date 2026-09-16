/*
Issue Description: CJAMS-64567 Removal issue
Category/Module: Out-of-home
Root cause: User requested to update removal end date for 3 children
Fix provided: Data fix has been promoted to update the removal end date
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: The issue is specific to data and is not a recurring one or a logical issue.
*/

UPDATE intakeservreqchildremoval 
SET exitdate='2025-12-17', updatedon = NOW(), updatedby = 'CJAMS-64567'
WHERE personid in ('42ccc1a6-28fd-4970-926e-f35144f67624',
'f2f520e0-2c76-44b4-bd45-398c8ad6aefe','b1946848-9288-42e4-b7e0-2fd451c4f847') 
and activeflag =1;

update personprogramarea
SET enddate='2025-12-17', updatedon = NOW(), updatedby = 'CJAMS-64567'
WHERE personid in ('42ccc1a6-28fd-4970-926e-f35144f67624',
'f2f520e0-2c76-44b4-bd45-398c8ad6aefe','b1946848-9288-42e4-b7e0-2fd451c4f847') 
and activeflag =1 and programkey = 'OOH';

update tb_client_eligibility
set end_dt='2025-12-17', update_ts = NOW(), update_user_id = 'CJAMS-64567'
where removal_id in (341028, 341030, 341029)
and delete_sw = 'N';