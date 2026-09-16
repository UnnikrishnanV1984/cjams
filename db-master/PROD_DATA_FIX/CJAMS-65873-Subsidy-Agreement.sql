/*
-- Issue Description:  End Date Issue
-- Case ID:    
-- Category/ Module: 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update personprogramarea
set enddate = null, updatedby = 'CJAMS-65873', updatedon = now()
where personprogramid = '71ac20d9-213f-4516-a9ae-c169561ffb51' and activeflag = 1;

UPDATE intakeservreqchildremoval 
SET exitdate=null, 
returntransts = Null,
returndate = Null,
returntime = Null,
removalexitreason = NULL ,
    updatedby='CJAMS-65873',
    updatedon=now() 
WHERE intakeservreqchildremovalid = 'b76e94b7-1c8a-45da-aac5-ec07d24d7242' and activeflag = 1;


update tb_client_eligibility
set end_dt = null,
	update_user_id = 'CJAMS-65873',
	update_ts = now()
where removal_id in ('324152')
	and delete_sw  = 'N' ;

update placement 
set enddatetime = null, endtime = null, updatedon = now(), 
updatedby = 'CJAMS-65873' 
where placementid in ('76d2883b-f668-46fc-9af8-c264ad42c24a') and activeflag = 1;

update placementrevision 
set exitdate = null, exittime = null, updatedon = now(), 
updatedby = 'CJAMS-65873' 
where placementid in ('76d2883b-f668-46fc-9af8-c264ad42c24a') and activeflag = 1;


update tb_placement_validation 
set placement_exit_dt = null, update_user_id = 'CJAMS-65873', update_ts = now() 
where placement_id  in (2179277) and delete_sw = 'N';

