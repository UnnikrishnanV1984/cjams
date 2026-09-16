/*
   Issue Description: CDM-26022
   Category/ Module  : Prod data fix to update placement end date
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

-- 2021-04-15 00:00:00.000
update placement set enddatetime = '2021-04-14 00:00:00.000', updatedby = 'CDM-26022', updatedon =  now()
where placementid = 'ec0bbf17-60f1-4227-9b2d-8cfdad999bfa';
update placementrevision set exitdate = '2021-04-14 00:00:00.000', updatedby = 'CDM-26022', updatedon = now() 
where placementid = 'ec0bbf17-60f1-4227-9b2d-8cfdad999bfa'
and activeflag = 1;
update tb_placement_validation set placement_exit_dt = '2021-04-14', update_user_id = 'CDM-26022', update_ts = current_timestamp  where 
placement_id = '1563816';
