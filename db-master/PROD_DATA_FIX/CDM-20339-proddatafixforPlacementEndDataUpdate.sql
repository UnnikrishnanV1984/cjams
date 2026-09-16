
/*
   Issue Description: CDM-19973
   Category/ Module  : Updating Placement End date
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


--2021-07-31 00:00:00
update placement set enddatetime = '2021-08-01 00:00:00', updatedby = 'CDM-20339', updatedon = now() where placementid = '37c512c6-db3b-4873-860a-6b3d074eecd1';
update placementrevision set exitdate = '2021-08-01 00:00:00', updatedby = 'CDM-20339', updatedon = now() where placementid = '37c512c6-db3b-4873-860a-6b3d074eecd1' and activeflag = 1;
--2021-07-31
update tb_placement_validation set placement_exit_dt = '2021-08-01', update_user_id = 'CDM-20339', update_ts = current_timestamp  where  placement_id = '1558777';
