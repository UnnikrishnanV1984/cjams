/*
   Issue Description: CDM-44117
   Category/ Module  : Purchase auth dates
   Root cause: User requested to update purchase auth dates and service log dates
   Pull request# for code fix: 
   Reason why no related code fix: User Error
*/


update tb_service_purchase_authorization
set start_dt = '2024-11-19', end_dt = '2025-01-30', update_ts = now() , update_user_id = 'CDM-44117'
where authorization_id = '3688740';

update tb_service_log set start_dt = '2024-11-19', end_dt ='2025-01-30',update_user_id = 'CDM-44117',
update_ts = now()  where service_log_id = '3552308';