/*
   Issue Description: CDM-21249
   Category/ Module  : Child Removal/Placement
   Root cause: user wants to end date removal and placement 
   Pull request# for code fix: 5028
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/

update tb_service_log set end_dt = '2022-02-04', update_ts = now(),update_user_id = 'CDM-21249' where service_log_id = '1981301';
update tb_service_log set end_dt = '2022-02-04', update_ts = now(),update_user_id = 'CDM-21249' where service_log_id = '1981299';

update tb_service_log set end_dt = '2022-02-04', update_ts = now(),update_user_id = 'CDM-21249' where service_log_id = '1981300';