/*
   Issue Description: CDM-22449
   Category/ Module  : Prod data fix to update purchase auth dates
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

--2022-04-27, 2022-04-27
update tb_service_log set start_dt = '2022-04-26', end_dt = '2022-04-26', update_ts = now() , update_user_id = 'CDM-22499'
where service_log_id = '2042094';

--2022-04-27, 2022-04-27
update tb_service_purchase_authorization
set start_dt = '2022-04-26', end_dt = '2022-04-26', update_ts = now() , update_user_id = 'CDM-22499'
where authorization_id = '1831622';
