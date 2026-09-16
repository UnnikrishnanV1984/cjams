/*
   Issue Description: CDM-40234
   Category/ Module  : service log
   Root cause: user requested to end service log date
   Pull request# for code fix: 5028
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/


update tb_service_log set end_dt = '2020-02-29', 
update_user_id = 'CDM-40234', 
update_ts = now(),
end_service_reason_cd = '1824'
where service_log_id = '916555'
and delete_sw = 'N';
