/*
 * CDM-35012 - Remove end date
 * Customer Email ID:essence.jones1@maryland.gov
 * Customer Name:Essence Jones
 * Focus Area:Child Removal
 * Description - 211030011899:Please remove the end date 
 * remove the Child removal and OOH program assignment end date.
 * CJAMS PID# : 200824840 (Ayotunde Ajayi)
 * 
*/

UPDATE cjams.intakeservreqchildremoval
SET exitdate=null, removalexitreason=null, updatedby='CDM-35012', updatedon=null, returntransts=null
WHERE intakeservreqchildremovalid='685f5af1-ee00-4cff-bf3b-dfae70a141df';

UPDATE personprogramarea 
SET enddate = null, updatedby = 'CDM-35012', updatedon = now() 
WHERE personprogramid = '3d4fb73c-05f0-4520-b38b-0491d7c185ed';

--select removal_id, end_dt, * from tb_client_eligibility where case_id = '211030011899' and client_id = '200824840';
--select removalid ,* from intakeservreqchildremoval where intakeservreqchildremovalid='685f5af1-ee00-4cff-bf3b-dfae70a141df';
update tb_client_eligibility
set end_dt = null,
    update_user_id = 'CDM-35012',
    update_ts = now()
where removal_id = 253028;
