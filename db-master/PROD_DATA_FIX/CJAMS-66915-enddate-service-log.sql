/*
   Issue Description: CJAMS-66915 Closing Case Service Logs
   Category/ Module  : CPS case and purchase auth dates 
   Root cause: user Unable to make changes in the endate of denied service logs
   Fix Provided: end dated the service logs as requested by user
   Data fix has been promoted to enddate the service logs for the providerid: 5033366 and client 4437928
*/


update tb_service_log
set end_dt='2025-07-31', end_service_reason_cd = '1824', update_user_id ='CJAMS-66915', update_ts=now()
where client_id='4437928' and case_id='251030505884' and service_log_id ='3724593';

update tb_service_log
set end_dt='2025-09-30', end_service_reason_cd = '1824', update_user_id ='CJAMS-66915', update_ts=now()
where client_id='4437928' and case_id='251030505884' and service_log_id ='3724594';