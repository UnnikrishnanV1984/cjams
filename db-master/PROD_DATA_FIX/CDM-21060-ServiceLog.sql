/*
   Issue Description: CDM-21060
   Category/ Module  : Service log 
   Root cause: user wants to add end date in service log
   Pull request# for code fix: 5024
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update tb_service_log set end_dt = '2022-03-02', update_ts = now(),update_user_id = 'CDM-21060' where service_log_id = '2012602';