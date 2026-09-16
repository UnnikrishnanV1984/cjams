/*
   Issue Description: CDM-39461- service log end date
   Category/ Module  : Service log
   Root cause:
   Fix Provided: Data fix to update the end date requested by user
*/

update tb_service_log
set end_dt='2023-07-31',estimated_end_dt = '2023-07-31',end_service_reason_cd = '1824',update_user_id='CDM-39461',update_ts=now()
where service_log_id=1998241 ;


