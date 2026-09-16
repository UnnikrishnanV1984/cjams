/*
   Issue Description: CDM-33246
   Category/ Module  : Services
   Root cause: actual enddate is missing
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update tb_service_log set end_dt ='2023-2-15' ,update_ts =now() ,update_user_id ='CDM-33246' where service_log_id ='2028942' and client_id ='4425019';