/*
 * CJAMS-59452
 * Customer Email ID:wanda.nolt@maryland.gov
 * Focus Area:Services: OOH and child removal.
    Case # 211030012625
    CJAMS PID - 4019290 , 200850057
    Need to delete the child removal end date and set to NULL, and program assignment is also set to Null. * to have the end date taken off of the removal so the placement can be entered and GAP completed. 
 * remove the child removal end date as requested.
 * 
 *
 */

-- For 4019290
UPDATE cjams.intakeservreqchildremoval
SET exitdate=NULL, returntransts=NULL,removalexitreason = null, updatedby='CJAMS-59452', updatedon=now() 
WHERE intakeservreqchildremovalid='4c1cb35d-1ad8-48ee-b3b1-0d7d2beaf62a';

--Nullifying end date in intakeserreqchildremoval_history
update intakeservreqchildremoval_history
set exitdate = null,removalexitreason=null,  updatedby = 'CJAMS-59452', updatedon = now()
where  intakeservreqchildremovalid = '4c1cb35d-1ad8-48ee-b3b1-0d7d2beaf62a'
and activeflag = 1;

--Nullifying end date in personprogramarea
update personprogramarea
set enddate = null, updatedby = 'CJAMS-59452', updatedon = now()
where personprogramid = 'b31cf6ff-7a54-4497-b64b-b4c99d5b0d0b' and activeflag = 1;

--Nullifying end date in client eligibility

update tb_client_eligibility
set end_dt = null, update_user_id = 'CJAMS-59452', update_ts = now()
where client_id = 4019290 and eligibility_id = 10004101;

-- For 200850057

UPDATE cjams.intakeservreqchildremoval
SET exitdate=NULL, returntransts=NULL,removalexitreason = null, updatedby='CJAMS-59452', updatedon=now() 
WHERE intakeservreqchildremovalid='b3e47f4c-d4b0-46b1-b8de-d91e3a111a1a';

--Nullifying end date in intakeserreqchildremoval_history

update intakeservreqchildremoval_history
set exitdate = null,removalexitreason = null, updatedby = 'CJAMS-59452', updatedon = now()
where  intakeservreqchildremovalid = 'b3e47f4c-d4b0-46b1-b8de-d91e3a111a1a'
and activeflag = 1;

--Nullifying end date in personprogramarea
--select * from personprogramarea p where personid = 'd11f33f5-80a0-425c-ad19-62ff73f83f36' and activeflag =1;
update personprogramarea
set enddate = null, updatedby = 'CJAMS-59452', updatedon = now()
where personprogramid = '6dfa0d23-d50d-404c-9117-1329bf44b9c3' and activeflag = 1;

--select * from tb_client_eligibility tce where client_id = 200850057
update tb_client_eligibility
set end_dt = null, update_user_id = 'CJAMS-59452', update_ts = now()
where client_id = 200850057 and eligibility_id = 10004102;