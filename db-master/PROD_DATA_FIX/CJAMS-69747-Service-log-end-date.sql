/*
   Issue Description: CJAMS-69747 Case Closing
   Category/ Module  :Services
   Root cause : user request to update service log end date
    Please do the needful Data fix to end the service log as there is an existing service log with the same duration with the same provider

                Provider ID - 5034072, start date 7/14 23 and End date 7/14/23
   Resolution: Updated end date to the specified service log end date
   Pull request# for code fix: 
   Reason why no related code fix: 
   requested a data fix to resolve:
*/

update tb_service_log 
set end_dt ='2026-07-02',end_service_reason_cd = '1824', -- Service Completed
update_ts =now(),update_user_id ='CJAMS-69747' 
where service_log_id='3540753' and provider_service_id='158345';