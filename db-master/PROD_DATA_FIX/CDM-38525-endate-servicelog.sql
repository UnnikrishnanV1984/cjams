/*
   Issue Description: CDM-38525 Closing Case Service Logs
   Category/ Module  : CPS case and purchase auth dates 
   Root cause: user Unable to make changes in the endate of service logs as case was closed
   Fix Provided: Case is closed without closing removal and placement.
   Data fix has been promoted to enddate the service logs for the case 3303182 and client 3820727
*/


update tb_service_log 
set end_dt='2023-08-09',
    end_service_reason_cd = '1824',  
    update_ts=now(),
    update_user_id='CDM-38525' 
where service_log_id= '2299167'
and client_id = 3820727
and case_id = 3303182;