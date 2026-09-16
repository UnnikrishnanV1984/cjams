
/*
   Issue Description: CDM-20568
   Category/ Module  : Removing placement End date
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

--2022-01-13 00:00:00	12:00
update placement set enddatetime = null, endtime = null, updatedby = 'CDM-20568', updatedon = now() where placementid = '91aba6f9-a4a1-4571-940b-6f7c3bf82682';
update placementrevision set exitdate = null, exittime = null, updatedby = 'CDM-20568', updatedon = now() where placementid = '91aba6f9-a4a1-4571-940b-6f7c3bf82682' and activeflag = 1;
-- 2022-01-13
update tb_placement_validation set placement_exit_dt = null, update_user_id = 'CDM-20568', update_ts = current_timestamp  where  placement_id = '1567806';


-- 2022-01-13 17:00:44
update intakeservreqchildremoval set exitdate = null, updatedby = 'CDM-20568', updatedon = now()
where intakeservreqchildremovalid = '45b5c8f2-efbd-4eca-94ab-c6ff55daa2d0';
-- 2022-01-13
update personprogramarea set enddate = null, updatedby = 'CDM-20568', updatedon = now() 
where personprogramid = '099d3e38-406a-4a36-be7c-66106fadf9cb';

