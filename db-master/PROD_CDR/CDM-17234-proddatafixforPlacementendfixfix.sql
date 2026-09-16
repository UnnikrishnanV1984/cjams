 /*
  Issue Description: CDM-17234
   Category/ Module  :  Updating end date 
   Root cause: user asked to update it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/




-- 11:00 2020-10-22 00:00:00	12:41
update placement set starttime = '11:30', enddatetime = '2020-10-21 00:00:00', endtime  = '12:30', updatedon = now() , updatedby = 'CDM-17234' where placementid  = '2ba77722-144c-4dd3-98da-687ccc581405';

-- 11:00 2020-10-22 00:00:00	12:41
update placementrevision set entrytime  = '11:30', exitdate = '2020-10-21 00:00:00', exittime  = '12:30', updatedby = 'CDM-17234', updatedon = now() where placementid  = '2ba77722-144c-4dd3-98da-687ccc581405' and activeflag = 1;
-- 2020-10-22
update tb_placement_validation set placement_exit_dt = '2020-10-21', update_ts = now(), update_user_id = 'CDM-17234' where placement_id  = '1558506'
