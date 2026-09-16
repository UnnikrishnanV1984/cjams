/*
   Issue Description: CJAMS-67176 Closing Case Service Logs
   Category/ Module  : CPS case and purchase auth dates 
   Root cause: the client program is ended prior to the latest purchase authorization end-date in the service log.
   Fix Provided: end dated the service logs as requested by user
   Data fix has been promoted to enddate the service logs for the providerid: # 6002534 , # 6091776  and client # 202304237
*/


update tb_service_log
set end_dt='2025-11-21', end_service_reason_cd ='1824', update_user_id='CJAMS-67176', update_ts=now()
where client_id='202304237' AND case_id='231030242499' and service_log_id ='3895758';

update tb_service_log
set end_dt='2025-11-30', end_service_reason_cd ='1824', update_user_id='CJAMS-67176', update_ts=now()
where client_id='202304237' AND case_id='231030242499' and service_log_id ='3818423';
