/*
   Issue Description: CDM-39197- service log end date
   Category/ Module  : Service log
   Root cause: User error
   Fix Provided: Data fix to update the end date requested by user
*/
update tb_service_log
set end_dt = '2023-10-31', estimated_end_dt =  '2023-10-31',end_service_reason_cd = '1824', update_ts = now(), update_user_id = 'CDM-39197'
where service_log_id = '2209820'; 