
/*
   Issue Description: CDM-20026
   Category/ Module  : Updating Placement End date
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



-- 2021-12-08 00:00:00
update placement set enddatetime = '2021-07-28 00:00:00', updatedby = 'CDM-20026', updatedon = now() where placementid = '54987f9d-e737-4291-b3d2-69ef38de6a7f';
update placementrevision set exitdate = '2021-07-28 00:00:00', updatedby = 'CDM-20026', updatedon = now() where placementid = '54987f9d-e737-4291-b3d2-69ef38de6a7f' and activeflag = 1;
-- 2021-08-10
update tb_placement_validation set placement_exit_dt = '2021-07-28', update_user_id = 'CDM-20026', update_ts = current_timestamp  where  placement_id = '1566014' and delete_sw = 'N';
