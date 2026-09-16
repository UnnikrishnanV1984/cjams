/*
   Issue Description: CDM-40020
   Category/ Module  : service log
   Root cause:user requested to end service log end dates
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


UPDATE tb_service_log
SET end_dt = '2023-04-05'::date ,
    update_ts = now(),
    update_user_id = 'CDM-40020',
    end_service_reason_cd = '1824'
WHERE service_log_id = '1974747'
    and delete_sw = 'N';
   
   UPDATE tb_service_log
SET end_dt = '2018-03-08'::date ,
    update_ts = now(),
    update_user_id = 'CDM-40020',
    end_service_reason_cd = '1824'
WHERE service_log_id = '848749'
    and delete_sw = 'N';
  
   UPDATE tb_service_log
SET end_dt = '2022-04-17'::date ,
    update_ts = now(),
    update_user_id = 'CDM-40020',
    end_service_reason_cd = '1824'
WHERE service_log_id = '1971463'
    and delete_sw = 'N';
