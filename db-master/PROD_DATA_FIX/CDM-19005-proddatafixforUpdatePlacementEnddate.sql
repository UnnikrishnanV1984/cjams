/*
   Issue Description: CDM-19005
   Category/ Module  : Updating end date in placement table
   
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

--2021-09-30 00:00:00
update placement set enddatetime = '2021-10-01 00:00:00', updatedby = 'CDM-19005', updatedon = now() where placementid = 'eea179c9-202e-48b3-b364-e5a5ea3d5eaa';
update placementrevision set exitdate = '2021-10-01 00:00:00', updatedby = 'CDM-19005', updatedon = now() where placementid = 'eea179c9-202e-48b3-b364-e5a5ea3d5eaa' and activeflag = 1;
-- 2021-09-30
update tb_placement_validation set placement_exit_dt = '2021-10-01', update_user_id = 'CDM-19005', update_ts = current_timestamp  where  placement_id = '1561833';
