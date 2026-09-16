/*
   Issue Description: CDM-40819 
   Category/ Module  :Services
   Root cause : user request to update service log end date
   Resolution: Updated end date to the specified service log end date
   Pull request# for code fix: 
   Reason why no related code fix: 
   requested a data fix to resolve:
*/

update tb_service_log
set end_dt = '2023-07-02'::date, update_ts = now(), end_service_reason_cd = '1824',update_user_id = 'CDM-40819' 
where service_log_id = 2058785 and case_id = 3176522 and client_id = 2708572;