/*
   Issue Description: CDM-39318
   Category/ Module  : Service Log
   Root cause: Service log overlapping issue
   Pull request# for code fix: Code fix has been done to retrict creation of servic elog with overlapping dates
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE cjams.tb_service_log
SET end_dt='2022-10-12', end_service_reason_cd='1823', update_ts=now(), update_user_id='CDM-39318', estimated_end_dt='2022-10-12'
WHERE service_log_id=2044379;