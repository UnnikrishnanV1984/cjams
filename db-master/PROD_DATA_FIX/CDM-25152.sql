/*
   Issue Description: CDM-25152
   Category/ Module  : End date and Reason for ending added to service log
   Root cause: userwants to close the provider service by adding end date 
   Pull request# for code fix:5630
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



update cjams.tb_service_log set end_dt  ='2020-12-21', update_ts = now(), update_user_id = 'CDM-25152'

where service_log_id ='1981539' and delete_sw  = 'N' ;