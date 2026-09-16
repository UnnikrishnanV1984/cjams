/*
   Issue Description: 3164469:I am having trouble closing a case due to not being able to end date the flex fund on 8/30/2022.
   Category/ Module  : service log
   Root cause:As per system design, duplicate or multiple service logs can not be created on the same date period for the same client ID, Provider/Vendor ID and Service.
    CJAMS application is currently not allowing the users to create a new service log or end date the service log if there is an open or overlapping with the prior service log begin & end date.
    In this case, the service log can not be ended as there is an overlapping prior service log so data fix is needed to end the service log with the latest purchase authorization end date (08/30/2022)
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update tb_service_log set end_dt = '2022-08-30', 
start_dt = '2022-08-30',
estimated_start_dt = '2022-08-30',
estimated_end_dt = '2022-08-30',
update_user_id = 'CJAMS-63038', 
update_ts = now(),
end_service_reason_cd = '1824'
where service_log_id = '2677824'
and delete_sw = 'N';