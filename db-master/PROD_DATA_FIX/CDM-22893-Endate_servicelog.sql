/*
   Issue Description: CDM-22893
   Category/ Module  : End date and Reason for ending added to service log
   Root cause: userwants to close the provider service by adding end date and reason for ending
   Pull request# for code fix:5630
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update tb_service_log set end_dt = '2022-05-12', end_service_reason_cd ='1823', update_ts = now(),update_user_id = 'CDM-22893'
where service_log_id = '835006';