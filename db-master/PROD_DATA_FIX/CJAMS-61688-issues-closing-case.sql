/*
   Issue Description: CJAMS-61688
   Category/ Module  : service log
   Root cause: THere is open service log for 211030012191 and Unable to close case.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update tb_service_log set end_dt = '2022-12-01', 
update_user_id = 'CJAMS-61688', 
update_ts = now(),
end_service_reason_cd = '1824'
where service_log_id = '2087805'
and delete_sw = 'N';