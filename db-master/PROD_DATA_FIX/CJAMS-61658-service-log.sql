/*
   Issue Description: 221030019289:Not able to close service log due to overlapping dates with another log. 
   Category/ Module  : service log
   Root cause:As per system design, A duplicate or multiple service logs can not be created with the same date period for the same client ID, Provider/Vendor ID and Service. CJAMS application is not allowing the users to create a new service log or end date the service log if there is an open service log or overlapping date with the prior service log begin & end date.
    In this case, the respective service log can not be ended with 03/21/2023 (latest purchase authorization end-date) as there is another service log created with begin & end date is 02/23/2023.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update tb_service_log set end_dt = '2023-03-21', 
estimated_end_dt = '2023-03-21',
update_user_id = 'CJAMS-61658', 
update_ts = now(),
end_service_reason_cd = '1824'
where service_log_id = '2064816'
and delete_sw = 'N';