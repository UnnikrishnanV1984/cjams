
/*
   Issue Description: CDM-19973
   Category/ Module  : Updating Placement End date
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


--2021-10-05 00:00:00
update placement set enddatetime = '2020-10-08 00:00:00', updatedby = 'CDM-19973', updatedon = now() where placementid = 'add8e81b-10c4-494e-a2b9-7575e3af3cdd';
update placementrevision set exitdate = '2020-10-08 00:00:00', updatedby = 'CDM-19973', updatedon = now() where placementid = 'add8e81b-10c4-494e-a2b9-7575e3af3cdd' and activeflag = 1;
-- 2021-10-05
update tb_placement_validation set placement_exit_dt = '2020-10-08', update_user_id = 'CDM-19973', update_ts = current_timestamp  where  placement_id = '1556955';
