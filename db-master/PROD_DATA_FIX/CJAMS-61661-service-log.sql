/*
   Issue Description: Not able to close service log due to no Out of Home program assignment during the time of this service log.
   Category/ Module  : service log
   Root cause:The client program is ended prior to the latest purchase authorization end-date in the service log. So data fix is needed to ended the respective open service log with 11/23/2021.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update tb_service_log set end_dt = '2021-11-23', 
update_user_id = 'CJAMS-61661', 
update_ts = now(),
end_service_reason_cd = '1824'
where service_log_id = '2020886'
and delete_sw = 'N';