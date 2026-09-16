/*
   Issue Description: CDM-38619 Closing Case Case # 211030012664 Im signed in as a worker and Im not able to close out these 2 service logs
   Category/ Module  : CPS case and purchase auth dates 
   Root cause: user Unable to make changes in the endate of service logs as case was closed
   Fix Provided: Case is closed without closing removal and placement.
   Data fix has been promoted to enddate the service logs for the case Client ID: 3724684 Provider ID: 5063371 & 5088509 
*/





--Client ID: 3724684 
--Provider ID: 5063371
update tb_service_log
set end_dt = '2024-03-28',
    update_ts = now(), 
    update_user_id = 'CDM-38619',
    end_service_reason_cd = '1824' 
   where service_log_id ='2026964';


--Provider ID: 5088509
   update tb_service_log
    set end_dt = '2024-02-16',
    update_ts = now(), 
    update_user_id = 'CDM-38619',
    end_service_reason_cd = '1824' 
   where service_log_id ='2063781';