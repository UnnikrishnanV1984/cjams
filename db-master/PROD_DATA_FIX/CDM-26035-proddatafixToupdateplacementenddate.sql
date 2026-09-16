/*
   Issue Description: CDM-25695
   Category/ Module  : Prod data fix to Revert ACA Redetermination details
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

-- 2022-06-30 00:00:00 11:00
update placement set enddatetime = '2022-07-01 00:00:00',endtime = '07:59', updatedby = 'CDM-26035', updatedon =  now()
where placementid = 'ab52e6e2-4152-4fd0-94eb-694640e7b38f';
update placementrevision set exitdate = '2022-07-01 00:00:00', updatedby = 'CDM-26035', updatedon = now() where placementid = 'ab52e6e2-4152-4fd0-94eb-694640e7b38f';
update tb_placement_validation set placement_exit_dt = '2022-07-01', update_user_id = 'CDM-26035', update_ts = current_timestamp  where 
placement_id = '1573460';