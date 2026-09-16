/*
   Issue Description: CDM-39404
   Category/ Module  : Service Log
   Root cause: Service log overlapping issue
   Pull request# for code fix: Code fix has been done to retrict creation of servic elog with overlapping dates
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE cjams.tb_service_log
SET end_dt='2022-10-03', end_service_reason_cd='1823', update_ts=now(), update_user_id='CDM-39404', estimated_end_dt='2022-10-03'
WHERE service_log_id=976282;

UPDATE cjams.tb_service_log
SET end_dt='2020-02-26', end_service_reason_cd='1823', update_ts=now(), update_user_id='CDM-39404', estimated_end_dt='2020-02-26'
WHERE service_log_id in (2003154, 2003153, 2003155);

UPDATE cjams.tb_service_log
SET end_dt='2019-12-31', end_service_reason_cd='1823', update_ts=now(), update_user_id='CDM-39404', estimated_end_dt='2019-12-31'
WHERE service_log_id=909364;