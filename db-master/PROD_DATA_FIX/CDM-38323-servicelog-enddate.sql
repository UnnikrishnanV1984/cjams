/*
   Issue Description: CDM-38323 Case Closing
   Category/ Module  :Services
   Root cause : user request to update service log end date
   Resolution: Updated end date to the specified service log end date
   Pull request# for code fix: 
   Reason why no related code fix: 
   requested a data fix to resolve:
*/
select end_dt,* from tb_service_log where service_log_id='2935608';

update tb_service_log set end_dt ='2023-12-22',update_ts =now(),update_user_id ='CDM-38323' where service_log_id='2935608';

select end_dt,* from tb_service_log where service_log_id='1992434';

update tb_service_log set end_dt ='2024-03-27',update_ts =now(),update_user_id ='CDM-38323' where service_log_id='1992434';