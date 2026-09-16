/*
   Issue Description: CDM-37823
   Category/ Module  :Service End Date Change
   Root cause:  end dated for 3/15/24 Can this be changed to 3/14/24 so we can move forward with end dating the removal for 3/14/24
   Pull request# for code fix: na
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

select * from tb_service_log
where provider_service_id = '248020' and service_log_id = '2457339';

update tb_service_log set end_dt = '2024-03-14', update_user_id = 'CDM-37823', update_ts = now() 
where service_log_id = '2457339';