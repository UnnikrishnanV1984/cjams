/* 
    Issue Description: CDM-38980
   Category/ Module  : Services:service log
   Root cause: user request to add the end date 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


UPDATE tb_service_log
SET end_dt = '2023-06-30'::date ,
    update_ts = now(),
    update_user_id = 'CDM-38980',
    end_service_reason_cd = '1824'
WHERE service_log_id = '2063667'
    and delete_sw = 'N';