/*
   Issue Description: CDM-36096
   Category/ Module  : Need log dates changed to close child removal 
   Root cause: User requested to update start and end date.
   Resolution: Updated start and end date requested by user.
   Pull request# N/A
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: data fix
*/

select * from tb_service_log
where provider_service_id = '171282' and service_log_id = '2883927';

update tb_service_log set start_dt='2023-12-05', end_dt = '2023-12-05', update_user_id = 'CDM-36096', update_ts = now() 
where service_log_id = '2883927';