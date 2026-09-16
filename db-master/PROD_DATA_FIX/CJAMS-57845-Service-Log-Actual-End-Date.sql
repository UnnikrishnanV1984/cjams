/*
   Issue Description: CIDM-57845- service log end date
   Category/ Module  : Service log
   Root cause:
   Fix Provided: Data fix to update the end date requested by user
*/

update tb_service_log
set end_dt='2024-10-04',estimated_end_dt = '2024-10-04',end_service_reason_cd = '1824',update_user_id='CJAMS-57845',update_ts=now()
where service_log_id=1997142 and delete_sw ='N';