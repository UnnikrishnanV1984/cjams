/*
   Issue Description: CJAMS-57624
   Category/ Module  : service log
   Root cause: Data fix to update Service log Estimated End Date to 02/28/2025.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update tb_service_log set end_dt = '2025-02-28', update_user_id = 'CJAMS-57624', update_ts = now() 
where service_log_id = '2095607';