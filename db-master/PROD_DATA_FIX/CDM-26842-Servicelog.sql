/*
   Issue Description: CDM-26842
   Category/ Module  : servicelog 
   Root cause: userwants to close the provider service by adding end date and reason for ending
   Pull request# for code fix:5630
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update cjams.tb_service_log set end_dt='2022-11-21', update_ts= now(), update_user_id='CDM-26842'

where service_log_id='2065757';