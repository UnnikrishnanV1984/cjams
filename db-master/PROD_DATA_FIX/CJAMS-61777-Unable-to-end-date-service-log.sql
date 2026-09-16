/*
   Issue Description: CJAMS-61777
   Category/ Module  : service log
   Root cause:user requested to end service log end dates
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
UPDATE tb_service_log
SET end_dt = '2022-11-28'::date ,
    update_ts = now(),
    update_user_id = 'CJAMS-61777',
    end_service_reason_cd = '1824'
WHERE service_log_id = '2141804'
    and delete_sw = 'N';