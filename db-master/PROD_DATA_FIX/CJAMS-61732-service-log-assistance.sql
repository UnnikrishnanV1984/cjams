/*
   Issue Description: CJAMS-61732
   Category/ Module  : service log
   Root cause:user requested to end service log end dates
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update tb_service_log set end_dt = '2024-02-28', 
update_user_id = 'CJAMS-61732', 
update_ts = now()
where service_log_id = '3061704'
and delete_sw = 'N';