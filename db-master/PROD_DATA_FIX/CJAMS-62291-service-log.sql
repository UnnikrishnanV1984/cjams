/*
   Issue Description: The calendar is not recognizing the last date of authorization.
   Category/ Module  : service log
   Root cause:user requested to end service log end date
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update tb_service_log set end_dt = '2025-03-07', 
estimated_end_dt = '2025-03-07',
update_user_id = 'CJAMS-62291', 
update_ts = now(),
end_service_reason_cd = '1824'
where service_log_id = '3225852'
and delete_sw = 'N';