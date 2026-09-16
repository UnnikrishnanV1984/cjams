/*
   Issue Description: Case was closed on 07/12/2022 and there is an open service log available for the respective client & provider.
   3164187:Unable to locate service log in service case 3164187 that is preventing provider 5023359 closure.
   Category/ Module  : service log
   Root cause:user requested to end service log end dates
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
update tb_service_log set end_dt = '2015-11-13', 
estimated_end_dt = '2015-11-13',
update_user_id = 'CJAMS-61653', 
update_ts = now(),
end_service_reason_cd = '1824'
where service_log_id = '686502'
and delete_sw = 'N';