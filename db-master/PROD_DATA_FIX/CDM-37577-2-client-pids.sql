/*
   Issue Description: CDM-37577
   Category/ Module  : Child Removal 
   Root cause: User is not able to end date the child removal since there is a service log dated 2/12/24.
   Fix: Data fix provided to modify end data to 01/25/2024 as requested.
*/

-- Backup
select intakeservreqchildremovalid,exitdate,updatedon,updatedby from cjams.intakeservreqchildremoval where
removalid=303695;
-- UPDATE cjams.intakeservreqchildremoval
-- SET exitdate='2024-02-12 09:15:31.000', updatedon='2024-03-18 13:32:37.434', updatedby='e87cf311-d853-4c5e-b3c5-d62c896f45b9'
-- WHERE intakeservreqchildremovalid='ea6c24f3-ed47-434b-a4d1-531b9fb9e7af';


UPDATE cjams.intakeservreqchildremoval
SET exitdate='2024-01-25 09:15:00.000',updatedby = 'CDM-37577',
	updatedon = now()
WHERE intakeservreqchildremovalid='ea6c24f3-ed47-434b-a4d1-531b9fb9e7af' and removalid=303695 and activeflag = 1;

-- Backup
select personprogramid,enddate,updatedon,updatedby from cjams.personprogramarea where personprogramid='9943fbd0-fc6d-4d54-ae56-7e3e57944ca6';
-- UPDATE cjams.personprogramarea
-- SET enddate='2024-02-12 00:00:00.000', updatedon='2024-03-18 13:32:37.571', updatedby='e87cf311-d853-4c5e-b3c5-d62c896f45b9'
-- WHERE personprogramid='9943fbd0-fc6d-4d54-ae56-7e3e57944ca6' and activeflag = 1;

update cjams.personprogramarea 
set enddate = '2024-01-25 00:00:00.000', 
	updatedby = 'CDM-37577',
	updatedon = now()
where  personprogramid='9943fbd0-fc6d-4d54-ae56-7e3e57944ca6' and activeflag = 1;

-- Backup
select end_dt,update_user_id,update_ts,removal_id from cjams.tb_client_eligibility where removal_id=303695 and delete_sw = 'N';
-- UPDATE cjams.tb_client_eligibility
-- SET end_dt='2024-02-12', update_user_id='9d0ab8f6-81a3-41a2-b80f-7d22e4ac1da7', update_ts='2024-03-18 13:32:36.822'
-- WHERE removal_id=303695 and delete_sw = 'N';

update cjams.tb_client_eligibility
set end_dt = '2024-01-25',
	update_user_id = 'CDM-37577',
	update_ts = now()
where  removal_id=303695 and delete_sw = 'N';