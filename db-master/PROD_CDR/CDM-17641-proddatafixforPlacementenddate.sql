
/*
   Issue Description: CDM-17641
   Category/ Module  :  Case placement fix
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
-- 2021-09-29 00:00:00
update placement set enddatetime = '2021-07-29 00:00:00', updatedby = 'CDM-17461', updatedon = now() where placementid = 'ba85d49b-e113-4014-95fe-c74088730327';
update placementrevision set exitdate =  '2021-07-29 00:00:00' , updatedby = 'CDM-17461', updatedon = now() where placementid = 'ba85d49b-e113-4014-95fe-c74088730327' and activeflag = 1;
--2021-09-29
update tb_placement_validation set placement_exit_dt = '2021-07-29', update_user_id = 'CDM-17461', update_ts = now() where placement_id = '1566924';
update tb_placement_validation set delete_sw = 'Y', update_user_id = 'CDM-17461', update_ts = now() where placement_validation_id in ('1974553', '1974552');
