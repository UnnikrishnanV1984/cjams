/*
   Issue Description: CJAMS-61652
   Category/ Module  : service log
   Root cause: THere is open service log for the provider 5094985, preventing for the provider closer.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update tb_service_log set end_dt = '2020-03-16', 
update_user_id = 'CJAMS-61652', 
update_ts = now(),
end_service_reason_cd = '1824'
where service_log_id = '981397'
and delete_sw = 'N';