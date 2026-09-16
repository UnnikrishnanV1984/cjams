/*
   Issue Description: 3225917:Please end date service log 6234204. I am unable to do it from my end. 
   Category/ Module  : service log
   Root cause: As per system design, the service log can not be ended prior to the latest purchase authorization end date and beyond the selected client program date period.
    In this case, the client program is ended prior to the latest purchase authorization end-date in the service log. So data fix is needed to ended the respective open service log with 08/21/2025.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update tb_service_log set end_dt = '2025-08-21', 
estimated_end_dt = '2025-08-21',
update_user_id = 'CJAMS-62355', 
update_ts = now(),
end_service_reason_cd = '1824'
where service_log_id = '3758270'
and delete_sw = 'N';